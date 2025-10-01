//
//  MapStyleColorType+Label.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0
//

extension MapStyleColorType {
   
   var colorLabel: String {
       switch self {
       case .light:
           return StringConstant.light
       case .dark:
           return StringConstant.dark
       }
   }
}
