//
//  XMFmTitleResponse.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/11.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMFmTitleResponse<T: Mappable>: BaseResponse<T> {
    
    var data: T?
    
    var trackInfo: T?
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        data          <- map["data"]
        trackInfo          <- map["data"]
    }
    
}
