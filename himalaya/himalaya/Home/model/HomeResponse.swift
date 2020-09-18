//
//  HomeResponse.swift
//  himalaya
//
//  Created by Farben on 2020/8/6.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class HomeResponse<T: Mappable>: BaseResponse<T> {
    
    var hearders: [T]?
    
    var bodys: [T]?
    
    var offset: Int = 0
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        hearders          <- map["header"]
        bodys             <- map["body"]
        offset             <- map["offset"]
    }
}
