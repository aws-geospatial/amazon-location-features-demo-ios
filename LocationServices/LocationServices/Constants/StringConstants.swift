//
//  StringConstants.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import Foundation

// Strings
enum StringConstant {
    
    //urls
    static let baseDomain: String = "https://location.aws.com"
    static var termsAndConditionsURL: String { baseDomain + "/demo/terms/" }
    static let esriDataProviderLearnMoreURL = "https://www.esri.com/en-us/legal/terms/data-attributions"
    static let hereDataProviderLearnMoreURL = "https://legal.here.com/en-gb/terms/general-content-supplier-terms-and-notices"
    static var softwareAttributionLearnMoreURL: String { baseDomain + "/demo/software-attributions" }
    static let termsAndConditionsTrackingURL = "https://aws.amazon.com/service-terms/#82._Amazon_Location_Service"
    static var helpURL: String { StringConstant.baseDomain + "/demo/help" }
    
    // urls constant:
    static var developmentUrl: String {
        let regionName = Bundle.main.object(forInfoDictionaryKey: "AWSRegion") as! String
        return "maps.geo.\(regionName).amazonaws.com"
    }
    static let developmentSchema = "https"
    
    enum AboutTab {
        static var title: String { LanguageManager.shared.localizedString(forKey:"more") }
        static var cellAttributionTitle: String { LanguageManager.shared.localizedString(forKey:"attribution") }
        static var cellLegalTitle: String { LanguageManager.shared.localizedString(forKey:"termsConditions") }
        static var cellVersionTitle: String { LanguageManager.shared.localizedString(forKey:"version") }
        static var cellHelpTitle: String { LanguageManager.shared.localizedString(forKey:"help") }
    }
    
    enum About {
        static var downloadTermsTitle: String { LanguageManager.shared.localizedString(forKey:"downloadTermsTitle") }
        static var appTermsOfUse: String { LanguageManager.shared.localizedString(forKey:"termsConditions") }
        static var appTermsOfUseURL = termsAndConditionsURL
        static var copyright: String { return "© \(Calendar.current.component(.year, from: Date())) \(LanguageManager.shared.localizedString(forKey:"copyright"))" }
    }
    
    enum Tracking {
        static var noTracking: String { LanguageManager.shared.localizedString(forKey:"noTracking") }
        static var isTracking: String { LanguageManager.shared.localizedString(forKey:"isTracking") }
    }
    
    enum TabBar {
        static var navigate: String { LanguageManager.shared.localizedString(forKey:"navigate") }
        static var tracking: String { LanguageManager.shared.localizedString(forKey: "trackers") }
        static var settings: String { LanguageManager.shared.localizedString(forKey:"settings") }
        static var more: String { LanguageManager.shared.localizedString(forKey:"more") }
    }
    
    enum NotificationsInfoField {
        static var geofenceIsHidden: String { LanguageManager.shared.localizedString(forKey:"geofenceIsHidden") }
        static var mapStyleIsHidden: String { LanguageManager.shared.localizedString(forKey:"mapStyleIsHidden") }
        static var directionIsHidden: String { LanguageManager.shared.localizedString(forKey:"directionIsHidden") }
    }
    
