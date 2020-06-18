//
//  AnimationType.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/12/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

/// AnimationType declaration.
public enum AnimationType {

    case none
    
    case crossDissolve
    
    case top
    case left
    case right
    case bottom
    
    case zoomIn
    case zoomOut
    case zoomX
    case zoomY
    
    case rotatePositive
    case rotateNegarive
    case rotate(angle: CGFloat)
    
    case custom(AnimationProtocol)
    
    /// Default is .top
    public static var `default`: AnimationType { .top }
    
    public var animation: AnimationProtocol {
        switch self {
        case .none:
            return NoneAnimation()
        case .crossDissolve:
            return NoneAnimation(duration: 0.3)
        case .top:
            return TranslateAnimation(y: UIScreen.main.bounds.size.height)
        case .left:
            return TranslateAnimation(x: -UIScreen.main.bounds.size.width)
        case .right:
            return TranslateAnimation(x: UIScreen.main.bounds.size.width)
        case .bottom:
            return TranslateAnimation(y: -UIScreen.main.bounds.size.height)
        case .zoomIn:
            return ZoomAnimation(x: 0, y: 0)
        case .zoomOut:
            return ZoomAnimation(x: 2, y: 2)
        case .zoomX:
            return ZoomAnimation(x: 0, y: 1)
        case .zoomY:
            return ZoomAnimation(x: 1, y: 0)
        case .rotatePositive:
            return RotateAnimation(rotationAngle: .pi / 2)
        case .rotateNegarive:
            return RotateAnimation(rotationAngle: -(.pi / 2))
        case .rotate(angle: let angle):
            return RotateAnimation(rotationAngle: angle)
        case .custom(let animation):
            return animation
        }
    }
}
#endif
