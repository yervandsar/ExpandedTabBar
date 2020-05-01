//
//  ExpandedTabBarStackView.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/28/19.
//  Copyright © 2019 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)

import Foundation
import UIKit

/// Adding Views
internal extension ExpandedTabBarController {

    func addMoreView() {
        view.addSubview(background())
        tabBar.layoutSubviews()
        addBGViewWithConstraints()
        addTriangleConstraints(to: backgroundView)
        addScroll()
        addStack()
        addGestures()

        if let moreVCArray = moreViewControllers?.enumerated() {
            moreVCArray.compactMap { [weak self] index, vc -> UIStackView? in
                    guard let self = self else { return nil }
                    return self.stackViewItem(for: vc, at: index)
                }
                .forEach { [weak self] stackView in
                    guard let self = self else { return  }
                    self.stackView.addArrangedSubview(stackView)
            }
        }
        addContainerViewConstraints(to: backgroundView)
        refreshContainerPosition(with: view.frame.size)
        hideMoreContainer()
    }

    private func stackViewItem(for vc: UIViewController, at index: Int) -> UIStackView? {
        return ExpandedTabBarViews.moreItemView(
                for: vc.tabBarItem,
                at: index,
                itemHeight: self.moreItemHeight,
                target: self,
                action: #selector(itemTapped(_:)),
                options: self.options
        )
    }



    func addGestures() {
        guard options.closeOnTap else { return }
        closeTapGesture = UITapGestureRecognizer(target: self, action: #selector(outsideTapped))
        innerContainer.backgroundColor = .clear
        backgroundView.addSubview(innerContainer)
        addInnerContainerConstraints()
        innerContainer.addGestureRecognizer(closeTapGesture)
    }


    private func setShadow(with options: ExpandedTabBarShadowOptions, to parentV: UIView) {
        parentV.layer.shadowColor = options.color.cgColor
        parentV.layer.shadowOpacity = options.opacity
        parentV.layer.shadowOffset = options.offset
        parentV.layer.shadowRadius = options.radius
        parentV.layer.shouldRasterize = true

        parentV.layer.masksToBounds = false
        parentV.layer.rasterizationScale = UIScreen.main.scale
    }

    private func background() -> UIView {
        backgroundView = ExpandedTabBarViews.bgView()
        backgroundView.backgroundColor = options.backgroundColor.withAlphaComponent(options.backgroundAlpha)
        backgroundView.addSubview(parentContainer())
        backgroundView.addSubview(triangle())
        return backgroundView
    }

    private func triangle() -> UIView {
        triangleView = ExpandedTabBarViews.triangleView()
        triangleView.layer.zPosition = 2
        triangleView.color = options.containerBackgroundColor.withAlphaComponent(options.containerBackgroundAlpha)
        return triangleView

    }

    private func parentContainer() -> UIView {
        moreItemHeight = options.itemHeight
        containerBottomMargin = options.containerBottomMargin
        parentContainerView = ExpandedTabBarViews.moreItemsContainerView()
        parentContainerView.layer.zPosition = 1
        parentContainerView.backgroundColor = options.containerBackgroundColor.withAlphaComponent(options.containerBackgroundAlpha)
        parentContainerView.layer.cornerRadius = options.containerCornerRadius
        if let shadowOptions = options.shadow {
            setShadow(with: shadowOptions, to: parentContainerView)
        }
        return parentContainerView
    }


    private func addScroll() {
        addScrollViewConstraints()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
    }

    private func addStack() {
        addStackViewConstraints()
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = options.containerItemsSpace
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15 )
    }
}
#endif
