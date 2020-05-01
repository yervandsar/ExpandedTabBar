//
//  ExpandedTabBarViews.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/13/18.
//  Copyright © 2018 Yervand Saribekyan. All rights reserved.
//

import UIKit

internal final class ExpandedTabBarViews {

    class func moreItemView(
        for item: UITabBarItem,
        at index: Int,
        itemHeight: CGFloat,
        target: Any?,
        action: Selector?,
        options: ExpandedTabBarOptions) -> UIStackView {

        let parentView = UIStackView()
        parentView.tag = index
        parentView.spacing = options.spaceBetweenImageTitle
        parentView.distribution = .fill
        parentView.accessibilityIdentifier = kMoreStackAtIndex + "\(index)"

        parentView.translatesAutoresizingMaskIntoConstraints = false
        let heightConstraint = NSLayoutConstraint(
            item: parentView,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: itemHeight
        )
        parentView.addConstraint(heightConstraint)

        parentView.isLayoutMarginsRelativeArrangement = true
        parentView.layoutMargins = UIEdgeInsets(
            top: 0,
            left: 8,
            bottom: 0,
            right: 8)

        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        parentView.addGestureRecognizer(tapGesture)
        parentView.isUserInteractionEnabled = true

        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = item.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = options.icontColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.addConstraint(
            NSLayoutConstraint(
                item: imageView,
                attribute: .height,
                relatedBy: .equal,
                toItem: imageView,
                attribute: .width,
                multiplier: 1,
                constant: 0)
        )
        parentView.addArrangedSubview(imageView)

        let label = UILabel()
        label.text = item.title
        label.font = options.titleFont
        label.textColor = options.titleColor
        label.textAlignment = .left
        parentView.addArrangedSubview(label)
        return parentView
    }

    class func bgView() -> UIView {
        let bgView = UIView()
        bgView.clipsToBounds = true
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        bgView.alpha = 0
        return bgView
    }

    class func triangleView(rotationAngle: CGFloat = CGFloat.pi) -> TriangleView {
        let triangle = TriangleView()
        triangle.color = UIColor.white
        triangle.transform = CGAffineTransform(rotationAngle: rotationAngle)
        triangle.backgroundColor = UIColor.clear
        return triangle
    }

    class func moreItemsContainerView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }

    class func calculateMoreContainerMaxSize() -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width * 0.9, height: UIScreen.main.bounds.size.height * 0.8)
    }
}
