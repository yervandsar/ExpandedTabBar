//
//  UITabBar+Extensions.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/13/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//

import UIKit

internal extension UITabBar {
    var moreFrame: CGRect {
        (items?.last?.value(forKey: "view") as? UIView)?.frame ?? .zero
    }
}
