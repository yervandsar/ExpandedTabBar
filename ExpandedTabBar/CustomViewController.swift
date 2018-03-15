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

    func initOptions() {
        var options = ExpandedTabBarOptions()
        options.backgroundAlpha = 0.3
        options.shadow = .default
        options.containerItemsSpace = 15 // Default 8.0
        options.spaceBetweenImageTitle = 15 // Default 8.0
        self.options = options
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CustomViewController: ExpandedTabBarControllerDelegate {
    func expandedTabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController, withItem tabBarItem: UITabBarItem?) {
        // Do some logic here
    }
}

