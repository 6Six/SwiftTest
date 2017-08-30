//
//  DesignableView.swift
//  Prosperous
//
//  Created by lt on 2016/11/29.
//  Copyright © 2016年 cardsmart. All rights reserved.
//

import UIKit
import Foundation
import UIKit

@IBDesignable class DesignableView: UIView, CornerDesignable, BorderDesignable, ShadowDesignable , GradientDesignable {
    /**
     corner side: Top Left, Top Right, Bottom Left or Bottom Right, if not specified, all corner sides will display,
     */
    public var cornerSides: CornerSides = [.topLeft, .bottomRight, .topRight, .bottomLeft] {
        didSet {
            configureCornerRadius()
        }
    }

    // MARK: - CornerDesignable
    @IBInspectable open var cornerRadius: CGFloat = CGFloat.nan {
        didSet {
            configureCornerRadius()
        }
    }

    // MARK: - BorderDesignable
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            configureBorder()
        }
    }

    @IBInspectable open var borderWidth: CGFloat = CGFloat.nan {
        didSet {
            configureBorder()
        }
    }

    open var borderSides: BorderSides  = .AllSides {
        didSet {
            configureBorder()
        }
    }

    // MARK: - ShadowDesignable
    @IBInspectable open var shadowColor: UIColor? {
        didSet {
            configureShadowColor()
        }
    }

    @IBInspectable open var shadowRadius: CGFloat = CGFloat.nan {
        didSet {
            configureShadowRadius()
        }
    }

    @IBInspectable open var shadowOpacity: CGFloat = CGFloat.nan {
        didSet {
            configureShadowOpacity()
        }
    }

    @IBInspectable open var shadowOffset: CGPoint = CGPoint(x: CGFloat.nan, y: CGFloat.nan) {
        didSet {
            configureShadowOffset()
        }
    }
    
    // MARK: - GradientDesignable
    @IBInspectable open var gradientStartColor: UIColor? {
        didSet {
            configureGradientColor()
        }
    }
    
    @IBInspectable open var gradientEndColor: UIColor? {
        didSet {
            configureGradientColor()
        }
    }
}
