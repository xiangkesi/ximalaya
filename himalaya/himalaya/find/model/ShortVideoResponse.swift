//
//  ShortVideoResponse.swift
//  himalaya
//
//  Created by Farben on 2020/8/14.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
class ShortVideoResponse<T: Mappable>: BaseResponse<T> {
    
    var video: T?
    
    
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
       
    override func mapping(map: Map) {
        super.mapping(map: map)
        video         <- map["data"]
    }
}
