//
//  Constraints+Extensions.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/12/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//

import UIKit

internal extension NSLayoutConstraint {
    func withPriority(_ priority: Float) -> NSLayoutConstraint {
        self.priority = UILayoutPriority(priority)
        return self
    }
}
