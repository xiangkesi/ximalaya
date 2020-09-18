//
//  MineReponse.swift
//  himalaya
//
//  Created by Farben on 2020/8/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import ObjectMapper

class MineReponse<T: Mappable>: BaseResponse<T> {

    var isNeedCache: Bool = false
    
    var array: [T]?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        array          <- map["moduleInfos"]
    }
}


class MineMsgReponse<T: Mappable>: BaseResponse<T> {
    
   var nickname: String?
   var vipTip: String?
   var location: String?
   var followings: Int = 0 //关注个数
   var userGrade: Int = 0 //消息个数
    
   
   var checkInRemindInfo: T?
    
   var messages: Int = 0
   
   var mobileSmallLogo: String?
   
   var mobileMiddleLogo: String?
    
   var vipUrl: String?
    
   var bannerActivityResult: BannerActivityResult?
    
    var vipInfo: MineVipResourceInfo?


    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        nickname               <- map["nickname"]
        vipTip               <- map["vipTip"]
        location               <- map["location"]
        followings               <- map["followings"]
        messages               <- map["messages"]
        mobileSmallLogo               <- map["mobileSmallLogo"]
        mobileMiddleLogo               <- map["mobileMiddleLogo"]
        vipUrl               <- map["vipUrl"]
        checkInRemindInfo               <- map["checkInRemindInfo"]
        bannerActivityResult               <- map["bannerActivityResult"]
        vipInfo               <- map["vipResourceInfo"]
    }
}