    static var greatDistanceErrorTitle: String { LanguageManager.shared.localizedString(forKey:"greatDistanceErrorTitle") }
    static var greatDistanceErrorMessage: String { LanguageManager.shared.localizedString(forKey:"greatDistanceErrorMessage") }
    static var invalidUrlError: String { LanguageManager.shared.localizedString(forKey:"invalidUrlError") }
    static var directions: String { LanguageManager.shared.localizedString(forKey:"directions") }
    static var maybeLater: String { LanguageManager.shared.localizedString(forKey:"maybeLater") }
    static var checkYourConnection: String { LanguageManager.shared.localizedString(forKey:"checkYourConnection") }
    static var amazonLocatinCannotReach: String { LanguageManager.shared.localizedString(forKey:"amazonLocatinCannotReach") }
    static var terminate: String { LanguageManager.shared.localizedString(forKey:"ok") }
    static var failedToCalculateRoute: String { LanguageManager.shared.localizedString(forKey:"failedToCalculateRoute") }
    static var noInternetConnection: String { LanguageManager.shared.localizedString(forKey:"noInternetConnection") }
    static var trackers: String { LanguageManager.shared.localizedString(forKey:"trackers") }
    static var enableTrackingDescription: String { LanguageManager.shared.localizedString(forKey:"enableTrackingDescription") }
    static var startTracking: String { LanguageManager.shared.localizedString(forKey:"startTracking") }
    static var stopTracking: String { LanguageManager.shared.localizedString(forKey:"stopTracking") }
    static var startSimulation: String { LanguageManager.shared.localizedString(forKey:"startSimulation") }
    static var simulation: String { LanguageManager.shared.localizedString(forKey:"simulation") }
    static var trackersGeofences: String { LanguageManager.shared.localizedString(forKey:"trackersGeofences") }
    static var trackersGeofencesHeader: String { LanguageManager.shared.localizedString(forKey:"trackersGeofencesHeader") }
    static var trackersGeofencesDetail: String { LanguageManager.shared.localizedString(forKey:"trackersGeofencesDetail") }
    static var startTrackingSimulation: String { LanguageManager.shared.localizedString(forKey:"startSimulation") }
    static var trackersDetail: String { LanguageManager.shared.localizedString(forKey:"trackersDetail") }
    static var geofences: String { LanguageManager.shared.localizedString(forKey:"geofences") }
    static var geofencesDetail: String { LanguageManager.shared.localizedString(forKey:"geofencesDetail") }
    static var notifications: String { LanguageManager.shared.localizedString(forKey:"notifications") }
    static var notificationsDetail: String { LanguageManager.shared.localizedString(forKey:"notificationsDetail") }
    static var routesNotifications: String { LanguageManager.shared.localizedString(forKey:"routesNotifications") }
    static var tracker: String { LanguageManager.shared.localizedString(forKey:"trackers") }
    static var entered: String { LanguageManager.shared.localizedString(forKey:"entered") }
    static var exited: String { LanguageManager.shared.localizedString(forKey:"exited") }
    static var exit: String { LanguageManager.shared.localizedString(forKey:"exit") }
    static var change: String { LanguageManager.shared.localizedString(forKey:"change") }
    static var go: String { LanguageManager.shared.localizedString(forKey:"go") }
    static var preview: String { LanguageManager.shared.localizedString(forKey:"preview") }
    static var done: String { LanguageManager.shared.localizedString(forKey:"done") }
    static var search: String { LanguageManager.shared.localizedString(forKey:"search") }
    static var searchDestination: String { LanguageManager.shared.localizedString(forKey:"searchDestination") }
    static var searchStartingPoint: String { LanguageManager.shared.localizedString(forKey:"searchStartingPoint") }
    static var noMatchingPlacesFound: String { LanguageManager.shared.localizedString(forKey: "noMatchingPlacesFound") }
    static var searchSpelledCorrectly: String { LanguageManager.shared.localizedString(forKey: "searchSpelledCorrectly") }
    static var locationPermissionDenied: String { LanguageManager.shared.localizedString(forKey:"locationPermissionDenied") }
    static var locationPermissionDeniedDescription: String { LanguageManager.shared.localizedString(forKey:"locationPermissionDeniedDescription") }
    static var locationPermissionEnableLocationAction: String { LanguageManager.shared.localizedString(forKey:"enableLocation") }
    static var locationPermissionAlertTitle: String { LanguageManager.shared.localizedString(forKey:"allowLocationServices") }
    static var locationPermissionAlertText: String { LanguageManager.shared.localizedString(forKey:"amazonLocationRoute") }
    static var locationManagerAlertTitle: String { LanguageManager.shared.localizedString(forKey:"allowLocationServices") }
    static var locationManagerAlertText: String { LanguageManager.shared.localizedString(forKey:"locationDetectionExplanation") }
    static var cancel: String { LanguageManager.shared.localizedString(forKey:"cancel") }
    static var settigns: String { LanguageManager.shared.localizedString(forKey:"settings") }
    static var error: String { LanguageManager.shared.localizedString(forKey:"error") }
    static var warning: String { LanguageManager.shared.localizedString(forKey:"warning") }
    static var ok: String { LanguageManager.shared.localizedString(forKey:"ok") }
    static var dispatchReachabilityLabel: String { LanguageManager.shared.localizedString(forKey:"reachability") }
    static var exitTrackingAlertMessage: String { LanguageManager.shared.localizedString(forKey:"exitTrackingAlertMessage") }
    static var units: String { LanguageManager.shared.localizedString(forKey:"units") }
    static var mapStyle: String { LanguageManager.shared.localizedString(forKey:"mapStyle") }
    static var defaultRouteOptions: String { LanguageManager.shared.localizedString(forKey:"defaultRouteOptions") }
    static var partnerAttributionTitle: String { LanguageManager.shared.localizedString(forKey:"partnerAttributionTitle") }
    static var partnerAttributionHEREDescription: String { return "© AWS, HERE" }
    static var softwareAttributionTitle: String { LanguageManager.shared.localizedString(forKey:"softwareAttributionTitle") }
    static var softwareAttributionDescription: String { LanguageManager.shared.localizedString(forKey:"softwareAttributionDescription") }
    static var learnMore: String { LanguageManager.shared.localizedString(forKey:"learnMore") }
    static var attribution: String { LanguageManager.shared.localizedString(forKey:"attribution") }
    static var more: String { LanguageManager.shared.localizedString(forKey:"more") }
    static var version: String { LanguageManager.shared.localizedString(forKey:"version") }
    static var welcomeTitle: String { LanguageManager.shared.localizedString(forKey:"welcomeTitle") }
    static var continueString: String { LanguageManager.shared.localizedString(forKey:"continue") }
    static var avoidTolls: String { LanguageManager.shared.localizedString(forKey:"avoidTolls") }
    static var avoidFerries: String { LanguageManager.shared.localizedString(forKey:"avoidFerries") }
    static var avoidUturns: String { LanguageManager.shared.localizedString(forKey:"avoidUturns") }
    static var avoidTunnels: String { LanguageManager.shared.localizedString(forKey:"avoidTunnels") }
    static var avoidDirtRoads: String { LanguageManager.shared.localizedString(forKey:"avoidDirtRoads") }
    static var myLocation: String { LanguageManager.shared.localizedString(forKey:"myLocation") }
    static var appVersion: String { LanguageManager.shared.localizedString(forKey:"appVersion") }
    static var termsAndConditions: String { LanguageManager.shared.localizedString(forKey:"termsConditions") }
    static var demo: String { LanguageManager.shared.localizedString(forKey:"Demo") }
    static var routeOverview: String { LanguageManager.shared.localizedString(forKey:"routeOverview") }
    static var viewRoute: String { LanguageManager.shared.localizedString(forKey:"viewRoute") }
    static var hideRoute: String { LanguageManager.shared.localizedString(forKey:"hideRoute") }
    static var trackingNotificationTitle: String { LanguageManager.shared.localizedString(forKey:"amazonLocation") }
    static var arrivalCardTitle: String { LanguageManager.shared.localizedString(forKey:"arrivalCardTitle") }
    static var poiCardSchedule: String { LanguageManager.shared.localizedString(forKey:"schedule") }
    static var language: String { LanguageManager.shared.localizedString(forKey:"language") }
    static var politicalView: String { LanguageManager.shared.localizedString(forKey:"politicalView") }
    static var mapRepresentation: String { LanguageManager.shared.localizedString(forKey:"mapRepresentation") }
    static var mapLanguage: String { LanguageManager.shared.localizedString(forKey:"mapLanguage") }
    static var selectLanguage: String { LanguageManager.shared.localizedString(forKey:"Select Language") }
    static var leaveNow: String { LanguageManager.shared.localizedString(forKey:"leaveNow") }
    static var leaveAt: String { LanguageManager.shared.localizedString(forKey:"leaveAt") }
    static var arriveBy: String { LanguageManager.shared.localizedString(forKey:"arriveBy") }
    static var routeOptions: String { LanguageManager.shared.localizedString(forKey:"routeOptions") }
    static var options: String { LanguageManager.shared.localizedString(forKey:"options") }
    static var selected: String { LanguageManager.shared.localizedString(forKey:"selected") }
    static var routesActive: String { LanguageManager.shared.localizedString(forKey:"routesActive") }
    static var politicalLight: String { LanguageManager.shared.localizedString(forKey:"light") }
    static var politicalDark: String { LanguageManager.shared.localizedString(forKey:"dark") }
    static var automaticUnit: String { LanguageManager.shared.localizedString(forKey:"automatic") }
    static var imperialUnit: String { LanguageManager.shared.localizedString(forKey:"imperial") }
    static var metricUnit: String { LanguageManager.shared.localizedString(forKey:"metric") }
    static var imperialSubtitle: String { LanguageManager.shared.localizedString(forKey:"imperialSubtitle") }
    static var metricSubtitle: String { LanguageManager.shared.localizedString(forKey:"metricSubtitle") }
    static var light: String { LanguageManager.shared.localizedString(forKey:"light") }
    static var dark: String { LanguageManager.shared.localizedString(forKey:"dark") }
    static var noPoliticalView: String { LanguageManager.shared.localizedString(forKey:"noPoliticalView") }
    static var argentinaPoliticalView: String { LanguageManager.shared.localizedString(forKey:"ArgentinaPoliticalView") }
    static var cyprusPoliticalView: String { LanguageManager.shared.localizedString(forKey:"CyprusPoliticalView") }
    static var egyptPoliticalView: String { LanguageManager.shared.localizedString(forKey:"EgyptPoliticalView") }
    static var georgiaPoliticalView: String { LanguageManager.shared.localizedString(forKey:"GeorgiaPoliticalView") }
    static var greecePoliticalView: String { LanguageManager.shared.localizedString(forKey:"GreecePoliticalView") }
    static var indiaPoliticalView: String { LanguageManager.shared.localizedString(forKey:"IndiaPoliticalView") }
    static var kenyaPoliticalView: String { LanguageManager.shared.localizedString(forKey:"KenyaPoliticalView") }
    static var moroccoPoliticalView: String { LanguageManager.shared.localizedString(forKey:"MoroccoPoliticalView") }
    static var palestinePoliticalView: String { LanguageManager.shared.localizedString(forKey:"PalestinePoliticalView") }
    static var russiaPoliticalView: String { LanguageManager.shared.localizedString(forKey:"RussiaPoliticalView") }
    static var sudanPoliticalView: String { LanguageManager.shared.localizedString(forKey:"SudanPoliticalView") }
    static var serbiaPoliticalView: String { LanguageManager.shared.localizedString(forKey:"SerbiaPoliticalView") }
    static var surinamePoliticalView: String { LanguageManager.shared.localizedString(forKey:"SurinamePoliticalView") }
    static var syriaPoliticalView: String { LanguageManager.shared.localizedString(forKey:"SyriaPoliticalView") }
    static var turkeyPoliticalView: String { LanguageManager.shared.localizedString(forKey:"TurkeyPoliticalView") }
    static var tanzaniaPoliticalView: String { LanguageManager.shared.localizedString(forKey:"TanzaniaPoliticalView") }
    static var uruguayPoliticalView: String { LanguageManager.shared.localizedString(forKey:"UruguayPoliticalView") }
    static var m: String { LanguageManager.shared.localizedString(forKey:"m") }
    static var km: String { LanguageManager.shared.localizedString(forKey:"km") }
    static var mi: String { LanguageManager.shared.localizedString(forKey:"mi") }
    static var min: String { LanguageManager.shared.localizedString(forKey:"min") }
    static var hr: String { LanguageManager.shared.localizedString(forKey:"hr") }
    static var sec: String { LanguageManager.shared.localizedString(forKey:"sec") }
    static var region: String { LanguageManager.shared.localizedString(forKey:"region") }
    static var euWest1: String = "eu-west-1"
    static var usEast1: String = "us-east-1"
    static var euWest1FullName: String = "Europe (Ireland) \(euWest1)"
    static var usEast1FullName: String = "Us-East (N. Virginia) \(usEast1)"
    static var euWest1ListTitle: String = "Europe"
    static var usEast1ListTitle: String = "Us-East"
}
