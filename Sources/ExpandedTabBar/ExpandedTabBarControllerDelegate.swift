//
//  ExpandedTabBarControllerDelegate.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/28/19.
//  Copyright © 2019 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)

import UIKit

extension ExpandedTabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController,
                                 shouldSelect viewController: UIViewController) -> Bool {
        
        if viewController.isInitialMore {
            backgroundView.alpha != 0 ? deselectMore() : showMoreContainer()
        } else if viewController.isSelectedMore {
            backgroundView.alpha != 0 ? hideMoreContainer() : showMoreContainer()
        }
        
        return !viewController.isInitialMore && !viewController.isSelectedMore
    }

    public func tabBarController(_ tabBarController: UITabBarController,
                                 didSelect viewController: UIViewController) {
        deselectMore()
        expandedDelegate?.expandedTabBarController(self,
                                                   didSelect: viewController,
                                                   withItem: viewController.tabBarItem)
    }
}

internal extension ExpandedTabBarController {

    @objc func itemTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedViewController = moreViewControllers.selectedViewController(from: sender) else { return }
        
        hideMoreContainer()

        guard let index = viewControllers.initialMoreIndex ?? viewControllers.selectedMoreIndex else { return }
        
        let tabBarItem = selectedViewController.tabBarItem
        selectedViewController.tabBarItem = moreViewController().tabBarItem
        
        viewControllers?[index] = selectedViewController
        self.selectedIndex = index
        
        expandedDelegate?.expandedTabBarController(self,
                                                   didSelect: selectedViewController,
                                                   withItem: tabBarItem)
    }

    private func deselectMore() {
        hideMoreContainer()
        viewControllers.replaceSelected(with: moreViewController())
    }
}

private extension UIViewController {
    var isInitialMore: Bool {
        restorationIdentifier == kMoreTabVCIdentifier
    }
    var isSelectedMore: Bool {
        restorationIdentifier?.hasPrefix(kMoreTabVCAtIndex) ?? false
    }
}

private extension Optional where Wrapped == [UIViewController] {
    var initialMoreIndex: Int? {
        self?.enumerated().filter { $1.isInitialMore }.last?.offset
    }

    var selectedMoreIndex: Int? {
        self?.enumerated().filter { $1.isSelectedMore }.last?.offset
    }
    
    func selectedViewController(from gesture: UITapGestureRecognizer) -> UIViewController? {
        guard let selectedView = gesture.view as? UIStackView else { return nil }
        return self?.first(where: { $0.restorationIdentifier == "\(kMoreTabVCAtIndex)\(selectedView.tag)" })
    }
    
    mutating func replaceSelected(with viewController: UIViewController) {
        guard let index = selectedMoreIndex else { return }
        self?[index] = viewController
    }
}
#endif
