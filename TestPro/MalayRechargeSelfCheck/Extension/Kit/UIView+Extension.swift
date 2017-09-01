//
//  UIView+Extension.swift
//  Fus
//
//  Created by cdw on 2016/12/16.
//  Copyright © 2016年 cdw. All rights reserved.
//

import Foundation
import UIKit
import UIKit
//import MBProgressHUD

enum CSQuickTipType: Int {
    case loading = 0
    case success
    case failed
    case prompt
    case text
    case max // 无用
}

extension UIView {
    // MARK: - Radius
    
    func viewController() -> UIViewController? {
        var rsp: UIResponder = self
        while rsp.next != nil {
            if (rsp.next?.isKind(of: UIViewController.self))! {
                return rsp.next as? UIViewController
            }
            rsp = rsp.next!
        }
        return nil
    }
    
    func makeRadius(radius: CGFloat) {
        self.layer.cornerRadius = CGFloat( radius )
        self.layer.masksToBounds = true
    }
    
    func cleanRadius() {
        self.layer.cornerRadius = 0
        self.layer.masksToBounds = false
    }
    
    func makeBoarder(_ width: CGFloat, color: UIColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
    
    func cleanBoarder() {
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = false
    }
    
    static internal func line() -> UIView {
        let line = UIView()
        line.backgroundColor = UIColor.appSepColor()
        return line
    }
    
    
    // MARK: - HUD tips
    
//    internal func showQuickTip(_ type: CSQuickTipType, msg: String? = nil, delayTime: CGFloat = 2.0, callback: (()->Void)? = nil) {
//        let huds = MBProgressHUD.allHUDs(for: self) ?? [Any]()
//        var hud: MBProgressHUD!
//        if (huds.count) > 0 {
//            hud = huds.first as! MBProgressHUD
//        }
//        
//        var tempMsg = msg ?? ""
//        if type == CSQuickTipType.loading && tempMsg.characters.count == 0 {
//            tempMsg = "正在加载中"
//        }
//        if hud == nil {
//            hud = MBProgressHUD(view: self)
//            hud.backgroundColor = UIColor.black.withAlphaComponent(0.6)
//            self.addSubview(hud)
//        }
//        hud.mode = .customView
//        hud.labelText = ""
//        hud.detailsLabelText = tempMsg
//        
//        if type == .loading {
//            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
//            indicator.frame = CGRect(x: 0, y: 0, width: 80, height: 50)
//            hud.customView = indicator
//            indicator.startAnimating()
//        }
//        else if type == .text {
//            hud.mode = .text
//            hud.detailsLabelFont = hud.labelFont
//        }
//        else {
//            let icons = ["",
//                         "icon_success",
//                         "icon_failed",
//                         "icon_prompt",
//                         ""]
//            let iv = UIImageView(frame:CGRect(x: 0, y: 0, width: 80, height: 50))
//            iv.contentMode = .center
//            iv.image = UIImage(named: icons[type.rawValue])
//            hud.customView = iv
//        }
//        
//        self.bringSubview(toFront: hud)
//        hud.show(true)
//        
//        if delayTime > 0.0 {
//            hud.hide(true, afterDelay: TimeInterval(delayTime))
//            guard let callback = callback else {
//                return
//            }
//            delay(delay: delayTime, callback)
//        }
//        
//    }
//    
//    func hidenQuickTip() -> Void {
//        DispatchQueue.main.async {
//            MBProgressHUD.hide(for: self, animated: true)
//        }
//    }
    
    
    // MARK: - First controller
    
    func firstAvailableController() -> UIViewController? {
        
        guard let rslt = self.traverseResponderChainForUIViewController() else {
            return nil
        }
        return rslt as? UIViewController
    }
    
    func traverseResponderChainForUIViewController() -> AnyObject? {
        
        let nextResponder = self.next
        
        guard let nextRsp = nextResponder else {
            return nil
        }
        if nextRsp.isKind(of: UIViewController.self) {
            return nextRsp
        }
        if nextRsp.isKind(of: UIView.self) {
            return (nextRsp as! UIView).traverseResponderChainForUIViewController()
        }
        return nil
        
    }
}

extension UIView {
    class func appHeaderView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.appTableBackgroundColor()
        return view;
    }
}


// MARK: - Empty View
private var EmptyViewAssociationKey: UInt8 = 0

/**
 self.view.showEmptyView(UIImage(named: "icon_empty")!, title: "您当前没有转账记录", btnTitle: "绑定银行卡", sel: nil)
 */
//extension UIView {
//    internal var emptyView: EmptyView {
//        get {
//            let associateValue = objc_getAssociatedObject(self, &EmptyViewAssociationKey)
//            if let view = associateValue as? EmptyView {
//                return view
//            }
//            let v = EmptyView()
//            self.emptyView = v
//            return v
//        }
//        set {
//            objc_setAssociatedObject(self, &EmptyViewAssociationKey, newValue, .OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//    
//    func showEmptyView( _ image: UIImage, title: String, btnTitle: String?, sel: (()->Void)?) {
//        emptyView.isHidden = false
//        if let _ = emptyView.superview {
//            self.bringSubview(toFront: emptyView)
//            emptyView.configure(image, title: title, btnTitle: btnTitle, sel: sel)
//            return;
//        }
//        self.addSubview(emptyView)
//        emptyView.snp.makeConstraints({ (make) in
//            make.top.left.equalTo(0)
//            make.width.equalTo(self)
//            make.height.equalTo(self)
//        })
//        emptyView.configure(image, title: title, btnTitle: btnTitle, sel: sel)
//    }
//    
//    func hiddenEmptyView() {
//        self.emptyView.isHidden = true
//    }
//}


extension UIView {
    var leftX: CGFloat {
        get {
            return self.frame.origin.x
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    
    var topY: CGFloat {
        get {
            return self.frame.origin.y
        }
    }
    
    var rightX: CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    var bottomY: CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }
    
    var width: CGFloat {
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        get {
            return self.frame.size.height
        }
    }
    
    var point: CGPoint {
        get {
            return self.frame.origin
        }
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }
    
    var size: CGSize {
        get {
            return self.frame.size
        }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
}


extension UIStoryboard {
    
    static func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    struct HomeStoryboard {
        static func homeController() -> UIViewController {
            return UIStoryboard.mainStoryboard().instantiateViewController(withIdentifier: "TabBarController")
        }
        
    }
}


