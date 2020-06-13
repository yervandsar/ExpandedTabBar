//
//  ExpandedTabBarStackView.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/28/19.
//  Copyright © 2019 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)

import Foundation
import UIKit

/// Adding Views
internal extension ExpandedTabBarController {

    func addMoreView() {
        
        let items = moreViewControllers?.items(target: self, action: #selector(itemTapped(_:)), options: options)
        
        addBackgroundView()
        addInnerContainerView()
        addIndicatorView()
        addContainerView(with: items ?? [])
        
        addGestures()
        
        tabBar.layoutSubviews()
        
        refreshContainerPosition(with: view.frame.size)

        hideMoreContainer()
    }
}
// MARK: - Private Methods
private extension ExpandedTabBarController {

    func stackViewItem(for vc: UIViewController, at index: Int) -> UIStackView? {
        ExpandedTabBarViews.moreItemView(
            for: vc.tabBarItem,
            at: index,
            target: self,
            action: #selector(itemTapped(_:)),
            options: options
        )
    }

    func addGestures() {
        guard options.background.closeOnTap else { return }
        closeTapGesture = UITapGestureRecognizer(target: self, action: #selector(outsideTapped))
        innerContainer.addGestureRecognizer(closeTapGesture)
    }
}

private extension Array where Element == UIViewController {
    func items(target: Any?, action: Selector?, options: Options) -> [UIStackView] {
        enumerated().map {
            ExpandedTabBarViews.moreItemView(
                for: $1.tabBarItem,
                at: $0,
                target: target,
                action: action,
                options: options
            )
        }
    }
}
#endif
