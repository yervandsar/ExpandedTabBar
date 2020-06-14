//
//  ExpandedTabBarController.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/9/18.
//  Copyright © 2018 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)

import UIKit
import SystemConfiguration

let kMoreTabVCIdentifier = "_UIExpandedTabBarMore"
let kMoreTabVCAtIndex = "_UIExpandedTabBarMoreAt"
let kMoreStackAtIndex = "_UIExpandedTabBarMoreStackAt"

@objc public protocol ExpandedTabBarControllerDelegate: AnyObject {
    func expandedTabBarController(
        _ tabBarController: UITabBarController,
        didSelect viewController: UIViewController,
        withItem tabBarItem: UITabBarItem?)
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
    @IBInspectable public var moreIcon: UIImage?
    /// More Tab Selected Icon. Default is nil.
    @IBInspectable public var moreSelectedIcon: UIImage?

    /// Expanded Tab Bar options.
    public var expandedTabBarOptions: Options?
    
    internal var options: Options {
        expandedTabBarOptions ?? ExpandedTabBarOptions()
    }

    // MARK: - Private Variables
    // MARK: Main Views
    internal var backgroundView = UIView()
    internal var innerContainer = UIView()
    internal var indicatorView = UIView()
    
    internal var parentContainerView: ContainerView!

    // MARK: Constraints
    internal var indicatorRightConstraint: NSLayoutConstraint?
    internal var bgViewBottomConstraint: NSLayoutConstraint?
    internal var parentViewWidthConstraint: NSLayoutConstraint?
    internal var parentViewHeightConstraint: NSLayoutConstraint?

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
        self.hideMoreContainer()
    }

    internal func refreshContainerPosition(with size: CGSize) {
        let offset: CGFloat = tabBar.bounds.size.height
        bgViewBottomConstraint?.constant = -1 * offset

        let maxSize = ExpandedTabBarViews.containerMaxSize
        let containerWidth = min(maxSize.width - 40, parentContainerView.stackView.frame.size.width)
        let containerHeight = min(maxSize.height - 40, parentContainerView.stackView.frame.size.height)
        
        parentViewWidthConstraint?.constant = max(200, containerWidth)
        parentViewHeightConstraint?.constant = containerHeight

        indicatorRightConstraint?.constant = -1 * indicatorRightMargin
    }

    internal func moreViewController() -> UIViewController {
        let vc = UIViewController()
        vc.restorationIdentifier = kMoreTabVCIdentifier
        
        let item = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        let icon = moreIcon ?? (item.image ?? item.selectedImage)?.withRenderingMode(.alwaysTemplate)
        
        vc.tabBarItem = UITabBarItem(title: moreTitle, image: icon, selectedImage: moreSelectedIcon)
        return vc
    }

    @objc internal func outsideTapped() {
        self.hideMoreContainer()
    }
    
    // MARK: - Public Methods
    
    /// Seyup ExpandedTabBar Orogrammatically.
    /// - Parameter array: Array of UIVIewControllers.
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
}

// MARK: - Animartion Handling
internal extension ExpandedTabBarController {
    func showMoreContainer() {
        
        self.options.animationType.animation
            .willShow(container: self.parentContainerView, background: self.backgroundView)
        
        let showAnimation = {
            self.backgroundView.alpha = 1
            self.options.animationType.animation.show(container: self.parentContainerView, on: self.backgroundView)
            self.backgroundView.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: options.animationType.animation.duration, animations: showAnimation) { _ in
            self.options.animationType.animation
                .didShow(container: self.parentContainerView, background: self.backgroundView)
        }
    }

    func hideMoreContainer() {
        
        self.options.animationType.animation
            .willHide(container: self.parentContainerView, background: self.backgroundView)
        
        let hideAnimation = {
            self.options.animationType.animation.hide(container: self.parentContainerView, from: self.backgroundView)
            self.backgroundView.alpha = 0
            self.backgroundView.layoutIfNeeded()
        }
        
        UIView.animate(withDuration: options.animationType.animation.duration, animations: hideAnimation) { _ in
            self.options.animationType.animation
                .didHide(container: self.parentContainerView, background: self.backgroundView)
        }
    }
}
#endif
