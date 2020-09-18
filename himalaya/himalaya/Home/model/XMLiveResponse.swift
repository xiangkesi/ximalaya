//
//  XMLiveResponse.swift
//  himalaya
//
//  Created by Farben on 2020/9/1.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMLiveResponse<T: Mappable>: BaseResponse<T> {
    
    var model: T?
    
    var focusImages: [T]?
    
    var responseId: Int64 = 0
    
    
//    XMLiveRankModel
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        model             <- map["data"]
        focusImages             <- map["data"]
        responseId             <- map["responseId"]
    }
}
