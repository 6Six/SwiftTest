//
//  UIViewController+Extension.swift
//  eddie
//
//  Created by cdw on 2016/12/5.
//  Copyright © 2016年 cdw. All rights reserved.
//

import UIKit
import Foundation
import UIKit

extension UIViewController {
    func showError(msg: String) {
        APP.Window.showQuickTip(CSQuickTipType.failed, msg: msg)
    }
    func showSuccess(msg: String) {
        APP.Window.showQuickTip(CSQuickTipType.success, msg: msg)
    }
    func showLoading(msg: String = "") {
        APP.Window.showQuickTip(CSQuickTipType.loading, msg: msg, delayTime: CGFloat.greatestFiniteMagnitude)
    }
    func showPrompt(msg: String) {
        APP.Window.showQuickTip(CSQuickTipType.prompt, msg: msg)
    }
    func hiddenLoading() {
        APP.Window.hidenQuickTip()
    }
}


extension UIViewController {
    func popController() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func popRootController() {
        let _ = self.navigationController?.popToRootViewController(animated: true)
    }
    
    func pushController(vc: UIViewController) {
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func replaceLastController(vc: UIViewController) {
        if var vcs = self.navigationController?.viewControllers {
            assert(vcs.count > 0)
            vcs[vcs.count - 1] = vc
            self.navigationController?.setViewControllers(vcs, animated: true)
        }
    }
    
    // 保留 rootcontroller + vc
    func gotoSecondeController(vc: UIViewController) {
        guard let vcs = self.navigationController?.viewControllers, vcs.count >= 1 else {
            return
        }
        var rslt = Array(vcs[0..<1])
        rslt.append(vc)
        self.navigationController?.setViewControllers(rslt, animated: true)
    }
    
    // 替换到指定vc
    func replaceSpecifiController(_ vc: UIViewController, specifiCls: AnyClass) {
        if let vcs = self.navigationController?.viewControllers {
            assert(vcs.count >= 1)
            var newVcs = [UIViewController]()
            
            for newVC in vcs {
                if newVC.isMember(of: specifiCls) {
                    newVcs.append(newVC)
                    break
                }
                newVcs.append(newVC)
            }
            
            newVcs.append(vc)
            self.navigationController?.setViewControllers(newVcs, animated: true)
        }
    }
    
    
    func popToController(_ cls: AnyClass) -> Bool {
        let vc = self.containController(cls)
        guard let rslt = vc else {
            return false
        }
        let _ = self.navigationController?.popToViewController(rslt, animated: true)
        return true
    }
    
    func configureBackBarButtonItem(target: AnyObject, sel: Selector) {
        
//        warning
//        let btn = UIButton.cs_button(target: self, sel: #selector(BaseViewController.actionBack))
//        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
//        btn.contentHorizontalAlignment = .left
//        btn.cs_setImage(n: "common_nav_btn_back_nor" ,h: "common_nav_btn_back_hig")
//        let item = UIBarButtonItem(customView: btn)
//        self.navigationItem.leftBarButtonItem = item
    }
    
    func configureLightBackBarButtonItem(target: AnyObject, sel: Selector) {
        let btn = UIButton.cs_button(target: target, sel: sel)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.contentHorizontalAlignment = .left
        btn.setImage(UIImage(named: "ic_back"), for: UIControlState())
        let item = UIBarButtonItem(customView: btn)
        self.navigationItem.leftBarButtonItem = item
    }
    
    func configureRightButtonItem(target: AnyObject, sel: Selector, imgString: String = "icon_record") {
        let btn = UIButton.cs_button(target: self, sel: sel)
        btn.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn.contentHorizontalAlignment = .right
        btn.setImage(UIImage(named: imgString), for: UIControlState())
        let item = UIBarButtonItem(customView: btn)
        self.navigationItem.rightBarButtonItem = item
    }
    
    func containController(_ cls: AnyClass) -> UIViewController? {
        var rslt: UIViewController? = nil
        let childs = self.navigationController?.childViewControllers
        for vc in childs! {
            if vc.isMember(of: cls) {
                rslt = vc
                break
            }
        }
        return rslt
    }
    
}
