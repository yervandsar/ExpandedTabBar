//
//  CustomViewController.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/9/18.
//  Copyright © 2018 Yervand Saribekyan. All rights reserved.
//

import UIKit

final class CustomViewController: ExpandedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        expandedDelegate = self
        expandedTabBarOptions = customOptions
        
    }
    
    private var customOptions: Options {
        var options = ExpandedTabBarOptions()
        
        options.indicatorType = .connectedLine
        options.animationType = .custom(customAnimation)
        
        options.container.roundedCorners = [.topLeft, .topRight, .bottomLeft]
        options.container.cornerRadius = 20
        
        options.container.shadow = ShadowDefaultOptions()
        options.container.tabSpace = 15
        options.container.tab.iconTitleSpace = 15
        
        return options
    }
    
    private var customAnimation: AnimationProtocol {
        let transform = CGAffineTransform(scaleX: 0.1, y: 0.1).rotated(by: .pi)
        return TransformAnimation(transform: transform)
    }
    
}

extension CustomViewController: ExpandedTabBarControllerDelegate {
    func expandedTabBarController(_ tabBarController: UITabBarController,
                                  didSelect viewController: UIViewController,
                                  withItem tabBarItem: UITabBarItem?) {
        // Do some logic here
    }
}

