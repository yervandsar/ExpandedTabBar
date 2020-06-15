//
//  ContainerView.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 6/12/20.
//  Copyright © 2020 Yervand Saribekyan. All rights reserved.
//
#if !os(macOS)
import UIKit

public final class ContainerView: UIView {
    let tabBar: UITabBar
    
    var options: ContainerOptions = ContainerDefaultOptions()

    var scrollView = UIScrollView()
    var stackView = UIStackView()
    var indicatorView: UIView = UIView()
    
    init(for tabBar: UITabBar) {
        self.tabBar = tabBar
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func addArrangedSubviews(_ items: [UIStackView]) {
        addScroll()
        addStack()
        items.forEach { [unowned stackView] item in
            stackView.addArrangedSubview(item)
        }
    }
    
    internal func setOptions(_ options: ContainerOptions) {
        self.options = options
        layer.cornerRadius = options.cornerRadius
        backgroundColor = options.color.withAlphaComponent(options.alpha)
        if let shadow = options.shadow {
            setShadow(shadow)
        }
    }

}

// MARK: - Static methods
internal extension ContainerView {
    class func create(for tabBar: UITabBar) -> ContainerView {
        let view = ContainerView(for: tabBar)
        view.backgroundColor = .white
        return view
    }
}

// MARK: - Inside views
private extension ContainerView {
    func addScroll() {
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addScrollViewConstraints()
    }

    func addStack() {
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = options.tabSpace
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15 )
        addStackViewConstraints()
    }
}

// MARK: - Constraints of inside views
private extension ContainerView {
    // MARK: Adding scrollView in container
    /// Adding scrollView in container
    func addScrollViewConstraints() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            scrollView.connect(to: self, on: .top),
            scrollView.connect(to: self, on: .right),
            scrollView.connect(to: self, on: .left),
            scrollView.connect(to: self, on: .bottom),
        ])
    }
    
    // MARK: Adding stackView in scrollView
    /// Adding stackView in scrollView
    func addStackViewConstraints() {
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollView.addConstraints([
            stackView.connect(to: scrollView, on: .top),
            stackView.connect(to: scrollView, on: .right),
            stackView.connect(to: scrollView, on: .left),
            stackView.connect(to: scrollView, on: .bottom),
            stackView.connect(to: scrollView, on: .height, constant: 150).withPriority(250),
        ])
    }
}
#endif
