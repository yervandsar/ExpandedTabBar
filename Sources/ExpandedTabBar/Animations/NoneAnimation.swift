//
//  NoneAnimation.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/12/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

/// NoneAnimation Declaration.
public final class NoneAnimation: AnimationProtocol {
    
    /// Animation Duration.
    public var duration: TimeInterval
    
    /// Show container on background.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    public func show(container: ContainerView, on background: UIView) { }
    
    /// Hide container from background.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    public func hide(container: ContainerView, from background: UIView) { }
    
    /// Intialize with duration
    /// - Parameter duration: TimeInterval. `Default is 0.0`
    init(duration: TimeInterval = 0.0) {
        self.duration = duration
    }

}
#endif
