//
//  UIColor+Extension.swift
//  eddie
//
//  Created by cdw on 2016/12/5.
//  Copyright © 2016年 cdw. All rights reserved.
//

import UIKit

// 导航栏样式
enum CSNavigationStyle: Int {
    /// 灰白色
    case light
    /// 蓝色
    case dark
    /// 黑色
    case black
    
    var color: UIColor {
        switch self {
        case .light:
            return UIColor.rgbColor(249, green: 249, blue: 249)
        case .dark:
            return UIColor.appColor()
        case .black:
            return UIColor.hexColor("242223")
        }
    }
}

public extension UIColor {
    
    class func randomColor() -> UIColor {
        let r = arc4random() % 255
        let g = arc4random() % 255
        let b = arc4random() % 255
        return UIColor(red: CGFloat(r) / 255.0 , green: CGFloat(g) / 255.0 , blue: CGFloat(b) / 255.0 , alpha: 1.0)
    }
    
    class func rgbColor(_ red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> UIColor {
        return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1)
    }
    
    class func hexColor(_ hex: String) -> UIColor  {
        var hx = hex
        if hx.hasPrefix("#") {
            hx = hex.substringFromIndex(1)
        }
        
        if hx.characters.count != 6 {
            return UIColor.red
        }
        
        var color:UInt32 = 0
        Scanner(string: hx).scanHexInt32(&color)
        let r = (color & 0xff0000) >> 16
        let g = (color & 0x00ff00) >> 8;
        let b = (color & 0x0000ff);
        return rgbColor(CGFloat(r), green: CGFloat(g), blue: CGFloat(b))
    }
}

extension UIColor {
    /**
     系统色
     
     - returns: UIColor
     */
    class func appColor() -> UIColor {
        return UIColor.hexColor("637FED")
    }
    
    /**
     系统 View 色
     
     - returns: UIColor
     */
    class func appViewBackgroundColor() -> UIColor {
        return UIColor.rgbColor(241, green: 241, blue: 241)
    }
    
    
    /**
     登录界面 textField 背景色
     
     - returns: UIColor
     */
    class func appLoginTFColor() -> UIColor {
        return UIColor.rgbColor(164, green: 221, blue: 242)
    }
    
    /**
     table 背景颜色
     
     - returns: UIColor
     */
    class func appTableBackgroundColor() -> UIColor {
        return UIColor.appViewBackgroundColor()
    }
    
    /**
     棕色
     
     - returns: UIColor
     */
    class func appBrownColor() -> UIColor {
        return UIColor.hexColor("fba866")
    }
    
    /**
     标题颜色
     
     - returns: UIColor
     */
    class func appTitleColor() -> UIColor {
        return UIColor.hexColor("222222")
    }
    
    /**
     提醒文字(textfiled text)
     
     - returns: UIColor
     */
    class func appTextColor() -> UIColor {
        return UIColor.hexColor("555555")
    }
    
    /**
     子标题颜色(textfiled placeholder)
     
     - returns: UIColor
     */
    class func appSubTitleColor() -> UIColor {
        return UIColor.hexColor("cccccc")
    }
    
    /**
     Table 分割线颜色
     
     - returns: UIColor
     */
    class func appSepColor() -> UIColor {
        return UIColor.hexColor("dcdcdc") //eaeaea
    }
    
    /**
     Table 按钮背景颜色
     
     - returns: UIColor
     */
    class func appBtnColor() -> UIColor {
        return UIColor.hexColor("0188fe")
    }
}
