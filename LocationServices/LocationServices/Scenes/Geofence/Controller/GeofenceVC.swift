//
//  GeofenceVC.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import UIKit
import SnapKit
import CoreLocation
import MapLibre

final class GeofenceVC: UIViewController {
    weak var delegate: GeofenceNavigationDelegate?
    var directioButtonHandler: VoidHandler?
    private var isInSplitViewController: Bool { delegate is SplitViewGeofencingMapCoordinator }
    
    private lazy var headerView: GeofenceDashboardHeaderView = {
        let view = GeofenceDashboardHeaderView(containerTopOffset: 25)
        view.backgroundColor = .searchBarBackgroundColor
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(openGeofenceDashboard))
        view.addGestureRecognizer(tap)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(openGeofenceDashboard))
        view.addGestureRecognizer(pan)
        return view
    }()
    
    private let grabberIcon: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .searchBarTintColor
        button.layer.cornerRadius = 2.5
        return button
    }()
    
    var viewModel: GeofenceViewModelProtocol!
    private let authActionsHelper = AuthActionsHelper()
    
    private var geofenceMapView: GeofenceMapView = GeofenceMapView()
    private(set) var userCoreLocation: CLLocationCoordinate2D?
    
    private lazy var locationManager: LocationManager = {
        let locationManager = LocationManager(alertPresenter: self)
        locationManager.setDelegate(self)
        return locationManager
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        authActionsHelper.delegate = delegate
        setupNotification()
        setupHandlers()
        hideKeyboardWhenTappedAround()
        geofenceMapView.delegate = self
        geofenceMapView.hideSearchView()
        view.backgroundColor = .white
        setupNotifications()
        locationManagerSetup()
        setupViews()
        changeHeaderVisibility(isHidden: false)
        geofenceMapView.setupTapGesture()
    }
    
    func setupHandlers() {
        headerView.addButtonHandler = { [weak self] in
            guard let self = self else { return }
            self.authActionsHelper.tryToPerformAuthAction {
                self.showAddGeofence(lat: self.userCoreLocation?.latitude,
                                     long: self.userCoreLocation?.longitude)
            }
        }
    }
    
    private func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateMapLayerItems(_:)), name: Notification.updateMapLayerItems, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateMapLayerPosition(_:)), name: Notification.geofenceMapLayerUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(authorizationStatusChanged(_:)), name: Notification.authorizationStatusChanged, object: nil)
    }
    
    private func setupKeyboardNotifications() {
        guard isInSplitViewController else { return }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotifications() {
        guard isInSplitViewController else { return }
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func updateMapLayerItems(_ notification: Notification) {
        guard !isInSplitViewController else { return }
        DispatchQueue.main.async {
            let size = self.view.bounds.size.height / 2 - 20
            let offset:CGFloat = (notification.userInfo?["height"] as? CGFloat) ?? size
            self.geofenceMapView.updateBottomViewsSpacings(additionalBottomOffset: offset)
        }
    }
    
    @objc override func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let additionalOffset = keyboardSize.height - view.safeAreaInsets.bottom
        geofenceMapView.updateBottomViewsSpacings(additionalBottomOffset: additionalOffset)
    }
    
    @objc override func keyboardWillHide(notification: NSNotification) {
        geofenceMapView.updateBottomViewsSpacings(additionalBottomOffset: 0)
    }
    
    
    @objc private func updateMapLayerPosition(_ notification: Notification) {
        guard !isInSplitViewController else { return }
        geofenceMapView.updateBottomViewsSpacings(additionalBottomOffset: 0)
    }
    
    @objc private func authorizationStatusChanged(_ notification: Notification) {
        Task {
            await self.viewModel.fetchListOfGeofences()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        geofenceMapView.reloadMap()
        Task {
            await viewModel.fetchListOfGeofences()
        }
        setupKeyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //give time for location manager to retrieve last user position
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: { [weak self] in
            self?.openGeofenceDashboard()
        })
        NotificationCenter.default.addObserver(self, selector: #selector(tabSelected(_:)), name: Notification.tabSelected, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(enableGeofenceDrag(_:)), name: Notification.enableGeofenceDrag, object: nil)
        
    }
    
    @objc func enableGeofenceDrag(_ notification: Notification){
        geofenceMapView.mapView.enableGeofenceDrag = notification.userInfo?["enableGeofenceDrag"] as? Bool ?? false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: Notification.tabSelected, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.enableGeofenceDrag, object: nil)
    }
    
    func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(refreshGeofence(_:)), name: Notification.refreshGeofence, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(refreshMapView(_:)), name: Notification.refreshMapView, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(drawCircleOnMapView(_:)), name: Notification.geofenceEditScene, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deleteGeofence(_:)), name: Notification.deleteGeofenceData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(addGeofence(_:)), name: Notification.geofenceAdded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(deselectMapAnnotation(_:)), name: Notification.deselectMapAnnotation, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(geofenceAppearanceChanged(_:)), name: Notification.geofenceAppearanceChanged, object: nil)
    }
    
    @objc private func refreshMapView(_ notification: Notification) {
        geofenceMapView.reloadMap()
    }
    
    @objc private func refreshGeofence(_ notification: Notification) {
        if let hardRefresh = notification.userInfo?["hardRefresh"] as? Bool,
           hardRefresh {
            geofenceMapView.removeAllAnnotations()
            Task {
                await viewModel.fetchListOfGeofences()
            }
        } else {
            geofenceMapView.showExistedGeofences()
        }
    }
    
    @objc private func openGeofenceDashboard() {
        authActionsHelper.tryToPerformAuthAction { [weak self] in
            guard let self else { return }
            let size = self.view.bounds.size.height / 2 - 60
            if !isInSplitViewController {
                self.geofenceMapView.updateBottomViewsSpacings(additionalBottomOffset: size)
            }
            delegate?.showDashboardFlow(geofences: self.viewModel.geofences, lat: self.userCoreLocation?.latitude, long: self.userCoreLocation?.longitude)
        }
    }
    
    @objc private func drawCircleOnMapView(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            if let model = notification.userInfo?["geofenceModel"] as? GeofenceDataModel, let radius = model.radius {
                self?.geofenceMapView.drawGeofenceCirle(id: model.id,
                                                        lat: model.lat,
                                                        long: model.long,
                                                        radius: radius,
                                                        title: model.name)
            }
        }
    }
    
    @objc private func deleteGeofence(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            if let id = notification.userInfo?["id"] as? String {
                self?.viewModel.deleteGeofence(with: id)
                self?.geofenceMapView.deleteGeofenceData(with: id)
                NotificationCenter.default.post(name: Notification.refreshMapView, object: nil, userInfo: nil)
            }
        }
    }
    
    @objc private func addGeofence(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            if let model = notification.userInfo?["model"] as? GeofenceDataModel {
                self?.viewModel.addGeofence(model: model)
                self?.geofenceMapView.addGeofenceData(model)
            }
        }
    }
    
    @objc private func deselectMapAnnotation(_ notification: Notification) {
        geofenceMapView.deselectAnnotation()
    }
    
    @objc private func tabSelected(_ notification: Notification) {
        guard let viewController = notification.userInfo?["viewController"] as? UIViewController,
              viewController === self || viewController === self.navigationController else { return }
         
        authActionsHelper.tryToPerformAuthAction {}
    }
    
    @objc private func geofenceAppearanceChanged(_ notification: Notification) {
        guard let isVisible = notification.userInfo?["isVisible"] as? Bool else { return }
        changeHeaderVisibility(isHidden: isVisible)
        grabberIcon.isHidden = isVisible
    }
    
    func setupViews() {
        if !isInSplitViewController {
            navigationItem.backButtonTitle = ""
            navigationController?.navigationBar.isHidden = true
        }
        
        view.addSubview(geofenceMapView)
        
        geofenceMapView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func locationManagerSetup() {
        locationManager.performLocationDependentAction {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    private func changeHeaderVisibility(isHidden: Bool) {
        if isInSplitViewController {
            headerView.isHidden = true
        } else {
            headerView.isHidden = isHidden
        }
    }
}

extension GeofenceVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userCoreLocation = manager.location?.coordinate
        geofenceMapView.update(userLocation: manager.location, userHeading: manager.heading)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        geofenceMapView.update(userLocation: manager.location, userHeading: manager.heading)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            NotificationCenter.default.post(name: Notification.grantedLocationPermissions, object: nil, userInfo: ["userLocation": manager.location as Any])
            geofenceMapView.grantedLocationPermissions()
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
}

extension GeofenceVC: GeofenceMapViewOutputDelegate {
    func geofenceButtonAction() {
        authActionsHelper.tryToPerformAuthAction { [weak self] in
            guard let self else { return }
            self.delegate?.showDashboardFlow(geofences: self.viewModel.geofences,
                                             lat: self.userCoreLocation?.latitude,
                                             long: self.userCoreLocation?.longitude)
        }
    }
    
    func showMapLayers() {
        delegate?.showMapStyleScene()
    }
    
    func directionHandlers() {
        directioButtonHandler?()
    }
    
    func selectedAnnotation(_ annotation: MLNAnnotation) {
        guard let geofenceAnnotation = annotation as? GeofenceAnnotation,
              let id = geofenceAnnotation.id else { return }
        
        let model = viewModel.getGeofence(with: id)
        delegate?.showAddGeofenceFlow(activeGeofencesLists: viewModel.geofences, isEditingSceneEnabled: true, model: model, lat: userCoreLocation?.latitude, long: userCoreLocation?.longitude)
    }
    
    func showAttribution() {
        delegate?.showAttribution()
    }
    
    func showAddGeofence(lat: Double?, long: Double?) {
        authActionsHelper.tryToPerformAuthAction { [weak self] in
            guard let self else { return }
            let size = self.view.bounds.size.height / 2 - 30
            if !isInSplitViewController {
                self.geofenceMapView.updateBottomViewsSpacings(additionalBottomOffset: size)
            }
            self.delegate?.showAddGeofenceFlow(activeGeofencesLists: self.viewModel.geofences,
                                               isEditingSceneEnabled: false,
                                               model: nil,
                                               lat: lat,
                                               long: long)
        }
    }
}

extension GeofenceVC: GeofenceViewModelDelegate {
    func showGeofences(_ models: [GeofenceDataModel]) {
        self.geofenceMapView.showGeofenceAnnotations(models)
    }
}
