//
//  NavigationViewModel.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import Foundation

final class NavigationVCViewModel {
    var delegate: NavigationViewModelOutputDelegate?
    var service: LocationService
    var steps: [NavigationSteps]
    var presentation: [NavigationPresentation] = []
    private var summaryData: (totalDistance: Double, totalDuration: Double)
    let dispatchGroup = DispatchGroup()
    
    private(set) var firstDestionation: MapModel?
    private(set) var secondDestionation: MapModel?
    
    init(service: LocationService, steps: [NavigationSteps], summaryData: (totalDistance: Double, totalDuration: Double), firstDestionation: MapModel?, secondDestionation: MapModel?) {
        self.service = service
        self.steps = steps
        self.summaryData = summaryData
        self.firstDestionation = firstDestionation
        self.secondDestionation = secondDestionation
        fetchStreetNames()
    }
    
    private func fetchStreetNames() {
        let dispatchQueue = DispatchQueue(label: "Serial", attributes: .concurrent)
        
        var presentation: [NavigationPresentation] = []
        for (id, step) in steps.enumerated() {
            dispatchGroup.enter()
            let position = step.startPosition as [NSNumber]
            dispatchQueue.sync { [weak self] in
                service.searchWithPosition(text: position, userLat: nil, userLong: nil) { response in
                    switch response {
                    case .success(let results):
                        guard let result = results.first else { break }
                            
                        let model = NavigationPresentation(id: id, duration: step.duration.convertSecondsToMinString(), distance: step.distance.convertFormattedKMString(), streetAddress: result.placeLabel ?? "")
                        presentation.append(model)
                    case .failure:
                        break
                    }
                    self?.dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: dispatchQueue) { [weak self] in
            presentation.sort(by: { $0.id < $1.id })
            self?.presentation = presentation
            self?.delegate?.updateResults()
        }
    }
    
    func update(steps: [NavigationSteps], summaryData: (totalDistance: Double, totalDuration: Double)) {
        self.steps = steps
        self.summaryData = summaryData
        fetchStreetNames()
    }
    
    func getSummaryData() -> (totalDistance: String, totalDuration: String) {
        return (summaryData.totalDistance.convertFormattedKMString(),
                summaryData.totalDuration.convertSecondsToMinString())
    }
    
    func getData() -> [NavigationCellModel] {
        var model: [NavigationCellModel] = []
        if presentation.count > 0 {
            for i in 0...presentation.count - 1 {
                let item = presentation[i]
                if i == presentation.count - 1 {
                    model.append(NavigationCellModel(model: item, stepType: .last))
                } else {
                    model.append(NavigationCellModel(model: item, stepType: .first))
                }
            }
        }
        
        return model
    }
    
    func getItemCount() -> Int {
        return presentation.count
    }
}
