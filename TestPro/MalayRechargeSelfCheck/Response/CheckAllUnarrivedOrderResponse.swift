//
//  CheckAllUnarrivedOrderResponse.swift
//  MalayRechargeSelfCheck
//
//  Created by GarryZhang on 2017/9/8.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

import Foundation

import ObjectMapper

class CheckAllUnarrivedOrderResponse: Mappable {
    
    //    {
    //    "result": "check successed",
    //    "code": 1,
    //    }
    
    var result: String?
    var code: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        result   <- map["result"]
        code     <- map["code"]
    }
}
