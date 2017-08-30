//
//  ObjectMapper+Extension.swift
//  Prosperous
//
//  Created by lt on 2016/11/30.
//  Copyright © 2016年 cardsmart. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class MyDateTransform: DateTransform {
    open override func transformFromJSON(_ value: Any?) -> Date? {
        var timeStap: TimeInterval = 0.0
        if let timeInt = value as? Double {
            timeStap = timeInt
        }
        
        if let timeStr = value as? String {
            timeStap = atof(timeStr)
        }
        
        if timeStap > 10000000000 {
            timeStap /= 1000
        }
        
        return super.transformFromJSON(timeStap)
    }
}


class Double2StringTransform: TransformType {
    typealias Object = String
    typealias JSON = Double
    
    public init() {
        
    }
    func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value {
            return String(describing: value)
        }
        return nil
    }
    func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return Double(value)
        }
        return nil
    }
}


class Int2StringTransform: TransformType {
    typealias Object = String
    typealias JSON = Int
    
    public init() {
        
    }
    func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value {
            return String(describing: value)
        }
        return nil
    }
    func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return Int(value)
        }
        return nil
    }
}


class String2IntTransform: TransformType {
    typealias Object = Int
    typealias JSON = String
    
    public init() {
        
    }
    
    func transformFromJSON(_ value: Any?) -> Object? {
        if let value = value, value is String {
            return Int((value as! String))
        }
        return nil
    }
    func transformToJSON(_ value: Object?) -> JSON? {
        if let value = value {
            return String(value)
        }
        return nil
    }
    
}
