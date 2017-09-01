//
//  RechargeResultResponse.swift
//  SelfAdaptionWidth
//
//  Created by GarryZhang on 2017/9/1.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

import Foundation
import ObjectMapper

class RechargeResultResponse: Mappable {
    
//    {
//    "CheckTransactionStatusResult": "true",
//    "sResponseID": "-1",
//    "sResponseStatus": "INVALID_LOGIN",
//    "recharge_status":"1"
//    }
    
    var transStatusResult: String?
    var sResponseId: String?
    var sResponseStatus: String?
    var rechargeStatus: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        transStatusResult   <- map["CheckTransactionStatusResult"]
        sResponseId         <- map["sResponseID"]
        sResponseStatus     <- map["sResponseStatus"]
        rechargeStatus      <- map["recharge_status"]
    }
}
