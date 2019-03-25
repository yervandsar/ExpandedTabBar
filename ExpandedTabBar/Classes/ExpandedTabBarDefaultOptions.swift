//
//  ExpandedTabBarDefaultOptions.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/13/18.
//  Copyright © 2018 Yervand Saribekyan. All rights reserved.
//

import UIKit

public struct ExpandedTabBarDefaultOptions {
    init() {}
    /// Background view options
    static let backgroundColor: UIColor = .black
    static let backgroundAlpha: CGFloat = 0.4
    static let addCloseGestureToBackground: Bool = true
    
    /// List's container options
    static let containerBackgroundColor: UIColor = .white
    static let containerBackgroundAlpha: CGFloat = 1.0
    static let containerCornerRadius: CGFloat = 10
    static let containerBottomMargin: CGFloat = 15
    static let containerItemsSpace: CGFloat = 8

    /// Item View Options
    static let titleFont: UIFont = .systemFont(ofSize: 16)
    static let titleColor: UIColor = .black
    static let itemHeight: CGFloat = 35.0
    static let imageContentMode: UIView.ContentMode = .scaleAspectFit
    static let spaceBetweenImageTitle: CGFloat = 8

}

public struct ExpandedTabBarShadowDefaultOptions {
    init() {}

    static let color: UIColor = .black
    static let offset: CGSize = .zero
    static let opacity: Float = 0.5
    static let radius: CGFloat = 5

}
