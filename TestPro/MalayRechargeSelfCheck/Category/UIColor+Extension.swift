//
//  UIColor+Extension.swift
//  SelfAdaptionWidth
//
//  Created by GarryZhang on 2017/8/31.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

import Foundation
import UIKit


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
