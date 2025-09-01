//
//  RegionType.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import Foundation

enum RegionType: String, Codable, CaseIterable {
    case automatic
    case euWest1 = "eu-west-1"
    case usEast1 = "us-east-1"
    
    struct Info {
        let fullName: String
        let listTitle: String
    }
    
    private var info: Info {
        switch self {
        case .automatic:
            return Info(
                fullName: "Automatic",
                listTitle: "Automatic"
            )
        case .euWest1:
            return Info(
                fullName: "Europe (Ireland) \(rawValue)",
                listTitle: "Europe"
            )
        case .usEast1:
            return Info(
                fullName: "US-East (N. Virginia) \(rawValue)",
                listTitle: "US-East"
            )
        }
    }
    
    var title: String { rawValue }
    var displayTitle: String { info.fullName }
    var listTitle: String { info.listTitle }
}
