//
//  UIViewController+Extension.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func getSmallDetentHeight() -> CGFloat {
        return self.parent!.view.frame.height * 0.1
    }
    
    func getMediumDetentHeight() -> CGFloat {
        return self.parent!.view.frame.height * 0.5
    }
    
    func getLargeDetentHeight() -> CGFloat {
        return self.parent!.view.frame.height * 0.95
    }
    
   func createGrabberView() -> UIView {
        let grabberView = UIView()
        grabberView.backgroundColor = .systemGray4
        grabberView.layer.cornerRadius = 2.5
        grabberView.translatesAutoresizingMaskIntoConstraints = false
        return grabberView
    }
    
    func presentBottomSheet(parentController: UIViewController) {
        parentController.addChild(self)
        parentController.view.addSubview(self.view)
        self.didMove(toParent: parentController)
        self.view.snp.makeConstraints {
            $0.leading.equalTo(parentController.view.snp.leading)
            $0.trailing.equalTo(parentController.view.snp.trailing)
            $0.bottom.equalTo(parentController.view.snp.bottom)
        }
    }
    
    func enableBottomSheetGrab() {
        let grabberView = createGrabberView()
        view.addSubview(grabberView)
        grabberView.snp.makeConstraints{
            $0.width.equalTo(36)
            $0.height.equalTo(5)
            $0.centerX.equalTo(view.snp.centerX)
            $0.top.equalTo(view.snp.top).offset(8)
        }
        
        self.view.snp.makeConstraints{
            $0.height.equalTo(getMediumDetentHeight())
        }

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
       grabberView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func updateBottomSheetHeight(to height: CGFloat) {
        self.view.snp.updateConstraints{
            $0.height.equalTo(height)
        }
    }
    
    func setBottomSheetHeight(to height: CGFloat) {
        self.view.snp.makeConstraints {
            $0.height.equalTo(height)
        }
    }

    @objc private func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: self.view)
        let currentHeight = view.frame.height - translation.y

        let newHeight = max(min(currentHeight, getLargeDetentHeight()), getSmallDetentHeight())

        switch recognizer.state {
        case .changed:
            self.updateBottomSheetHeight(to: currentHeight)
            recognizer.setTranslation(.zero, in: view)
        case .ended:
            let velocity = recognizer.velocity(in: view).y
            let targetDetentHeight = getTargetDetentHeight(newHeight: newHeight, velocity: velocity)

            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.updateBottomSheetHeight(to: targetDetentHeight)
                self.parent?.view.layoutIfNeeded()
            }
        default:
            break
        }
    }

    private func getTargetDetentHeight(newHeight: CGFloat, velocity: CGFloat) -> CGFloat {
        let targetDetentHeight: CGFloat

        if abs(velocity) < 500 {
            targetDetentHeight = snapToNearestDetent(newHeight)
        } else {
            targetDetentHeight = snapToNextDetent(newHeight, velocity: velocity)
        }

        return targetDetentHeight
    }

    private func snapToNearestDetent(_ newHeight: CGFloat) -> CGFloat {
        let smallDiff = abs(newHeight - getSmallDetentHeight())
        let mediumDiff = abs(newHeight - getMediumDetentHeight())
        let largeDiff = abs(newHeight - getLargeDetentHeight())

        let minDiff = min(smallDiff, min(mediumDiff, largeDiff))

        switch minDiff {
        case smallDiff:
            return getSmallDetentHeight()
        case mediumDiff:
            return getMediumDetentHeight()
        default:
            return getLargeDetentHeight()
        }
    }

    private func snapToNextDetent(_ newHeight: CGFloat, velocity: CGFloat) -> CGFloat {
        let currentDetentHeight: CGFloat
        if newHeight < getMediumDetentHeight() {
            currentDetentHeight = getSmallDetentHeight()
        } else if newHeight < getLargeDetentHeight() {
            currentDetentHeight = getMediumDetentHeight()
        } else {
            currentDetentHeight = getLargeDetentHeight()
        }

        if velocity < 0 {
            return currentDetentHeight == getSmallDetentHeight() ? getMediumDetentHeight() : getLargeDetentHeight()
        } else {
            return currentDetentHeight == getLargeDetentHeight() ? getMediumDetentHeight() : getSmallDetentHeight()
        }
    }
    
    @objc private func handleTapGesture(_ recognizer: UITapGestureRecognizer) {
        let currentHeight = view.frame.height
        let targetDetentHeight: CGFloat

        if currentHeight >= getSmallDetentHeight() && currentHeight < getMediumDetentHeight() {
            targetDetentHeight = getMediumDetentHeight()
        } else if currentHeight >= getMediumDetentHeight() && currentHeight < getLargeDetentHeight() {
            targetDetentHeight = getLargeDetentHeight()
        } else {
            targetDetentHeight = getMediumDetentHeight()
        }

        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.updateBottomSheetHeight(to: targetDetentHeight)
            self.view.layoutIfNeeded()
        }
    }
}
