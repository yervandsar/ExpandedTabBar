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
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let isInitialMore = viewController.restorationIdentifier == kMoreTabVCIdentifier
        let isSelectedMore = viewController.restorationIdentifier?.hasPrefix(kMoreTabVCAtIndex) ?? false
        if isInitialMore {
            backgroundView.alpha != 0 ? deselectMore() : showMoreContainer()
        } else if isSelectedMore {
            backgroundView.alpha != 0 ? hideMoreContainer() : showMoreContainer()
        }
        return !isInitialMore && !isSelectedMore
    }

    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        deselectMore()
    }

    private func deselectMore() {
        hideMoreContainer()
        guard let vcArray = viewControllers else { return }
        let index = vcArray
            .enumerated()
            .compactMap { index, vc -> Int? in
                return (vc.restorationIdentifier?.hasPrefix(kMoreTabVCAtIndex) ?? false) ? index : nil
            }
            .last
        guard let i = index else { return }
        viewControllers?[i] = moreViewController()
    }

    @objc internal func itemTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedView = sender.view as? UIStackView,
            let selectedVC = moreViewControllers?
                .first(where: { $0.restorationIdentifier == "\(kMoreTabVCAtIndex)\(selectedView.tag)" }),
            let vcArray = viewControllers else { return }
        hideMoreContainer()
        let index1 = vcArray
            .enumerated()
            .compactMap { index, vc -> Int? in
                return vc.restorationIdentifier == kMoreTabVCIdentifier ? index : nil
            }
            .last

        let index2 = vcArray
            .enumerated()
            .compactMap { index, vc -> Int? in
                return (vc.restorationIdentifier?.hasPrefix(kMoreTabVCAtIndex) ?? false) ? index : nil
            }
            .last

        guard let i = index1 ?? index2 else {
            return
        }
        let tabBarItem = selectedVC.tabBarItem
        selectedVC.tabBarItem = moreViewController().tabBarItem
        viewControllers?[i] = selectedVC
        self.selectedIndex = i
        expandedDelegate?.expandedTabBarController(self, didSelect: selectedVC, withItem: tabBarItem)
    }
}
#endif
