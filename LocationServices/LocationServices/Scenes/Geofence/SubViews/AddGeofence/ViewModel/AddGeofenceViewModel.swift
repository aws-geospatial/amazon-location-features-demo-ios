//
//  AddGeofenceViewModel.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import Foundation

final class AddGeofenceViewModel: AddGeofenceViewModelProcotol {
    
    var delegate: AddGeofenceViewModelOutputProtocol?
    
    private var model: GeofenceDataModel?
    private var presentation: [SearchPresentation] = []
    private var searchCellModel: [SearchCellViewModel] = []
    
    private var searchService: LocationServiceable
    private var geofenceService: GeofenceServiceable
    
    private(set) var activeGeofencesLists: [GeofenceDataModel]
    
    init(searchService: LocationServiceable,
         geofenceService: GeofenceServiceable,
         activeGeofencesLists: [GeofenceDataModel]) {
        self.searchService = searchService
        self.geofenceService = geofenceService
        self.activeGeofencesLists = activeGeofencesLists
    }
    
    func isGeofenceNameValid(_ name: String?) -> Bool {
        guard let name else { return false }
        if (name == "") { return true }
        let isFirstLetter = name.first?.isLetter ?? false
        let isValidLength = !name.isEmpty && name.count <= 20
        let containOnlyAcceptableCharacters = name.allSatisfy({
            $0.isLetter || $0.isNumber || $0 == "-" || $0 == "_"
        })
        
        return isFirstLetter && isValidLength && containOnlyAcceptableCharacters
    }
    
    func isGeofenceModelValid(_ model: GeofenceDataModel) -> Bool {
        return isGeofenceNameValid(model.name) &&
              model.radius != nil &&
              model.lat != nil &&
              model.long != nil
    }
    
    func deleteData(with model: GeofenceDataModel) {
        guard let id = model.id else {
            let model = AlertModel(title: StringConstant.error, message: StringConstant.geofenceNoIdentifier, cancelButton: nil)
            delegate?.showAlert(model)
            return
        }
        
        let alertModel = AlertModel(title: StringConstant.deleteGeofence, message: StringConstant.deleteGeofenceAlertMessage) { [weak self] in
            print("LETS DELETE")
            self?.geofenceService.deleteGeofence(with: id) { [weak self] result in
                switch result {
                case .success:
                    self?.activeGeofencesLists.removeAll(where: { $0.id == id })
                    self?.delegate?.finishProcess()
                case .failure(let error):
                    if(ErrorHandler.isAWSStackDeletedError(error: error)) {
                        ErrorHandler.handleAWSStackDeletedError(delegate: self?.delegate as AlertPresentable?)
                    }
                    else {
                        let model = AlertModel(title: StringConstant.error, message: error.localizedDescription, cancelButton: nil)
                        self?.delegate?.showAlert(model)
                    }
                }
            }
        }
        delegate?.showAlert(alertModel)
    }
    
    
    func searchWithSuggesstion(text: String, userLat: Double?, userLong: Double?) {
        guard !text.isEmpty else {
            self.delegate?.searchResult(mapModel: [])
            return
        }
    
        if text.isCoordinate() {
            let requestValue = text.convertTextToCoordinate()
            searchService.searchWithPosition(text: requestValue, userLat: userLat, userLong: userLong) { [weak self] response in
                switch response {
                case .success(let results):
                    self?.presentation = results
                    let model = results.map(MapModel.init)
                    self?.delegate?.searchResult(mapModel: model)
                case .failure(let error):
                    let model = AlertModel(title: StringConstant.error, message: error.localizedDescription, cancelButton: nil)
                    self?.delegate?.showAlert(model)
                }
            }
        } else {
            searchService.searchTextWithSuggestion(text: text, userLat: userLat, userLong: userLong) { result in
                self.presentation = result
                let model = result.map(MapModel.init)
                self.delegate?.searchResult(mapModel: model)
            }
        }
    }
    
    func searchWith(text: String, userLat: Double?, userLong: Double?) {
        guard !text.isEmpty else {
            self.delegate?.searchResult(mapModel: [])
            return
        }
        
        if text.isCoordinate() {
            let requestValue = text.convertTextToCoordinate()
            searchService.searchWithPosition(text: requestValue, userLat: userLat, userLong: userLong) { [weak self] response in
                switch response {
                case .success(let results):
                    self?.presentation = results
                    let model = results.map(MapModel.init)
                    self?.delegate?.searchResult(mapModel: model)
                case .failure(let error):
                    let model = AlertModel(title: StringConstant.error, message: error.localizedDescription, cancelButton: nil)
                    self?.delegate?.showAlert(model)
                }
            }
        } else {
            searchService.searchText(text: text, userLat: userLat, userLong: userLong) { result in
                self.presentation = result
                let model = result.map(MapModel.init)
                self.delegate?.searchResult(mapModel: model)
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        return presentation.count
    }
    
    func getSearchCellModel() -> [SearchCellViewModel] {
        searchCellModel = presentation.map({
            SearchCellViewModel(searchType: $0.placeId != nil ? .location : .search,
                                placeId: $0.placeId,
                                locationName: $0.name,
                                locationDistance: $0.distance,
                                locationCountry: $0.countryName,
                                locationCity: $0.cityName,
                                label: $0.fullLocationAddress,
                                long: $0.placeLong, lat: $0.placeLat)
        })
        
        return searchCellModel
    }
    
    func searchSelectedPlaceWith(_ indexPath: IndexPath, lat: Double?, long: Double?) -> Bool {
        let selectedItem = searchCellModel[indexPath.row]
        if let id = selectedItem.placeId  {
            searchService.getPlace(with: id) { [weak self] result in
                guard let result else { return }
                let mapModel = MapModel(model: result)
                self?.delegate?.selectedPlaceResult(mapModel: mapModel)
            }
            return true
        } else if selectedItem.lat != nil {
            let currentModel = presentation[indexPath.row]
            let model = MapModel(model: currentModel)
            self.delegate?.selectedPlaceResult(mapModel: model)
            return true
            
        } else {
            searchService.searchText(text: selectedItem.locationName ?? "", userLat: lat, userLong: long) { result in
                self.presentation = []
                self.presentation = result
                let model = result.map(MapModel.init)
                if model.count == 1, let data = model[safe: 0] {
                    self.delegate?.searchResult(mapModel: [data])
                } else {
                    self.delegate?.searchResult(mapModel: model)
                }
            }
            return false
        }
    }
    
}

extension AddGeofenceViewModel {
    // Geofence Services
    func saveData(with id: String, lat: Double, long: Double, radius: Int, completion: @escaping(Result<GeofenceDataModel, Error>) -> Void) {
        geofenceService.putGeofence(with: id, lat: lat, long: long, radius: radius, completion: { [weak self] result in
            switch result {
            case .success:
                let model = GeofenceDataModel(id: id, lat: lat, long: long, radius: Int64(radius))
                
                if let existedIndex = self?.activeGeofencesLists.firstIndex(where: { $0.id == model.id }) {
                    self?.activeGeofencesLists.remove(at: existedIndex)
                }
                self?.activeGeofencesLists.insert(model, at: 0)
            default:
                break
            }
            DispatchQueue.main.async {
                completion(result)
            }
        })
    }
}
