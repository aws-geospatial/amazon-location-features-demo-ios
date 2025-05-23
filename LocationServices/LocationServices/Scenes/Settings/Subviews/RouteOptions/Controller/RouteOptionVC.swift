//
//  RouteOptionVC.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import UIKit
import SnapKit

final class RouteOptionVC: UIViewController {
    
    enum Constants {
        static let horizontalOffset: CGFloat = 16
    }
    
    private var screenTitleLabel: LargeTitleLabel = {
        let label = LargeTitleLabel(labelText: StringConstant.defaultRouteOptions)
        label.numberOfLines = 0
        return label
    }()
    
    private var routeOptions = RouteOptionRowView()
    
    var viewModel: RouteOptionViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHandlers()
        setupViews()
        viewModel.loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupViews() {
        navigationController?.navigationBar.tintColor = .mapDarkBlackColor
        navigationItem.title = UIDevice.current.isPad ? "" : StringConstant.defaultRouteOptions
        view.backgroundColor = .white
        
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        if isPad {
            view.addSubview(screenTitleLabel)
            screenTitleLabel.snp.makeConstraints {
                $0.top.equalTo(view.safeAreaLayoutGuide)
                $0.horizontalEdges.equalToSuperview().inset(Constants.horizontalOffset)
            }
        }
        
        self.view.addSubview(routeOptions)
        routeOptions.snp.makeConstraints {
            if isPad {
                $0.top.equalTo(screenTitleLabel.snp.bottom)
            } else {
                $0.top.equalTo(self.view.safeAreaLayoutGuide)
            }
            $0.leading.trailing.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-Constants.horizontalOffset)
        }
    }
    
    private func setupHandlers() {
        routeOptions.tollHandlers = { [weak self] option in
            self?.viewModel.saveTollOption(state: option)
        }
        
        routeOptions.ferriesHandlers = { [weak self] option in
            self?.viewModel.saveFerriesOption(state: option)
        }
        
        routeOptions.uturnsHandlers = { [weak self] option in
            self?.viewModel.saveUturnsOption(state: option)
        }
        
        routeOptions.tunnelsHandlers = { [weak self] option in
            self?.viewModel.saveTunnelsOption(state: option)
        }
        
        routeOptions.dirtRoadsHandlers = { [weak self] option in
            self?.viewModel.saveDirtRoadsOption(state: option)
        }
    }
}

extension RouteOptionVC: RouteOptionViewModelOutputDelegate {
    func updateViews(tollOption: Bool, ferriesOption: Bool, uturnsOption: Bool, tunnelsOption: Bool, dirtRoadsOption: Bool) {
        routeOptions.setLocalValues(toll: tollOption, ferries: ferriesOption, uturns: uturnsOption, tunnels: tunnelsOption, dirtRoads: dirtRoadsOption)
    }
}
