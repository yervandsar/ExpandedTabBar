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
    case connectedLine
    case triangle
    
    /// Default is .triangle
    public static var `default`: IndicatorTypes { .triangle }
    
    public func view(color: UIColor = .pattern(light: .white, dark: .black)) -> UIView {
        switch self {
        case .none:
            return IndicatorTypes.connectedLine.view(color: .clear)
        case .connectedLine:
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
        case .triangle:
            return .init(width: 20, height: 10)
        }
    }
}
#endif
