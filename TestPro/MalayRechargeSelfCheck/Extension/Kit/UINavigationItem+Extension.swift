//
//  UINavigationItem+Extension.swift
//  eddie
//
//  Created by cdw on 2016/12/5.
//  Copyright © 2016年 cdw. All rights reserved.
//


import UIKit

extension UINavigationItem {
    
//    static func barButtonItem(_ title: String, target: AnyObject, sel: Selector, color: UIColor = UIColor.appTitleColor(),image: String? = nil) -> UIBarButtonItem {
//        let btn = UIButton()
//        let width = title.widthOfFont(UIFont.systemFont(ofSize: 13), maxHeight: 30)
//        btn.frame = CGRect(x: 0, y: 0, width: width + 20, height: 30)
//        btn.setTitle(title, for: UIControlState())
//        btn.addTarget(target, action: sel, for: UIControlEvents.touchUpInside)
//        btn.backgroundColor = UIColor.clear
//        btn.setTitleColor(color, for: UIControlState())
//        btn.cs_setFont(UIFont.boldSystemFont(ofSize: 13))
//        btn.makeRadius(radius: 4)
//        if let img = image {
//            btn.cs_setImage(n: img)
//        }
//        return UIBarButtonItem(customView: btn)
//    }
    
    func setRightBarButtonItemWithImage(_ image: UIImage, target: AnyObject, sel: Selector) -> UIButton {
        let btn = UIButton()
        btn.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
        btn.setTitle(title, for: UIControlState())
        btn.addTarget(target, action: sel, for: UIControlEvents.touchUpInside)
        btn.setImage(image, for: UIControlState())
        btn.setTitleColor(UIColor.appTitleColor(), for: UIControlState())
        btn.cs_setFont(UIFont.boldSystemFont(ofSize: 13))
        btn.contentHorizontalAlignment = .right
        self.rightBarButtonItem = UIBarButtonItem(customView: btn)
        return btn
    }
}
