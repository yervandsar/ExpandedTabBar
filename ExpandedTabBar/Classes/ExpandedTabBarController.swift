//
//  ExpandedTabBarController.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/9/18.
//  Copyright © 2018 Yervand Saribekyan. All rights reserved.
//

import UIKit
import SystemConfiguration

let kMoreTabVCIdentifier = "_UIExpandedTabBarMore"
let kMoreTabVCAtIndex = "_UIExpandedTabBarMoreAt"
let kMoreStackAtIndex = "_UIExpandedTabBarMoreStackAt"

@objc public protocol ExpandedTabBarControllerDelegate: class {
    func expandedTabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController, withItem tabBarItem: UITabBarItem?)
}

open class ExpandedTabBarController: UITabBarController {

    @IBInspectable
    public var moreTitle: String = "More"

    @IBInspectable
    public var moreIcon: UIImage? = UIImage(namedInCurrentBundle: "IC_EXPANDEDTabBAR_MORE")

    @IBInspectable
    public var moreSelectedIcon: UIImage?

    public var options: ExpandedTabBarOptions = .default {
        didSet {
            if let vcArray = viewControllers, !vcArray.isEmpty {
                backgroundView.removeFromSuperview()
                self.setup(viewControllers: vcArray)
            }
        }
    }

    public weak var expandedDelegate: ExpandedTabBarControllerDelegate?

    private var containerBottomMargin: CGFloat = 15
    private var moreItemHeight: CGFloat = 35

    private var backgroundView = UIView()
    private var triangleView = TriangleView()
    private var parentContainerView = UIView()
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()

    private(set) var moreViewControllers: [UIViewController]?

    private var triangleRightConstraint: NSLayoutConstraint?
    private var bgViewBottomConstraint: NSLayoutConstraint?

    private var triangleBottomConstraint: NSLayoutConstraint?

    private var parentViewWidthConstraint: NSLayoutConstraint?
    
    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.refreshContainerPosition(with: size)
        }
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate = self
        if let vcArray = viewControllers, !vcArray.isEmpty {
            self.setup(viewControllers: vcArray)
        }
    }

    public func setup(viewControllers array: [UIViewController]) {
        guard array.count > 5 else { return }
        let itemsForShow = Array(array[0..<4])
        moreViewControllers = Array(array[4..<array.count])
            .enumerated().map {
                $1.restorationIdentifier = "\(kMoreTabVCAtIndex)\($0)"
                return $1
        }
        self.viewControllers = itemsForShow
        self.viewControllers?.append(moreViewController())
        addMoreView()
    }

    internal func refreshContainerPosition(with size: CGSize) {
        guard let itemFrame = (self.tabBar.items?.last?.value(forKey: "view") as? UIView)?.frame else { return }
        let right = size.width - (itemFrame.origin.x + itemFrame.size.width / 2 + 10)
        self.triangleRightConstraint?.constant = -1 * right
        self.bgViewBottomConstraint?.constant = -1 * self.tabBar.bounds.size.height
    }

    private func moreViewController() -> UIViewController {
        let vc = UIViewController()
        vc.restorationIdentifier = kMoreTabVCIdentifier
        vc.tabBarItem = UITabBarItem(title: moreTitle, image: moreIcon, selectedImage: moreSelectedIcon)
        return vc
    }

    private func showMoreContainer() {
        let containerWidth = stackView.frame.size.width > ExpandedTabBarViews.calculateMoreContainerMaxSize().width ?
            ExpandedTabBarViews.calculateMoreContainerMaxSize().width : stackView.frame.size.width
        parentViewWidthConstraint?.constant = containerWidth < 160 ? 200 : containerWidth + 40
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.backgroundView.alpha = 1
            if let bottom = strongSelf.triangleBottomConstraint,
                bottom.constant == 3000 {
                bottom.constant = -1 * strongSelf.containerBottomMargin
                strongSelf.backgroundView.layoutIfNeeded()
            }
        }
    }

    private func hideMoreContainer() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.backgroundView.alpha = 0
            if let bottom = strongSelf.triangleBottomConstraint,
                bottom.constant == -1 * strongSelf.containerBottomMargin {
                bottom.constant = 3000
                strongSelf.backgroundView.layoutIfNeeded()
            }
        }
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

}

