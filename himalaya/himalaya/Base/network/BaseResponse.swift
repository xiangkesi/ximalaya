//
//  BaseResponse.swift
//  gokarting
//
//  Created by Farben on 2020/7/27.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse<T: Mappable>: Error, Mappable {
    
    var ret: Int = -1
    var msg: String?
    
    
    required init?(map: Map) {
    }
    
    init() {
    }
    
    
    
    func mapping(map: Map) {
        ret     <- map["ret"]
        msg     <- map["msg"]
    }
    
    var localizedDescription: String {
        return "\(msg ?? "")"
    }
}


