//
//  UIDevice+Extension.swift
//  eddie
//
//  Created by cdw on 2016/12/5.
//  Copyright © 2016年 cdw. All rights reserved.
//

import Foundation
import UIKit
import UIKit

extension UIDevice {
    
    // about system version
    class func isBeforeIOS7() -> Bool {
        let ver = self.systemVersion()
        return ver < 7
    }
    
    class func isIOS7() -> Bool {
        let ver = self.systemVersion()
        return ver >= 7 && ver < 8
        
    }
    
    class func isIOS7OrLater() -> Bool {
        let ver = systemVersion()
        return ver >= 7
    }
    
    class func isIOS8() -> Bool {
        let ver = self.systemVersion()
        return ver >= 8 && ver < 9
    }
    
    class func isIOS8OrLater() -> Bool {
        let ver = self.systemVersion()
        return ver >= 8
    }
    
    class func systemVersion() -> Float {
        let sysVer: NSString = UIDevice.current.systemVersion as NSString
        return sysVer.floatValue
    }
    
    
    // about screen
    
    class func screenSize() -> CGSize {
        if let currentMode = UIScreen.main.currentMode {
            return currentMode.size
        } else {
            return UIScreen.main.bounds.size
        }
    }
    
    // screen width
    class func screenWidth() -> CGFloat {
        if UIDevice.is5_5InchScreen() {
            return screenSize().width / 3
        } else {
            return screenSize().width / 2
        }
    }
    
    // screen height
    class func screenHeight() -> CGFloat {
        if UIDevice.is5_5InchScreen() {
            return screenSize().height / 3
        } else {
            return screenSize().height / 2
        }
    }
    
    class func is3_5InchScreen() -> Bool {
        // 320 * 480
        return CGSize(width: 640, height: 960).equalTo(screenSize())
    }
    
    class func is4InchScreen() -> Bool {
        // 320 * 568
        return CGSize(width: 640, height: 1136).equalTo(screenSize())
    }
    
    class func is4_7InchScreen() -> Bool {
        // 375 * 667
        return CGSize(width: 750, height: 1334).equalTo(screenSize())
    }
    
    class func is5_5InchScreen() -> Bool {
        // 1242 * 2208 是实际渲染出来的尺寸, 实际Points 是 414 * 736
        // 1242 * 2208 = 414 * 3, 736 * 3
        // 但是实际上分辨率为 1080 * 1920
        // 1242 * 2208 渲染之后 等比将至 1080 * 1920
        return CGSize(width: 1242, height: 2208).equalTo(screenSize())
    }
    
    class func appVersion() -> String {
        var version = "1.0"
        if let dic = Bundle.main.infoDictionary {
            version = dic["CFBundleShortVersionString"] as! String
        }
        return version
    }

    
    class func appBuild() -> String {
        if let dic = Bundle.main.infoDictionary, let build = dic["CFBundleVersion"] {
            return "\(build)"
        }
        return ""
    }

    
    class func appName() -> String {
        if let dic = Bundle.main.infoDictionary ,let name = dic["CFBundleDisplayName"] {
            return name as! String
        }
        return ""
    }
    
}
