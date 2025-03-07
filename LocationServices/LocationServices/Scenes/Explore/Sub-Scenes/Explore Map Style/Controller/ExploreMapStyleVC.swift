//
//  ExploreMapStyleVC.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import UIKit
final class ExploreMapStyleVC: UIViewController {
    var dismissHandler: VoidHandler?
    
    var selectedIndex: Int = 0
    var headerView: ExploreMapStyleHeaderView = ExploreMapStyleHeaderView()
    var colorSegment: ColorSegmentControl? = nil
    var politicalView = PoliticalView()
    var languageView = LanguageView()
    
    var viewModel: ExploreMapStyleViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var tableView: UITableView =  {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHandlers()
        setupTableView()
        setupViews()
        viewModel.loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        politicalView.setPoliticalView()
    }
    
    private func setupHandlers() {
        self.headerView.dismissHandler = { [weak self] in
            self?.dismissHandler?()
        }
    }
    
    private func setupViews() {
        let colorNames = [MapStyleColorType.light.colorName, MapStyleColorType.dark.colorName]
        colorSegment = ColorSegmentControl(items: colorNames)

        view.backgroundColor = .white
        self.view.addSubview(headerView)
        self.view.addSubview(tableView)
        self.view.addSubview(colorSegment!)
        self.view.addSubview(politicalView)
        self.view.addSubview(languageView)
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.equalToSuperview().offset(5)
            $0.trailing.equalToSuperview().offset(-5)
            $0.height.equalTo(260)
        }
        
        colorSegment?.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
            if UIDevice.current.userInterfaceIdiom == .pad {
                $0.width.equalTo(400)
            }
            else {
                $0.width.equalToSuperview().offset(-50)
            }
            $0.height.equalTo(40)
        }
        
        politicalView.snp.makeConstraints {
            $0.top.equalTo(colorSegment!.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        languageView.snp.makeConstraints {
            $0.top.equalTo(politicalView.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        politicalView.viewController = self
        languageView.viewController = self
    }
}

extension ExploreMapStyleVC: ExploreMapStyleViewModelOutputDelegate {
    func updateTableView(item: Int) {
        selectedIndex = item
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
