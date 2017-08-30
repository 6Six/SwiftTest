//
//  GradientDesignable.swift
//  LawUser
//
//  Created by lt on 2017/6/25.
//  Copyright © 2017年 cn.com.cardinfo. All rights reserved.
//

import UIKit

public protocol GradientDesignable {
    /**
      start
     */
    var gradientStartColor: UIColor? { get set }
    
    /**
     end
     */
    var gradientEndColor: UIColor? { get set }
}

public extension GradientDesignable where Self: UIView {
    public func configureGradientColor() {
        layer.mask?.removeFromSuperlayer()
        
        if let sc = gradientStartColor, let ec = gradientEndColor {
            // configure corner for specified sides
            
            let gradient = CAGradientLayer()
            gradient.name = "configureGradientLayer"
            gradient.frame = CGRect(origin: .zero, size: bounds.size)
            let locations = [ NSNumber(value: 0.0), NSNumber(value: 1.0) ]
            gradient.locations = locations
            let colors = [sc.cgColor, ec.cgColor]
            gradient.colors = colors
            layer.mask = gradient
            self.layer.masksToBounds = true
        }
    }
}
