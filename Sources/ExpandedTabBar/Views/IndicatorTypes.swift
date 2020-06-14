//
//  IndicatorTypes.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/13/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

/// IndicatorTypes declaration
public enum IndicatorTypes {
    case none
    case line
    case connectedLine
    case triangle
    case square
    
    /// Default is .triangle
    public static var `default`: IndicatorTypes { .triangle }
    
    public func view(color: UIColor = .pattern(light: .white, dark: .black)) -> UIView {
        switch self {
        case .none:
            return IndicatorTypes.line.view(color: .clear)
        case .line, .square, .connectedLine:
            let view = UIView()
            view.backgroundColor = color
            view.layer.zPosition = 2
            return view
        case .triangle:
            return TriangleView.create(color: color)
        }
    }
    
    public func size(bottomMargin: CGFloat) -> CGSize {
        switch self {
        case .none, .connectedLine:
            return .init(width: 2, height: bottomMargin)
        case .line:
            return .init(width: 2, height: bottomMargin / 2)
        case .square:
            return .init(width: 10, height: 10)
        case .triangle:
            return .init(width: 20, height: 10)
        }
    }
}
#endif
