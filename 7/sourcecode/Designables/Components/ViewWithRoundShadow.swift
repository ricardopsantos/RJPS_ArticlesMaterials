//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit

open class ViewWithRoundShadow: UIView {

    private var ADD_SHADOW = true

    // fillColor : the color applied to the shadowLayer, rather than the view's backgroundColor
    static var cornerRadius: CGFloat = 5
    private var _fillColor: UIColor = UIColor.clear
    private var _shadowColor: CGColor = UIView.Shadows.shadowColor.cgColor
    private var _shadowLayer: CAShapeLayer!
    private var _shadowOpacity: Float = 1
    private var _shadowRadius: CGFloat = 4
    private var _borderColor: CGColor = UIColor.clear.cgColor

    open override func layoutSubviews() {
        super.layoutSubviews()

        // Corner
        self.backgroundColor = .white
        self.layer.cornerRadius = Self.cornerRadius
        self.layer.borderWidth = 1
        self.layer.borderColor = _borderColor

        // Shadow
        if _shadowLayer == nil && ADD_SHADOW {
            _shadowLayer = CAShapeLayer()
            _shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: Self.cornerRadius).cgPath
            //_shadowLayer.fillColor = _fillColor.cgColor
            _shadowLayer.shadowColor = _shadowColor
            _shadowLayer.shadowPath = _shadowLayer.path
            _shadowLayer.shadowOffset = UIView.Shadows.offset
            _shadowLayer.shadowOpacity = _shadowOpacity
            _shadowLayer.shadowRadius  = _shadowRadius
            layer.insertSublayer(_shadowLayer, at: 0)
        }
    }
}
