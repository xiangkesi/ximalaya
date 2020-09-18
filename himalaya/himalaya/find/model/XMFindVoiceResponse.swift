//
//  ActiveResponse.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
class XMFindVoiceResponse<T: Mappable>: BaseResponse<T> {
    
    var active: [T]?
    
    var offset: Int = 0
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
       
    override func mapping(map: Map) {
        super.mapping(map: map)
        active          <- map["data"]
        offset          <- map["offset"]
    }
}
