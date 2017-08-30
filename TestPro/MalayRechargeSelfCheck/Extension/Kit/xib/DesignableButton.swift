//
//  DesignableView.swift
//  Prosperous
//
//  Created by lt on 2016/11/21.
//  Copyright © 2016年 cardsmart. All rights reserved.
//

import UIKit

@IBDesignable class DesignableButton: UIButton, CornerDesignable, BorderDesignable {
    /**
     corner side: Top Left, Top Right, Bottom Left or Bottom Right, if not specified, all corner sides will display,
     */
    public var cornerSides: CornerSides = CornerSides.AllSides

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
}
