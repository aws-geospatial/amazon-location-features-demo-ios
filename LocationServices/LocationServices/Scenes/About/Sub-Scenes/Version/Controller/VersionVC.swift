//
//  VersionVC.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import UIKit
import SnapKit

final class VersionVC: UIViewController {
    
    // MARK: - Views
    private var screenTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .amazonFont(type: .bold,
                                 size: 20)
        label.text = StringConstant.version
        return label
    }()
    
    private var appVersionLabel: UILabel = {
        var label = UILabel()
        label.text = StringConstant.appVersion + UIApplication.appVersion()
        label.font = .amazonFont(type: .regular, size: 13)
        label.textColor = .lsGrey
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var copyrightLabel: UILabel = {
        var label = UILabel()
        label.text = StringConstant.About.copyright
        label.font = .amazonFont(type: .regular, size: 13)
        label.textColor = .lsGrey
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var logoIcon: UIImageView = {
        let iv = UIImageView(image: .logoPoweredByAWS)
        return iv
    }()
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        setupNavigationItems()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UIDevice.current.userInterfaceIdiom == .phone {
            navigationController?.isNavigationBarHidden = false
        } else {
            navigationController?.navigationBar.isHidden = true
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if UIDevice.current.userInterfaceIdiom == .phone {
            navigationController?.isNavigationBarHidden = true
        } else {
            navigationController?.navigationBar.isHidden = false
        }
    }
    
    // MARK: - Functions
    private func setupNavigationItems() {
        navigationController?.navigationBar.tintColor = .lsTetriary
        self.title = StringConstant.version
    }
    
    private func setupViews() {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        if isPad {
            view.addSubview(screenTitleLabel)
            screenTitleLabel.snp.makeConstraints { make in
                make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
                make.leading.equalToSuperview().offset(24)
            }
        }
        view.addSubview(appVersionLabel)
        view.addSubview(copyrightLabel)
        view.addSubview(logoIcon)
        
        appVersionLabel.snp.makeConstraints {
            if isPad {
                $0.top.equalTo(screenTitleLabel.snp.bottom).offset(16)
            } else {
                $0.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            }
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        copyrightLabel.snp.makeConstraints {
            $0.top.equalTo(appVersionLabel.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(24)
            $0.trailing.equalToSuperview().offset(-24)
        }
        
        logoIcon.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.width.equalTo(113)
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
        }
    }
}
