//
//  UIButton+Extension.swift
//  eddie
//
//  Created by cdw on 2016/12/6.
//  Copyright © 2016年 cdw. All rights reserved.
//

import Foundation
import UIKit
import UIKit

extension UIButton {
    
    static func cs_button(target: AnyObject, sel: Selector, title: String? = nil) -> UIButton {
        let btn = UIButton()
        btn.backgroundColor = UIColor.clear
        btn.addTarget(target, action: sel, for: .touchUpInside)
        if let t = title {
            btn.cs_setTitle(n:t)
        }
        return btn
    }
    
    func cs_setImage(n: String, h: String? = nil, d: String? = nil, s: String? = nil) -> Void {
        self.setImage(UIImage(named: n), for: UIControlState())
        self.setImage(UIImage(named: h ?? n), for: .highlighted)
        self.setImage(UIImage(named: d ?? n), for: .disabled)
        self.setImage(UIImage(named: s ?? n), for: .selected)
    }
    
    func cs_setTitle(n: String, h: String? = nil, d: String? = nil, s: String? = nil) -> Void {
        self.setTitle(n, for: UIControlState())
        self.setTitle(h ?? n, for: .highlighted)
        self.setTitle(d ?? n, for: .disabled)
        self.setTitle(s ?? n, for: .selected)
    }
    
    func cs_setTitleColor(n: UIColor, h: UIColor? = nil, d: UIColor? = nil, s: UIColor? = nil) {
        self.setTitleColor(n, for: UIControlState())
        self.setTitleColor(h ?? n, for: .highlighted)
        self.setTitleColor(d ?? n, for: .disabled)
        self.setTitleColor(s ?? n, for: .selected)
    }
    
    func cs_setBackgroundColor(n: UIColor, h: UIColor? = nil, d: UIColor? = nil, s: UIColor? = nil) {
        self.setBackgroundImage(UIImage.imageFromColor(n), for: UIControlState())
        self.setBackgroundImage(UIImage.imageFromColor(h ?? n), for: .highlighted)
        self.setBackgroundImage(UIImage.imageFromColor(d ?? n), for: .disabled)
        self.setBackgroundImage(UIImage.imageFromColor(s ?? n), for: .selected)
    }
    
    func cs_setBackgroundImage(n: String, h: String? = nil, d: String? = nil, s: String? = nil) {
        self.setBackgroundImage(UIImage(named: n), for: UIControlState())
        self.setBackgroundImage(UIImage(named: h ?? n), for: .highlighted)
        self.setBackgroundImage(UIImage(named: d ?? n), for: .disabled)
        self.setBackgroundImage(UIImage(named: s ?? n), for: .selected)
    }
    func cs_setFont(_ font: UIFont) {
        if let lbl = self.titleLabel {
            lbl.font = font
        }
    }
    
}
