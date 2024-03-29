//
//  SettingsVC.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import UIKit
import SnapKit
import AWSMobileClientXCF

final class SettingsVC: UIViewController {
    
    enum Constants {
        static let horizontalOffset: CGFloat = 16
    }
    
    var delegate: SettingsNavigationDelegate?
    
    private var headerTitle: LargeTitleLabel = {
        let label = LargeTitleLabel(labelText: StringConstant.settigns)
        return label
    }()
    
    var tableView: UITableView = {
        var tableView = UITableView()
        if !UIDevice.current.isPad {
            tableView.separatorColor = .searchBarTintColor
            tableView.separatorInset = .init(top: 0, left: Constants.horizontalOffset, bottom: 0, right: Constants.horizontalOffset)
        } else {
            tableView.separatorStyle = .none
        }
        return tableView
    }()
    
    private lazy var logoutButton: SettingsLogoutButtonView = {
        let view = SettingsLogoutButtonView()
        view.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(logoutAction))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    var viewModel: SettingsViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupNavigationItems()
        setupViews()
        setupTableView()
        viewModel.loadData()
        setupNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadData()
        updateLogoutButtonVisibility()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    private func setupNavigationItems() {
        navigationController?.isNavigationBarHidden = !UIDevice.current.isPad
        navigationItem.backButtonTitle = ""
    }
    
    @objc func logoutAction() {
        viewModel.logOut()
    }
   
    private func setupViews() {
        self.view.addSubview(headerTitle)
        self.view.addSubview(logoutButton)
        self.view.addSubview(tableView)
        
        headerTitle.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().offset(Constants.horizontalOffset)
            $0.trailing.equalToSuperview()
        }
        
        logoutButton.snp.makeConstraints {
            $0.height.equalTo(72)
            $0.bottom.equalTo(view.safeAreaInsets).offset(-16)
            $0.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(self.headerTitle.snp.bottom).offset(16)
            if UIDevice.current.userInterfaceIdiom == .phone {
                $0.leading.trailing.equalToSuperview()
            } else {
                $0.leading.trailing.equalToSuperview().inset(Constants.horizontalOffset)
            }
            $0.bottom.equalTo(logoutButton.snp.top)
        }
    }
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(authorizationStatusChanged(_:)), name: Notification.authorizationStatusChanged, object: nil)
    }
    
    @objc private func authorizationStatusChanged(_ notification: Notification) {
        DispatchQueue.main.async {
            self.updateLogoutButtonVisibility()
        }
    }
    
    private func updateLogoutButtonVisibility() {
        // show logout button only if we are not signed in
        logoutButton.isHidden = !AWSMobileClient.default().isSignedIn
    }
}

extension SettingsVC: SettingsViewModelOutputDelegate {
    func refreshViews() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func logoutCompleted() {
        // show logout button only if we are not signed in
        self.logoutButton.isHidden = !AWSMobileClient.default().isSignedIn
    }
}
