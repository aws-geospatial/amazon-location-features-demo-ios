//
//  SettingsViewModel.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import Foundation

final class SettingsViewModel: SettingsViewModelProtocol {
    var delegate: SettingsViewModelOutputDelegate?
    private var datas: [SettingsCellModel] = []
    
    func loadData() {
        populateConfiguredData()
        delegate?.refreshViews()
    }
    
    func getCellItems(_ indexPath: IndexPath) -> SettingsCellModel {
        return datas[indexPath.row]
    }
    
    func getItemCount() -> Int {
        datas.count
    }
    
    private func populateConfiguredData() {
        let mapStyle = UserDefaultsHelper.getObject(value: MapStyleModel.self, key: .mapStyle)
        let unitType = UserDefaultsHelper.getObject(value: UnitTypes.self, key: .unitType)
        let languageTitle = appLanguageSwitcherData.first(where: { $0.value == Locale.currentAppLanguageIdentifier()})?.label
        
        let region = AWSRegionSelector.shared.getCachedRegion()
        var regionTitle = ""
        if region == RegionType.euWest1.title {
            regionTitle = RegionType.euWest1.listTitle
        }
        else if region == RegionType.usEast1.title {
            regionTitle = RegionType.usEast1.listTitle
        }
        let isAutoRegion = AWSRegionSelector.shared.isAutoRegion()
        
        datas = [
            SettingsCellModel(type: .units, subTitle: unitType?.title ?? ""),
            SettingsCellModel(type: .mapStyle, subTitle: mapStyle?.title ?? ""),
            SettingsCellModel(type: .language, subTitle: languageTitle),
            SettingsCellModel(type: .routeOption),
            SettingsCellModel(type: .region, subTitle: isAutoRegion == true ? StringConstant.automaticUnit : regionTitle)
        ]
    }
}
