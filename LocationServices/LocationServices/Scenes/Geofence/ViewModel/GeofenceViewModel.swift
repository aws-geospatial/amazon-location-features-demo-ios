//
//  GeofenceViewModel.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import Foundation

final class GeofenceViewModel: GeofenceViewModelProtocol {
    
    private let geofenceService: GeofenceServiceable

    private(set) var geofences: [GeofenceDataModel] = []
    
    weak var delegate: GeofenceViewModelDelegate?
    
    init(geofenceService: GeofenceServiceable) {
        self.geofenceService = geofenceService
    }
    
    func hasUserLoggedIn() -> Bool {
        return UserDefaultsHelper.getAppState() == .loggedIn
    }
    
    func getGeofence(with id: String) -> GeofenceDataModel? {
        return geofences.first(where: { $0.id == id } )
    }
    
    func deleteGeofence(with id: String) {
        return geofences.removeAll(where: { $0.id == id } )
    }
    
    func addGeofence(model: GeofenceDataModel) {
        if let existedIndex = geofences.firstIndex(where: { $0.id == model.id }) {
            geofences.remove(at: existedIndex)
        }
        geofences.insert(model, at: 0)
    }
    
    func fetchListOfGeofences() async {
        
        // if we are not authorized do not send it
        if UserDefaultsHelper.getAppState() != .loggedIn {
            DispatchQueue.main.async {
                self.geofences = []
                self.delegate?.showGeofences([])
            }
            return
        }
        
        let result = await geofenceService.getGeofenceList(collectionName: "")
            switch result {
            case .success(let geofences):
                DispatchQueue.main.async {
                    self.geofences = geofences
                    self.delegate?.showGeofences(geofences)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    if(ErrorHandler.isAWSStackDeletedError(error: error)) {
                        ErrorHandler.handleAWSStackDeletedError(delegate: self.delegate as AlertPresentable?)
                    }
                    else {
                        let model = AlertModel(title: StringConstant.error, message: error.localizedDescription)
                        self.delegate?.showAlert(model)
                    }
                }
            }
    }
}
