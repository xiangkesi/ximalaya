//
//  XMFmTitleRequest.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/12.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
//http://mobile.ximalaya.com/discovery-feed/related/onekey/recTrack/ts-1599889713447?channelId=480&cover=http://fdfs.xmcdn.com/group84/M0B/89/01/wKg5Hl8CmIPCvTExAACuqLrrDBc612.png&isFirst=false&like=-1&trackLimit=10

//http://mobile.ximalaya.com/discovery-feed/related/onekey/recTrack/ts-1599889713861?albumId=2823309&channelId=628&count=10&cover=http://fdfs.xmcdn.com/group84/M0B/89/01/wKg5Hl8CmIPCvTExAACuqLrrDBc612.png&duration=-0.001&isFirst=false&like=-1&page=2&ratio=-2.2727274E-6&trackId=335561464&trackLimit=10

//http://mobile.ximalaya.com/discovery-feed/related/onekey/recTrack/ts-1599891133776?channelId=590&cover=http://fdfs.xmcdn.com/group81/M08/BF/C7/wKgPEl7E2oeDEBwiAACdpEpzCX0725.png&isFirst=false&like=-1&trackLimit=10
//http://mobile.ximalaya.com/discovery-feed/related/onekey/recTrack/ts-1599891163768?albumId=31666571&channelId=590&count=10&cover=http://fdfs.xmcdn.com/group81/M08/BF/C7/wKgPEl7E2oeDEBwiAACdpEpzCX0725.png&duration=-0.001&isFirst=false&like=-1&page=2&ratio=-3.3898307E-6&trackId=335827664&trackLimit=10


//http://mobile.ximalaya.com/discovery-firstpage/headline/v2/trackItems/ts-1599890450968?channelName=%E8%B5%84%E8%AE%AF%E5%A4%B4%E6%9D%A1&cover=http://fdfs.xmcdn.com/group64/M07/53/95/wKgMc112MaCDwwGEAABu4LGulxk377.jpg&pageId=1&pageSize=60&tabId=480&track_base_url=http://mobile.ximalaya.com/discovery-firstpage/headline/v2/trackItems/ts-
//http://mobile.ximalaya.com/discovery-firstpage/headline/v2/trackItems/ts-1599890511948?channelName=%E8%B5%84%E8%AE%AF%E5%A4%B4%E6%9D%A1&cover=http://fdfs.xmcdn.com/group64/M07/53/95/wKgMc112MaCDwwGEAABu4LGulxk377.jpg&page=2&pageId=2&pageSize=60&tabId=480&track_base_url=http://mobile.ximalaya.com/discovery-firstpage/headline/v2/trackItems/ts-
//http://mobile.ximalaya.com/discovery-firstpage/headline/v2/trackItems/ts-1599890450968?channelId=480
class XMFmTitleDetailRequest: BaseRequest {
    
    override init() {
        super.init()
    }
    
    var channelId: Int = 0
    
    var cover: String?
    
    var isFirst: Bool = false
    
    var like: Int = -1
    
    var trackLimit: Int = 10
    
    
    var currentIndex: Int = 0
    
    
    override var baseUrl: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    override var path: String {
        var pathStr = ""
        
        if currentIndex == 0 {
            pathStr = String(format: "/discovery-firstpage/headline/v2/trackItems/ts-%lld", getTimeStamp())
        }else {
            pathStr = String(format: "/discovery-feed/related/onekey/recTrack/ts-%lld", getTimeStamp())
        }
        return pathStr
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobile.ximalaya.com"]
    }
    
    override var method: RequestMethod {
        return .get
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        channelId         >>> map["channelId"]
        cover         >>> map["cover"]
        isFirst         >>> map["isFirst"]
        like         >>> map["like"]
        trackLimit         >>> map["trackLimit"]
    }
}

class XMFmTitleRequest: BaseRequest {
    override var path: String {
        let pathStr = String(format: "/discovery-feed/related/onekey/loadSceneById/ts-%lld", getTimeStamp())
        return pathStr
    }
    
    override init() {
        super.init()
    }
    
    override var baseUrl: URL {
        return URL(string: "http://mobile.ximalaya.com")!
    }
    
    override var headerDic: [String : String]? {
        return ["Host" : "mobile.ximalaya.com"]
    }
    
    override var method: RequestMethod {
        return .get
    }
        
    required init?(map: Map) {
        super.init(map: map)
    }
        
    override func mapping(map: Map) {
        super.mapping(map: map)
//        offset         >>> map["offset"]
    }
}
