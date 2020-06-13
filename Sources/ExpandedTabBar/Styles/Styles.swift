//
//  Styles.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/11/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

/// Options protocol declaration.
public protocol Options: AnyObject {
    
    /// IndicatorType
    var indicatorType: IndicatorTypes { get set }
    
    /// AnimationType
    var animationType: AnimationType { get set }
    
    /// More container options
    var container: ContainerOptions { get set }
    
    /// More container's background options
    var background: BackgroundOptions { get set }
}

/// OptionsFactory declaration.
public final class OptionsFactory: Options {
    
    /// IndicatorType
    public var indicatorType: IndicatorTypes = .default
    
    /// AnimationType
    public var animationType: AnimationType = .default
    
    /// More container options
    public var container: ContainerOptions = ContainerOptionsFactory()
    
    /// More container's background options
    public var background: BackgroundOptions = BackgroundOptionsFactory()
    
    public init() { }
    
}
#endif
