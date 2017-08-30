//
//  UIResponder+Router.swift
//  LawUser
//
//  Created by lt on 2017/8/7.
//  Copyright © 2017年 cn.com.cardinfo. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    func sendRouterEvent(eventName: String, userInfo:[String: Any]?) {
        self.next?.sendRouterEvent(eventName: eventName, userInfo: userInfo)
    }
}
