//
//  TriangleView.swift
//  ExpandedTabBar
//
//  Created by Yervand Saribekyan on 3/12/18.
//  Copyright © 2018 Yervand Saribekyan. All rights reserved.
//

import UIKit

internal final class TriangleView: UIView {

    @IBInspectable
    var color: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func draw(_ rect: CGRect) {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.size.width / 2, y: 0.0))
        path.addLine(to: CGPoint(x: 0.0, y: rect.size.height))
        path.addLine(to: CGPoint(x: rect.size.width, y: rect.size.height))
        path.close()
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = color.cgColor
        self.layer.addSublayer(layer)

    }

}
