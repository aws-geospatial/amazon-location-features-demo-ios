//
//  MapStyleColorType.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

enum MapStyleColorType: String, Codable {
    case light, dark
    
    var colorName: String {
        switch self {
        case .light:
            return "Light"
        case .dark:
            return "Dark"
        }
    }
}
