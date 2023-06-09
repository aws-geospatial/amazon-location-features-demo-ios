//
//  DirectionContracts.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import Foundation

protocol DirectionViewModelProtocol: AnyObject {
    var delegate: DirectionViewModelOutputDelegate? { get set }
    func searchWithSuggesstion(text: String, userLat: Double?, userLong: Double?)
    func searchWith(text: String, userLat: Double?, userLong: Double?)
    func numberOfRowsInSection() -> Int
    func getSearchCellModel() -> [SearchCellViewModel]
    func loadLocalOptions()
}

protocol DirectionViewModelOutputDelegate: AnyObject, AlertPresentable {
    func searchResult(mapModel: [MapModel])
    func reloadView()
    func selectedPlaceResult(mapModel: [MapModel])
    func isMyLocationAlreadySelected() -> Bool
    func getLocalRouteOptions(tollOption: Bool, ferriesOption: Bool)
}

protocol DirectionViewOutputDelegate: AnyObject {
    func changeRoute(type: RouteTypes)
    func startNavigation(type: RouteTypes)
}

protocol DirectionSearchViewOutputDelegate: AnyObject {
    func dismissView()
    func swapLocations()
}
