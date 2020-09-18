//
//  XMUserInfo.swift
//  himalaya
//
//  Created by Farben on 2020/8/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

struct XMUserInfo: Mappable {
    var uid: Int64 = 0
    var nickname: String?
    var avatar: String?
    var isVerified: Bool = false
    var anchorGrade: Int = 3
    
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        uid                 <- map["uid"]
        nickname                 <- map["nickname"]
        avatar                 <- map["avatar"]
        isVerified                 <- map["isVerified"]
        anchorGrade                 <- map["anchorGrade"]
    }
    
    
}
