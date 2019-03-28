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

    // MARK: - ViewControllers
    private(set) var moreViewControllers: [UIViewController]?

    // MARK: - Public Variables
    public weak var expandedDelegate: ExpandedTabBarControllerDelegate?

    // MARK: Inspectable parameters
    /// More Tab Tilte
    @IBInspectable public var moreTitle: String = "More"
    /// More Tab Icon
    @IBInspectable public var moreIcon: UIImage? = UIImage(namedInCurrentBundle: "IC_EXPANDEDTabBAR_MORE")
    /// More Tab Selected Icon. Default is nil.
    @IBInspectable public var moreSelectedIcon: UIImage?

    /// Expanded Tab Bar options. Default values can see in ExpandedTabBarDefaultOptions
    public var options: ExpandedTabBarOptions = .default {
        didSet {
            if let vcArray = viewControllers, !vcArray.isEmpty {
                backgroundView.removeFromSuperview()
                self.setup(viewControllers: vcArray)
            }
        }
    }

    // MARK: - Private Variables
    // MARK: Main Views
    internal var backgroundView = UIView()
    internal var innerContainer = UIView()
    internal var triangleView = TriangleView()
    internal var parentContainerView = UIView()
    internal let scrollView = UIScrollView()
    internal let stackView = UIStackView()

    // MARK: Constraints
    internal var triangleRightConstraint: NSLayoutConstraint?
    internal var bgViewBottomConstraint: NSLayoutConstraint?
    internal var triangleBottomConstraint: NSLayoutConstraint?
    internal var parentViewWidthConstraint: NSLayoutConstraint?

    internal var containerBottomMargin: CGFloat = 15
    internal var moreItemHeight: CGFloat = 35

    // MARK: - Gestures
    internal var closeTapGesture: UITapGestureRecognizer!


    // MARK: - Cycle

    override open func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            guard let self = self else { return }
            self.refreshContainerPosition(with: size)
        }
    }

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        delegate = self
        if let vcArray = viewControllers, !vcArray.isEmpty {
            self.setup(viewControllers: vcArray)
        }
    }

    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.refreshContainerPosition(with: UIScreen.main.bounds.size)
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

        let offset: CGFloat = tabBar.bounds.size.height
        self.triangleRightConstraint?.constant = -1 * right
        self.bgViewBottomConstraint?.constant = -1 * offset
    }

    internal func moreViewController() -> UIViewController {
        let vc = UIViewController()
        vc.restorationIdentifier = kMoreTabVCIdentifier
        vc.tabBarItem = UITabBarItem(title: moreTitle, image: moreIcon, selectedImage: moreSelectedIcon)
        return vc
    }

    internal func showMoreContainer() {
        let containerWidth = stackView.frame.size.width > ExpandedTabBarViews.calculateMoreContainerMaxSize().width ?
            ExpandedTabBarViews.calculateMoreContainerMaxSize().width : stackView.frame.size.width
        parentViewWidthConstraint?.constant = containerWidth < 160 ? 200 : containerWidth + 40
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.backgroundView.alpha = 1
            if let bottom = self.triangleBottomConstraint,
                bottom.constant == 3000 {
                bottom.constant = -1 * self.containerBottomMargin
                self.backgroundView.layoutIfNeeded()
            }
        }
    }

    internal func hideMoreContainer() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            guard let self = self else { return }
            self.backgroundView.alpha = 0
            if let bottom = self.triangleBottomConstraint,
                bottom.constant == -1 * self.containerBottomMargin {
                bottom.constant = 3000
                self.backgroundView.layoutIfNeeded()
            }
        }
    }

    @objc internal func outsideTapped() {
        self.hideMoreContainer()
    }

}
