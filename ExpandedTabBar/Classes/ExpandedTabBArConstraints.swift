//
//  ExpandedTabBArConstraints.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/28/19.
//  Copyright © 2019 Yervand Saribekyan. All rights reserved.
//

import Foundation
import UIKit

// MARK: - ExpandedTabBarController's extension for adding constraints
internal extension ExpandedTabBarController {

    // MARK: Adding Constraints on background view
    /// Adding Constraints on background view
    func addBGViewWithConstraints() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(
            item: backgroundView,
            attribute: .top,
            relatedBy: .equal,
            toItem: view,
            attribute: .top,
            multiplier: 1.0,
            constant: 0
        )
        let rightConstraint = NSLayoutConstraint(
            item: backgroundView,
            attribute: .right,
            relatedBy: .equal,
            toItem: view,
            attribute: .right,
            multiplier: 1.0,
            constant: 0
        )
        let leftConstraint = NSLayoutConstraint(
            item: backgroundView,
            attribute: .left,
            relatedBy: .equal,
            toItem: view,
            attribute: .left,
            multiplier: 1.0,
            constant: 0
        )
        view.addConstraints([
            topConstraint,
            rightConstraint,
            leftConstraint
            ])

        let offset: CGFloat = tabBar.bounds.size.height
        bgViewBottomConstraint = NSLayoutConstraint(
            item: backgroundView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -1 * offset
        )

        if let bottomConstraint = bgViewBottomConstraint {
            view.addConstraint(bottomConstraint)
        }
    }

    // MARK: Adding Constraints on background's inner view
    /// Adding Constraints on background's inner view
    func addInnerContainerConstraints() {
        innerContainer.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(
            item: innerContainer,
            attribute: .top,
            relatedBy: .equal,
            toItem: backgroundView,
            attribute: .top,
            multiplier: 1.0,
            constant: 0
        )
        let rightConstraint = NSLayoutConstraint(
            item: innerContainer,
            attribute: .right,
            relatedBy: .equal,
            toItem: backgroundView,
            attribute: .right,
            multiplier: 1.0,
            constant: 0
        )
        let leftConstraint = NSLayoutConstraint(
            item: innerContainer,
            attribute: .left,
            relatedBy: .equal,
            toItem: backgroundView,
            attribute: .left,
            multiplier: 1.0,
            constant: 0
        )

        let bottomConstraint = NSLayoutConstraint(
            item: innerContainer,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: backgroundView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0
        )

        view.addConstraints([
            topConstraint,
            rightConstraint,
            leftConstraint,
            bottomConstraint
            ])
    }

    // MARK: Adding Constraints on triangle view
    /// Adding Constraints on triangle view
    ///
    /// - Parameter bgView: Background view for triangle
    func addTriangleConstraints(to bgView: UIView) {
        guard let itemFrame = (tabBar.items?.last?.value(forKey: "view") as? UIView)?.frame else { return }
        let right = UIScreen.main.bounds.size.width - (itemFrame.origin.x + itemFrame.size.width / 2 + 10)
        triangleView.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(
            item: triangleView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 20
        )
        let heightConstraint = NSLayoutConstraint(
            item: triangleView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 10
        )
        bgView.addConstraints([
            widthConstraint,
            heightConstraint
            ])

        triangleBottomConstraint = NSLayoutConstraint(
            item: triangleView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: bgView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -1 * containerBottomMargin
        )
        if let bottomConstrain = triangleBottomConstraint {
            bgView.addConstraint(bottomConstrain)
        }

        triangleRightConstraint = NSLayoutConstraint(
            item: triangleView,
            attribute: .right,
            relatedBy: .equal,
            toItem: bgView,
            attribute: .right,
            multiplier: 1.0,
            constant: -1 * right
        )
        if let rightConstraint = triangleRightConstraint {
            bgView.addConstraint(rightConstraint)
        }
    }

    // MARK: Adding container view to bgView
    /// Adding container view to bgView
    ///
    /// - Parameter bgView: Background view for container
    func addContainerViewConstraints(to bgView: UIView) {
        backgroundView.addSubview(parentContainerView)
        let oneItemHeight = moreItemHeight + options.containerItemsSpace
        let suggestedHeight = oneItemHeight * CGFloat((moreViewControllers ?? []).count) + 30 - options.containerItemsSpace
        let containerHeight = suggestedHeight > ExpandedTabBarViews.calculateMoreContainerMaxSize().height ?
            ExpandedTabBarViews.calculateMoreContainerMaxSize().height : suggestedHeight
        parentContainerView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(
            item: parentContainerView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: containerHeight
        )
        let bottomConstraint = NSLayoutConstraint(
            item: parentContainerView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: triangleView,
            attribute: .top,
            multiplier: 1.0,
            constant: 0
        )
        let trallingConstraint = NSLayoutConstraint(
            item: parentContainerView,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: triangleView,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 10
        )
        bgView.addConstraints([
            bottomConstraint,
            heightConstraint,
            trallingConstraint
            ])
        parentViewWidthConstraint = NSLayoutConstraint(
            item: parentContainerView,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: 150
        )
        if let widthConstraint = parentViewWidthConstraint {
            bgView.addConstraint(widthConstraint)
        }
    }

    // MARK: Adding scrollView in container
    /// Adding scrollView in container
    func addScrollViewConstraints() {
        parentContainerView.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(
            item: scrollView,
            attribute: .top,
            relatedBy: .equal,
            toItem: parentContainerView,
            attribute: .top,
            multiplier: 1.0,
            constant: 0
        )
        let rightConstraint = NSLayoutConstraint(
            item: scrollView,
            attribute: .right,
            relatedBy: .equal,
            toItem: parentContainerView,
            attribute: .right,
            multiplier: 1.0,
            constant: 0
        )
        let leftConstraint = NSLayoutConstraint(
            item: scrollView,
            attribute: .left,
            relatedBy: .equal,
            toItem: parentContainerView,
            attribute: .left,
            multiplier: 1.0,
            constant: 0
        )
        let bottomConstraint = NSLayoutConstraint(
            item: scrollView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: parentContainerView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0
        )
        parentContainerView.addConstraints([
            topConstraint,
            rightConstraint,
            bottomConstraint,
            leftConstraint
            ])
    }

    // MARK: Adding stackView in scrollView
    /// Adding stackView in scrollView
    func addStackViewConstraints() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let topConstraint = NSLayoutConstraint(
            item: stackView,
            attribute: .top,
            relatedBy: .equal,
            toItem: scrollView,
            attribute: .top,
            multiplier: 1.0,
            constant: 0
        )
        let rightConstraint = NSLayoutConstraint(
            item: stackView,
            attribute: .right,
            relatedBy: .equal,
            toItem: scrollView,
            attribute: .right,
            multiplier: 1.0,
            constant: 0
        )
        let leftConstraint = NSLayoutConstraint(
            item: stackView,
            attribute: .left,
            relatedBy: .equal,
            toItem: scrollView,
            attribute: .left,
            multiplier: 1.0,
            constant: 0
        )
        let bottomConstraint = NSLayoutConstraint(
            item: stackView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: scrollView,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0
        )
        let heightConstraint = NSLayoutConstraint(
            item: stackView,
            attribute: .height,
            relatedBy: .equal,
            toItem: scrollView,
            attribute: .height,
            multiplier: 1.0,
            constant: 150
        )
        heightConstraint.priority = UILayoutPriority(Float(250))
        scrollView.addConstraints([
            topConstraint,
            rightConstraint,
            bottomConstraint,
            leftConstraint,
            heightConstraint
            ])
    }
}
