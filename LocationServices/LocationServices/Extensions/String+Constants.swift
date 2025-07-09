//
//  ErrorMessage.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

enum ErrorMessage {
    // errors:
    static let errorInitWithCoder = "init(coder:) has not been implemented"
    static let errorAnimatorNotSet = "Somehow the offset animator was not set"
    static let errorCannotInitializeView = "Couldn't initialize view"
    static let errorUserDefaultsSave = "User Default save error:"
    static let errorUserDefaultsGet = "User Default get error:"
    static let errorCellCannotBeInitialized = "Cell can't be initialized"
    static let errorJSONDecoder = "JSON Decoder Error"
    static let cellCanNotBeDequed = "Cell can't be dequed"
    
    // errors
    static let domainErrorLocalizedDescription = "The operation couldn’t be completed. (kCLErrorDomain error 0.)"
    static let testExpectationError = "expectation not matched after waiting"
    static let sessionExpiredError = "Session is expired. Please sign out and sign in back to continue access all features. Otherwise you could face unexpected behaviour in the app"
   
    static let awsStackInvalidTitle = "Invalid AWS Stack"
    static let awsStackInvalidExplanation = "Stack is not invalid anymore or deleted, app will disconnect from AWS and restart"
}
