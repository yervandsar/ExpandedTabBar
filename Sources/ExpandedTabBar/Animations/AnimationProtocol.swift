//
//  AnimationProtocol.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/12/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

/// AnimationProtocol declaration.
public protocol AnimationProtocol: AnyObject {
    
    /// Animation Duration.
    var duration: TimeInterval { get }
    
    /// `Optional Method:` Notify before show animation start.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    func willShow(container: ContainerView, background: UIView)
    
    /// Show container on background.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    func show(container: ContainerView, on background: UIView)
    
    /// `Optional Method:` Notify on show animation finish.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    func didShow(container: ContainerView, background: UIView)
    
    /// `Optional Method:` Notify before hide animation start.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    func willHide(container: ContainerView, background: UIView)
    
    /// Hide container from background.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    func hide(container: ContainerView, from background: UIView)
    
    /// `Optional Method:` Notify on hide animation finish.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    func didHide(container: ContainerView, background: UIView)
}

// MARK: - Extension for optional parameters & methods

public extension AnimationProtocol {

    /// Animation Duration.
    var duration: TimeInterval { 0.3 }
    
    /// `Optional Method:` Notify before show animation start.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    func willShow(container: ContainerView, background: UIView) { }

    /// `Optional Method:` Notify on show animation finish.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    func didShow(container: ContainerView, background: UIView) { }
    
    /// `Optional Method:` Notify before hide animation start.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    func willHide(container: ContainerView, background: UIView) { }
    
    /// `Optional Method:` Notify on hide animation finish.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    func didHide(container: ContainerView, background: UIView) { }
}
#endif
