//
//  CheckVersionUpdateResponse.swift
//  SelfAdaptionWidth
//
//  Created by GarryZhang on 2017/9/3.
//  Copyright © 2017年 GarryZhang. All rights reserved.
//

import Foundation
import ObjectMapper

class CheckVersionUpdateResponse: Mappable {
    
    //    {
    //    "version": "1.0.1",
    //    }
    

    var version: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        version   <- map["version"]
    }
}
