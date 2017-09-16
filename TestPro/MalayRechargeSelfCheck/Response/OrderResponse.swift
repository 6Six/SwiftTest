//
//  OrderResponse.swift
//  SelfAdaptionWidth
//
//  Created by GarryZhang on 2017/8/31.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

import Foundation
import ObjectMapper

enum TelcomType: Int {
    case celcom = 3
    case digi = 2
    case maxis = 1
    case tron = 25
    case tunetalk = 5
    case umobile = 4
    case xox = 6
}

class OrderResponse: Mappable {

//    "result_code": 1,
//    "response": "query orders successed",
//    "data": [
//    {
//    "id": "1",
//    "order_id": "1",
//    "phone_num": "2",
//    "recharge_money": "34",
//    "recharge_status": "5",
//    "recharge_time": "6",
//    "telcom_name": "0"
//    },
//    {
//    "id": "2",
//    "order_id": "123338",
//    "phone_num": "837218822",
//    "recharge_money": "50",
//    "recharge_status": "1",
//    "recharge_time": "1234567890",
//    "telcom_name": "0"
//    }
//    ]
    
    var result_code: Int?
    var response: String?
    var orderDetails: [OrderDetail]?

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        result_code <- map["result_code"]
        response <- map["response"]
        orderDetails <- map["data"]
    }
    
    
}


class OrderDetail: Mappable {
    var id: String?
    var order_id: String?
    var phone_num: String?
    var recharge_money: String?
    var recharge_status: String?    // 1:已到账   -1：未到账    其他是未知错误
    var recharge_time: String?
    var telcom_name_id: String?
    var telcom_name: String?
    var telcom_image_name: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        order_id    <- map["order_id"]
        phone_num   <- map["phone_num"]
        recharge_money <- map["recharge_money"]
        recharge_status <- map["recharge_status"]
        recharge_time <- map["recharge_time"]
        telcom_name_id <- map["telcom_name"]
        
        telcom_name = telcomName(telType: TelcomType(rawValue: Int(telcom_name_id!)!)!)
        telcom_image_name = telcomImageName(telType: TelcomType(rawValue: Int(telcom_name_id!)!)!)
    }
    
    func telcomName(telType: TelcomType) -> String {
        
        var telcomName = ""
        
        switch telType {
        case .celcom:
            telcomName = "celcom"
            break
        case .digi:
            telcomName = "digi"
            break
        case .maxis:
            telcomName = "maxis"
            break
        case .tron:
            telcomName = "tron"
            break
        case .tunetalk:
            telcomName = "tunetalk"
            break
        case .umobile:
            telcomName = "umobile"
            break
        case .xox:
            telcomName = "xox"
            break
        }
        
        return telcomName
    }
    
    func telcomImageName(telType: TelcomType) -> String {
        var telImageName = ""
        
        telImageName = telcomName(telType: telType) + "_icon"
        
        return telImageName
    }
}










