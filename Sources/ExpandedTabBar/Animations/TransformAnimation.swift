//
//  TransformAnimation.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/13/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit
// MARK: - TransformAnimation

/// TransformAnimation Declaration.
open class TransformAnimation: AnimationProtocol {
    
    private let transform: CGAffineTransform
    
    init(transform: CGAffineTransform) {
        self.transform = transform
    }
    
    /// `Optional Method:` Notify before show animation start.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    public func willShow(container: ContainerView, background: UIView) {
        container.indicatorView.alpha = 0
        container.subviews.forEach { $0.layoutSubviews() }
    }

    /// Show container on background.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    public func show(container: ContainerView, on background: UIView) {
        container.transform = .identity
        container.subviews.forEach { $0.layoutSubviews() }
    }
    
    /// `Optional Method:` Notify on show animation finish.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    public func didShow(container: ContainerView, background: UIView) {
        container.indicatorView.alpha = 1
        container.subviews.forEach { $0.layoutSubviews() }
    }
    
    /// `Optional Method:` Notify before hide animation start.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    public func willHide(container: ContainerView, background: UIView) {
        container.indicatorView.alpha = 0
    }
    
    /// Hide container from background.
    /// - Parameters:
    ///   - container: More container view.
    ///   - background: Background view.
    public func hide(container: ContainerView, from background: UIView) {
        container.transform = transform
    }

}

// MARK: - TranslateAnimation

/// TranslateAnimation Declaration.
public final class TranslateAnimation: TransformAnimation {

    init(x: CGFloat, y: CGFloat) {
        super.init(transform: CGAffineTransform(translationX: x, y: y))
    }

    init(x: CGFloat) {
        super.init(transform: CGAffineTransform(translationX: x, y: 1))
    }

    init(y: CGFloat) {
        super.init(transform: CGAffineTransform(translationX: 1, y: y))
    }

}

// MARK: - ZoomAnimation

/// ZoomAnimation Declaration.
public final class ZoomAnimation: TransformAnimation {

    init(x: CGFloat, y: CGFloat) {
        super.init(transform: CGAffineTransform(scaleX: max(x, 0.1), y: max(y, 0.1)))
    }

}

// MARK: - RotateAnimation

/// RotateAnimation Declaration.
public final class RotateAnimation: TransformAnimation {

    init(rotationAngle: CGFloat) {
        super.init(transform: CGAffineTransform(rotationAngle: rotationAngle))
    }

}

#endif
