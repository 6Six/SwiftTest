//
//  UINavigationController+Extension.swift
//  eddie
//
//  Created by cdw on 2016/12/5.
//  Copyright © 2016年 cdw. All rights reserved.
//


import Foundation
import UIKit
import UIKit

private var CSNavigationBarStyleAssociationKey: UInt8 = 0

extension UINavigationController {
    
    internal var navigationBarStyle: CSNavigationStyle {
        get {
            let associateValue = objc_getAssociatedObject(self, &CSNavigationBarStyleAssociationKey)
            guard let av = associateValue else {
                return CSNavigationStyle.light
            }
            
            switch av as! Int {
            case 0:
                return CSNavigationStyle.light
            case 1:
                return CSNavigationStyle.dark
            case 2:
                return .black
            default:
                return CSNavigationStyle.light
            }
        }
        set {
            objc_setAssociatedObject(self, &CSNavigationBarStyleAssociationKey, newValue.rawValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
}
