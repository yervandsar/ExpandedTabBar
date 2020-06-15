//
//  ExpandedTabBarViews.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/13/18.
//  Copyright © 2018 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)

import UIKit

internal final class ExpandedTabBarViews {

    static func moreItemView(for item: UITabBarItem,
                            at index: Int,
                            target: Any?,
                            action: Selector?,
                            options: Options) -> UIStackView {

        let parentView = UIStackView()
        parentView.tag = index
        parentView.spacing = options.container.tab.iconTitleSpace
        parentView.distribution = .fill
        parentView.accessibilityIdentifier = kMoreStackAtIndex + "\(index)"

        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addConstraint(parentView.connect(on: .height, constant: options.container.tab.itemHeight))

        parentView.isLayoutMarginsRelativeArrangement = true
        parentView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        parentView.addGestureRecognizer(tapGesture)
        parentView.isUserInteractionEnabled = true

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = item.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = options.container.tab.iconColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addConstraint(imageView.connect(to: imageView, on: .height, to: .width, multiplier: 1))
        
        parentView.addArrangedSubview(imageView)

        let label = UILabel()
        label.text = item.title
        label.font = options.container.tab.titleFont
        label.textColor = options.container.tab.titleColor
        label.textAlignment = .left
        parentView.addArrangedSubview(label)

        return parentView
    }

    static var clearView: UIView {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        view.alpha = 0
        return view
    }
    
    static var containerMaxSize: CGSize {
        CGSize(width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.height * 0.8)
    }
}
#endif
