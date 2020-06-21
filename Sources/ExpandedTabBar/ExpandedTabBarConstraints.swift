//
//  ExpandedTabBarConstraints.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/28/19.
//  Copyright © 2019 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import Foundation
import UIKit

// MARK: - View adding extension
internal extension ExpandedTabBarController {

    // MARK: Add background view
    /// Adding Constraints on background view
    func addBackgroundView() {
        
        backgroundView = ExpandedTabBarViews.clearView
        
        backgroundView.backgroundColor = options.background.color.withAlphaComponent(options.background.alpha)
        
        view.addSubview(backgroundView)
        
        let offset: CGFloat = tabBar.bounds.size.height
        
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        let bottomConstraint = backgroundView.connect(to: view, on: .bottom, constant: -1 * offset)
        
        view.addConstraints([
            backgroundView.connect(to: view, on: .top),
            backgroundView.connect(to: view, on: .right),
            backgroundView.connect(to: view, on: .left),
            bottomConstraint
        ])

        bgViewBottomConstraint = bottomConstraint
    }

    // MARK: Add Inner Container View
    /// Adding Constraints on background's inner view
    func addInnerContainerView() {
        innerContainer.backgroundColor = .clear
        backgroundView.addSubview(innerContainer)
        
        innerContainer.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraints([
            innerContainer.connect(to: backgroundView, on: .top),
            innerContainer.connect(to: backgroundView, on: .right),
            innerContainer.connect(to: backgroundView, on: .left),
            innerContainer.connect(to: backgroundView, on: .bottom),
        ])
    }

    // MARK: Add Indicator view
    /// Adding Constraints on indicator view
    func addIndicatorView() {
        let color = options.container.color.withAlphaComponent(options.container.alpha)
        indicatorView = options.indicatorType.view(color: color)
            
        backgroundView.addSubview(indicatorView)
        
        let size = options.indicatorType.size(bottomMargin: options.container.bottomMargin)

        let height = [.none, .connectedLine].contains(options.indicatorType) ? 0 : -1 * options.container.bottomMargin

        indicatorView.translatesAutoresizingMaskIntoConstraints = false

        let rightConstraint = indicatorView.connect(to: backgroundView, on: .right, constant: -1 * indicatorRightMargin)
        
        backgroundView.addConstraints([
            indicatorView.add(constant: size.width, on: .width),
            indicatorView.add(constant: size.height, on: .height),
            indicatorView.connect(to: backgroundView, on: .bottom, constant: height),
            rightConstraint
        ])

        indicatorRightConstraint = rightConstraint
        
    }

    // MARK: Adding container view to bgView
    /// Adding container view to background
    func addContainerView(with items: [UIStackView]) {

        let parentContainerView = ContainerView.create(for: tabBar)
        parentContainerView.roundCorners(corners: options.container.roundedCorners,
                                         radius: options.container.cornerRadius)
        parentContainerView.setOptions(options.container)
        parentContainerView.indicatorView = indicatorView
        
        backgroundView.addSubview(parentContainerView)

        parentContainerView.addArrangedSubviews(items)
        
        let oneItemHeight = options.container.tab.itemHeight + options.container.tabSpace
        let suggestedHeight = oneItemHeight * CGFloat(moreViewControllers?.count ?? 0) + 30 - options.container.tabSpace
        let maxSize = ExpandedTabBarViews.containerMaxSize
        let containerHeight = suggestedHeight > maxSize.height ? maxSize.height : suggestedHeight
        
        parentContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        let widthConstraint = parentContainerView.add(constant: 150, on: .width)
        let heightConstraint = parentContainerView.add(constant: containerHeight, on: .height)
        
        backgroundView.addConstraints([
            parentContainerView.connect(to: indicatorView, on: .trailing, constant: 10),
            parentContainerView.connect(to: indicatorView, on: .bottom, to: .top),
            widthConstraint,
            heightConstraint
        ])

        parentViewWidthConstraint = widthConstraint
        parentViewHeightConstraint = heightConstraint

        self.parentContainerView = parentContainerView
    }
    
    /// Content indicator right margin.
    var indicatorRightMargin: CGFloat {
        guard let itemFrame = (tabBar.items?.last?.value(forKey: "view") as? UIView)?.frame else { return 0 }
        
        let size = options.indicatorType.size(bottomMargin: options.container.bottomMargin)
        
        return UIScreen.main.bounds.size.width - (itemFrame.origin.x + itemFrame.size.width / 2 + size.width / 2)
    }
    
}
#endif
