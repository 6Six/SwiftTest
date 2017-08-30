//
//  Dictionary+Extension.swift
//  Fus
//
//  Created by cdw on 2016/12/22.
//  Copyright © 2016年 cdw. All rights reserved.
//

import Foundation
import UIKit

extension Dictionary {
    var jsonString: String {
        let obj = self
        
        let data = try? JSONSerialization.data(withJSONObject: obj, options: JSONSerialization.WritingOptions.prettyPrinted)
        var rslt = ""
        if let data = data {
            rslt = String(data: data, encoding: String.Encoding.utf8) ?? ""
        }
        return rslt
    }
}

extension NSDictionary {
    var jsonString: String {
        let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
        var rslt = ""
        if let data = data {
            rslt = String(data: data, encoding: String.Encoding.utf8) ?? ""
        }
        return rslt
    }
}
