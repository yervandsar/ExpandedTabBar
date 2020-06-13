//
//  CustomViewController.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/9/18.
//  Copyright © 2018 Yervand Saribekyan. All rights reserved.
//

import UIKit

class CustomViewController: ExpandedTabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        expandedDelegate = self
        initOptions()
        
    }
    
    private func initOptions() {
        let container = options.container
        container.shadow = ShadowOptionsFactory()
        container.tabSpace = 15
        container.tab.iconTitleSpace = 15
    }
    
}

extension CustomViewController: ExpandedTabBarControllerDelegate {
    func expandedTabBarController(_ tabBarController: UITabBarController,
                                  didSelect viewController: UIViewController,
                                  withItem tabBarItem: UITabBarItem?) {
        // Do some logic here
    }
}

