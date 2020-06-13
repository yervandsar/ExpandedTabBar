//
//  UIImage+Bundle.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/9/18.
//  Copyright © 2018 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)

import UIKit

extension UIImage {
    
    convenience init?(namedInCurrentBundle: String) {
        self.init(named: namedInCurrentBundle, in: Bundle(for: ExpandedTabBarController.self), compatibleWith: nil)
    }
    
}
#endif