extension ExpandedTabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let isInitialMore = viewController.restorationIdentifier == kMoreTabVCIdentifier
        let isSelectedMore = viewController.restorationIdentifier?.hasPrefix(kMoreTabVCAtIndex) ?? false
        if isInitialMore {
            backgroundView.alpha != 0 ? deselectMore() : showMoreContainer()
        } else if isSelectedMore {
            backgroundView.alpha != 0 ? hideMoreContainer() : showMoreContainer()
        }
        return !isInitialMore && !isSelectedMore
    }

    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        deselectMore()
    }

    private func deselectMore() {
        hideMoreContainer()
        guard let vcArray = viewControllers else { return }
        let index = vcArray
            .enumerated()
            .compactMap { index, vc -> Int? in
                return (vc.restorationIdentifier?.hasPrefix(kMoreTabVCAtIndex) ?? false) ? index : nil
            }
            .last
        guard let i = index else { return }
        viewControllers?[i] = moreViewController()
    }

    @objc private func itemTapped(_ sender: UITapGestureRecognizer) {
        guard let selectedView = sender.view as? UIStackView,
            let selectedVC = moreViewControllers?
                .first(where: { $0.restorationIdentifier == "\(kMoreTabVCAtIndex)\(selectedView.tag)" }),
            let vcArray = viewControllers else { return }
        let index1 = vcArray
            .enumerated()
            .compactMap { index, vc -> Int? in
                return vc.restorationIdentifier == kMoreTabVCIdentifier ? index : nil
            }
            .last

        let index2 = vcArray
            .enumerated()
            .compactMap { index, vc -> Int? in
                return (vc.restorationIdentifier?.hasPrefix(kMoreTabVCAtIndex) ?? false) ? index : nil
            }
            .last

        guard let i = index1 ?? index2 else {
            hideMoreContainer()
            return
        }
        let tabBarItem = selectedVC.tabBarItem
        selectedVC.tabBarItem = moreViewController().tabBarItem
        viewControllers?[i] = selectedVC
        self.selectedIndex = i
        hideMoreContainer()
        expandedDelegate?.expandedTabBarController(self, didSelect: selectedVC, withItem: tabBarItem)
    }
}

/// Adding Views
private extension ExpandedTabBarController {

    func addMoreView() {
        moreItemHeight = options.itemHeight
        containerBottomMargin = options.containerBottomMargin

        backgroundView = ExpandedTabBarViews.bgView()
        backgroundView.backgroundColor = options.backgroundColor.withAlphaComponent(options.backgroundAlpha)

        triangleView = ExpandedTabBarViews.triangleView()
        triangleView.layer.zPosition = 2
        triangleView.color = options.containerBackgroundColor.withAlphaComponent(options.containerBackgroundAlpha)

        parentContainerView = ExpandedTabBarViews.moreItemsContainerView()
        parentContainerView.layer.zPosition = 1
        parentContainerView.backgroundColor = options.containerBackgroundColor.withAlphaComponent(options.containerBackgroundAlpha)
        parentContainerView.layer.cornerRadius = options.containerCornerRadius
        if let shadowOptions = options.shadow {
            self.setShadow(with: shadowOptions, to: parentContainerView)
        }

        backgroundView.addSubview(parentContainerView)
        backgroundView.addSubview(triangleView)
        view.addSubview(backgroundView)

        tabBar.layoutSubviews()

        addBGViewWithConstraints()
        addTriangleConstraints(to: backgroundView)
        addScrollView()
        addStackView()

        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = options.containerItemsSpace
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(
            top: 15,
            left: 15,
            bottom: 15,
            right: 15
        )

        if let moreVCArray = moreViewControllers {
            moreVCArray
                .enumerated()
                .compactMap { [weak self] index, vc -> UIStackView? in
                    guard let strongSelf = self else { return nil }
                    return ExpandedTabBarViews
                        .moreItemView(
                            for: vc.tabBarItem,
                            at: index,
                            itemHeight: strongSelf.moreItemHeight,
                            target: self,
                            action: #selector(itemTapped(_:)),
                            options: strongSelf.options
                    )
                }
                .forEach { [weak self] stackView in
                    guard let strongSelf = self else { return  }
                    strongSelf.stackView.addArrangedSubview(stackView)
            }
        }
        addContainerViewConstraints(to: backgroundView)
        refreshContainerPosition(with: view.frame.size)
        hideMoreContainer()
    }

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

        bgViewBottomConstraint = NSLayoutConstraint(
            item: backgroundView,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: view,
            attribute: .bottom,
            multiplier: 1.0,
            constant: -1 * tabBar.bounds.size.height
        )

        if let bottomConstraint = bgViewBottomConstraint {
            view.addConstraint(bottomConstraint)
        }
    }

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

    func addContainerViewConstraints(to bgView: UIView) {
        backgroundView.addSubview(parentContainerView)
        let suggestedHeight = (moreItemHeight + options.containerItemsSpace) * CGFloat((moreViewControllers ?? []).count) + 30 - options.containerItemsSpace
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

    func addScrollView() {
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

    func addStackView() {
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
