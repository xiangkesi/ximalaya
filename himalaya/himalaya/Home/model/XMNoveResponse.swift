//
//  XMNoveResponse.swift
//  himalaya
//
//  Created by Farben on 2020/8/26.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMNoveResponse<T: Mappable>: BaseResponse<T> {
    
    var fousImage: XMNoveFocusImageModel?
    
    var model: T?
    
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
        fousImage          <- map["focusImages"]
        model             <- map["categoryContents"]
//        offset             <- map["offset"]
    }
}
