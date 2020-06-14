//
//  UIView+Extensions.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/13/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

public extension UIView {
    
    /// Get constrains on attributes with second view.
    /// - Parameters:
    ///   - attribute: First attribute.
    ///   - attribute2: Second attribute.
    ///   - view: Second view.
    /// - Returns: Constraint if exist.
    func constraint(_ attribute: NSLayoutConstraint.Attribute,
                    attribute2: NSLayoutConstraint.Attribute? = nil,
                    with view: UIView? = nil) -> NSLayoutConstraint? {
        
        constraints.first {
            ($0.firstItem?.isEqual(view) ?? false) &&
                $0.firstAttribute == attribute &&
                $0.relation == .equal &&
                $0.secondAttribute == (attribute2 ?? attribute)
        }

    }
    
    /// Set shadow on view with ShadowOptions
    /// - Parameter options: ShadowOptions
    func setShadow(_ options: ShadowOptions) {
        layer.shadowColor = options.color.cgColor
        layer.shadowOpacity = options.opacity
        layer.shadowOffset = options.offset
        layer.shadowRadius = options.radius
        layer.shouldRasterize = true

        layer.masksToBounds = false
        layer.rasterizationScale = UIScreen.main.scale
    }
}

internal extension UIView {
    func connect(to view: UIView? = nil,
                 on attribute: NSLayoutConstraint.Attribute,
                 to attribute2: NSLayoutConstraint.Attribute? = nil,
                 multiplier: CGFloat = 1.0,
                 constant: CGFloat = 0.0) -> NSLayoutConstraint {

        NSLayoutConstraint(
            item: self,
            attribute: attribute,
            relatedBy: .equal,
            toItem: view,
            attribute: attribute2 ?? attribute,
            multiplier: multiplier,
            constant: constant
        )
    }

    func add(constant: CGFloat, on attribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint {
        connect(to: nil, on: attribute, to: .notAnAttribute, constant: constant)
    }
}
#endif
