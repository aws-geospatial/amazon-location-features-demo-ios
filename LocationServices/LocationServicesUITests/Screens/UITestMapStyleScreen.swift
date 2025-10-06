//
//  UITestMapStyleScreen.swift
//  LocationServicesUITests
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import XCTest

struct UITestMapStyleScreen: UITestScreen {
    let app: XCUIApplication

    private enum Identifiers {
        static var closeButton: String { ViewsIdentifiers.General.closeButton }
        static var politicalViewButton: String { ViewsIdentifiers.General.politicalViewButton }
        static var politicalViewSubitle: String { ViewsIdentifiers.General.politicalViewSubtitle }
    }
    
    func select(style: MapStyleTypes) -> Self {
        let cell = getStyleCell(for: style)
        cell.tap()
        
        return self
    }
    
    func tapPoliticalViewButton() -> UITestPoliticalViewScreen {
        let button = getPoliticalViewButton()
        button.tap()
        
        return UITestPoliticalViewScreen(app: app)
    }
    
    func checkPoliticalViewButtonSubtitle() -> Self {
        let button = getPoliticalViewButton()
        let value = button.staticTexts[Identifiers.politicalViewSubitle].label
        XCTAssertTrue(!value.isEmpty, "Political view subtitle set correctly")
        return self
    }
    
    func tapCloseButton() -> UITestExploreScreen {
        let button = getCloseButton()
        button.tap()
        
        return UITestExploreScreen(app: app)
    }
    
    func isCellSelected(for style: MapStyleTypes) -> Bool {
        let cell = getStyleCell(for: style, assert: false)
        return cell.exists && cell.isSelected
    }
    
    // MARK: - Private
    private func getStyleCell(for style: MapStyleTypes, assert: Bool = true) -> XCUIElement {
        let cell = app.cells[style.mapName].firstMatch
        if assert {
            XCTAssertTrue(cell.waitForExistence(timeout: UITestWaitTime.regular.time))
        } else {
            let _ = cell.waitForExistence(timeout: UITestWaitTime.regular.time)
        }
        return cell
    }
    
    private func getCloseButton() -> XCUIElement {
        let button = app.buttons[Identifiers.closeButton]
        XCTAssertTrue(button.waitForExistence(timeout: UITestWaitTime.regular.time))
        return button
    }
    
    private func getPoliticalViewButton() -> XCUIElement {
        let button = app.buttons[Identifiers.politicalViewButton]
        XCTAssertTrue(button.waitForExistence(timeout: UITestWaitTime.regular.time))
        return button
    }
}
