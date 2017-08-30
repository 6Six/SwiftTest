//
//  UIFont+Extension.swift
//  eddie
//
//  Created by cdw on 2016/12/5.
//  Copyright © 2016年 cdw. All rights reserved.
//

import Foundation
import UIKit
import UIKit

extension UIFont {
    /**
     标题 (title size : 14)
     
     - returns: UIFont
     */
    class func appTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 15)
    }
    
    /**
     提醒文字(textfiled text size: 12)
     
     - returns: UIFont
     */
    class func appTextFont() -> UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    
    /**
     子标题(textfiled placeholder size: 11)
     
     - returns: UIFont
     */
    class func appSubTitleFont() -> UIFont {
        return UIFont.systemFont(ofSize: 12)
    }
}
