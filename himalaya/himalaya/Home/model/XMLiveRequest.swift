//
//  XMLiveRequest.swift
//  himalaya
//
//  Created by Farben on 2020/9/1.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

//:method    GET
//:path    /focusPicture/ts-1599027190179?appid=0&categoryId=-3&device=android&deviceId=3b415853-d57e-3df9-a2e3-d8ab2232c5c6&network=wifi&operator=1&scale=2&version=6.6.99&xt=1599027190179
//:authority    adse.ximalaya.com
//:scheme    https
//cookie    1&_device=android&3b415853-d57e-3df9-a2e3-d8ab2232c5c6&6.6.99;1&_token=80567972&DC144AD0340C200530607250F78FFA98C175E4BDCAC509FB7BD1D91C7BEA549B78D8E1E42BE2182M43e28bc5BCB36E7_;channel=and-d3;impl=com.ximalaya.ting.android;osversion=29;fp=006212647z232242vv34vv53294001;device_model=BMH-AN10;XUM=glwKsIw5;XIM=;c-oper=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A;net-mode=WIFI;freeFlowType=0;res=1080%2C2289;NSUP=;AID=5bLMe9aMpws=;manufacturer=HUAWEI;XD=koixdsNp2dRPa7ZjwmVWtAptfNUIxaRXYJVtfpN2i6t1kgBNpFYtv22LGSo6edpNFtGIoHuteSSRZSX5GqOVcxHzuyh5p40gIdxJ2geLrl4oOdKDNwdG7nsmKp7hw9OHvJ8o3qWE9mJbrYBlyJDisQ==;umid=aibc2597f46aeb52ffe43f62e0a84e4c2a;xm_grade=0;minorProtectionStatus=0;oaid=bfb6628a-5fd5-4ef4-b309-4f6d16d3e07e;newChannelId=yz-huawei;iccId=89860115831018288234;domain=.ximalaya.com;path=/;
//cookie2    $version=1
//accept    */*
//user-agent    ting_6.6.99(BMH-AN10,Android29)
//accept-encoding    gzip
//https://adse.ximalaya.com/focusPicture/ts-1599027190179?appid=0&categoryId=-3&device=android&deviceId=3b415853-d57e-3df9-a2e3-d8ab2232c5c6&network=wifi&operator=1&scale=2&version=6.6.99&xt=1599027190179

class XMLiveFocusImageRequest: BaseRequest {
    
    var appid: Int = 0
    var categoryId: Int = -3
    var device: String = "iPhone"
    var deviceId = "1605D009-7E02-4A91-B8AA-E053CE83BA30"
    var network = "wifi"
    var operatorId: Int = 1
    var scale: Int = 2
    var version = "6.6.99"
    var xt: Int64 = getTimeStamp()

    override var baseUrl: URL {
        return URL(string: "https://adse.ximalaya.com")!
    }
    override var method: RequestMethod {
        return .get
    }
    override var path: String {
        return "/focusPicture/ts-\(getTimeStamp())"
    }
    
    override var headerDic: [String : String]? {
        return ["authority": "adse.ximalaya.com"]
    }
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        appid          >>> map["appid"]
        categoryId          >>> map["categoryId"]
        device          >>> map["device"]
        deviceId          >>> map["deviceId"]
        network          >>> map["network"]
        operatorId          >>> map["operator"]
        scale          >>> map["scale"]
        version          >>> map["version"]
        xt          >>> map["xt"]
        
    }
}
//    GET /lamia/v3/live/rank_list?timeToPreventCaching=1599027190179 HTTP/1.1
//Cookie    1&_device=android&3b415853-d57e-3df9-a2e3-d8ab2232c5c6&6.6.99;1&_token=80567972&DC144AD0340C200530607250F78FFA98C175E4BDCAC509FB7BD1D91C7BEA549B78D8E1E42BE2182M43e28bc5BCB36E7_;channel=and-d3;impl=com.ximalaya.ting.android;osversion=29;fp=006212647z232242vv34vv53294001;device_model=BMH-AN10;XUM=glwKsIw5;XIM=;c-oper=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A;net-mode=WIFI;freeFlowType=0;res=1080%2C2289;NSUP=;AID=5bLMe9aMpws=;manufacturer=HUAWEI;XD=koixdsNp2dRPa7ZjwmVWtAptfNUIxaRXYJVtfpN2i6t1kgBNpFYtv22LGSo6edpNFtGIoHuteSSRZSX5GqOVcxHzuyh5p40gIdxJ2geLrl4oOdKDNwdG7nsmKp7hw9OH4iQOlD4xnxXu3FL3PkYipg==;umid=aibc2597f46aeb52ffe43f62e0a84e4c2a;xm_grade=0;minorProtectionStatus=0;oaid=bfb6628a-5fd5-4ef4-b309-4f6d16d3e07e;newChannelId=yz-huawei;iccId=89860115831018288234;domain=.ximalaya.com;path=/;
//Cookie2    $version=1
//Accept    */*
//user-agent    ting_6.6.99(BMH-AN10,Android29)
//Host    live.ximalaya.com
//Accept-Encoding    gzip
//Connection    keep-alive
//http://114.80.170.77/lamia/v3/live/rank_list?timeToPreventCaching=1599027190179

class XMLiveRankRequest: BaseRequest {
    
    var timeToPreventCaching: Int64 = getTimeStamp()
    
    override var baseUrl: URL {
        return URL(string: "http://114.80.170.77")!
    }
    
    override var method: RequestMethod {
        return .get
    }
    
    override var path: String {
        return "/lamia/v3/live/rank_list"
    }
    
    override var headerDic: [String : String]? {
        return ["Host": "live.ximalaya.com"]
    }
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        timeToPreventCaching          >>> map["timeToPreventCaching"]
    }
}






//http://114.80.139.232/lamia/v15/live/homepage?categoryType=1&pageId=1&pageSize=20&sign=2&timeToPreventCaching=1599027429476

//    GET /lamia/v15/live/homepage?categoryType=1&pageId=1&pageSize=20&sign=2&timeToPreventCaching=1599027429476 HTTP/1.1
//Cookie    1&_device=android&3b415853-d57e-3df9-a2e3-d8ab2232c5c6&6.6.99;1&_token=80567972&DC144AD0340C200530607250F78FFA98C175E4BDCAC509FB7BD1D91C7BEA549B78D8E1E42BE2182M43e28bc5BCB36E7_;channel=and-d3;impl=com.ximalaya.ting.android;osversion=29;fp=006212647z232242vv34vv53294001;device_model=BMH-AN10;XUM=glwKsIw5;XIM=;c-oper=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A;net-mode=WIFI;freeFlowType=0;res=1080%2C2289;NSUP=;AID=5bLMe9aMpws=;manufacturer=HUAWEI;XD=koixdsNp2dRPa7ZjwmVWtAptfNUIxaRXYJVtfpN2i6t1kgBNpFYtv22LGSo6edpNFtGIoHuteSSRZSX5GqOVcxHzuyh5p40gIdxJ2geLrl4oOdKDNwdG7nsmKp7hw9OH2WFbFNwBbE7mbCcZHSNlmA==;umid=aibc2597f46aeb52ffe43f62e0a84e4c2a;xm_grade=0;minorProtectionStatus=0;oaid=bfb6628a-5fd5-4ef4-b309-4f6d16d3e07e;newChannelId=yz-huawei;iccId=89860115831018288234;domain=.ximalaya.com;path=/;
//Cookie2    $version=1
//Accept    */*
//user-agent    ting_6.6.99(BMH-AN10,Android29)
//Host    live.ximalaya.com
//Accept-Encoding    gzip
//Connection    keep-alive

class XMLiveRequest: BaseRequest {
    var timeToPreventCaching: Int64 = getTimeStamp()
    var sign: Int = 2
    var pageSize: Int = 32
    var pageId: Int = 1
    var categoryType: Int = 1
    
    var isRefreshHeader: Bool = false
    
    
    
    override var baseUrl: URL {
        return URL(string: "http://114.80.139.232")!
    }
    
    override var method: RequestMethod {
        return .get
    }
    
    override var path: String {
        return "/lamia/v15/live/homepage"
    }
    
    override var headerDic: [String : String]? {
        return ["Host": "live.ximalaya.com"]
    }
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        super.init(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        timeToPreventCaching          >>> map["timeToPreventCaching"]
        sign          >>> map["sign"]
        pageSize          >>> map["pageSize"]
        pageId          >>> map["pageId"]
        categoryType          >>> map["categoryType"]
    }
}

//http://114.80.139.232/lamia/v15/live/homepage?categoryType=1&pageId=2&pageSize=20&sign=1&timeToPreventCaching=1599027455961
//    GET /lamia/v15/live/homepage?categoryType=1&pageId=2&pageSize=20&sign=1&timeToPreventCaching=1599027455961 HTTP/1.1
//Cookie    1&_device=android&3b415853-d57e-3df9-a2e3-d8ab2232c5c6&6.6.99;1&_token=80567972&DC144AD0340C200530607250F78FFA98C175E4BDCAC509FB7BD1D91C7BEA549B78D8E1E42BE2182M43e28bc5BCB36E7_;channel=and-d3;impl=com.ximalaya.ting.android;osversion=29;fp=006212647z232242vv34vv53294001;device_model=BMH-AN10;XUM=glwKsIw5;XIM=;c-oper=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A;net-mode=WIFI;freeFlowType=0;res=1080%2C2289;NSUP=;AID=5bLMe9aMpws=;manufacturer=HUAWEI;XD=koixdsNp2dRPa7ZjwmVWtAptfNUIxaRXYJVtfpN2i6t1kgBNpFYtv22LGSo6edpNFtGIoHuteSSRZSX5GqOVcxHzuyh5p40gIdxJ2geLrl4oOdKDNwdG7nsmKp7hw9OHXC2Hq2m82Gi1Xdms6pcwog==;umid=aibc2597f46aeb52ffe43f62e0a84e4c2a;xm_grade=0;minorProtectionStatus=0;oaid=bfb6628a-5fd5-4ef4-b309-4f6d16d3e07e;newChannelId=yz-huawei;iccId=89860115831018288234;domain=.ximalaya.com;path=/;
//Cookie2    $version=1
//Accept    */*
//user-agent    ting_6.6.99(BMH-AN10,Android29)
//Host    live.ximalaya.com
//Accept-Encoding    gzip
//Connection    keep-alive


//http://114.80.139.232/lamia/v15/live/homepage?categoryType=1&pageId=3&pageSize=20&sign=1&timeToPreventCaching=1599027458593
//    GET /lamia/v15/live/homepage?categoryType=1&pageId=3&pageSize=20&sign=1&timeToPreventCaching=1599027458593 HTTP/1.1
//Cookie    1&_device=android&3b415853-d57e-3df9-a2e3-d8ab2232c5c6&6.6.99;1&_token=80567972&DC144AD0340C200530607250F78FFA98C175E4BDCAC509FB7BD1D91C7BEA549B78D8E1E42BE2182M43e28bc5BCB36E7_;channel=and-d3;impl=com.ximalaya.ting.android;osversion=29;fp=006212647z232242vv34vv53294001;device_model=BMH-AN10;XUM=glwKsIw5;XIM=;c-oper=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A;net-mode=WIFI;freeFlowType=0;res=1080%2C2289;NSUP=;AID=5bLMe9aMpws=;manufacturer=HUAWEI;XD=koixdsNp2dRPa7ZjwmVWtAptfNUIxaRXYJVtfpN2i6t1kgBNpFYtv22LGSo6edpNFtGIoHuteSSRZSX5GqOVcxHzuyh5p40gIdxJ2geLrl4oOdKDNwdG7nsmKp7hw9OHb09y42CVX3DlozNuX/S1GQ==;umid=aibc2597f46aeb52ffe43f62e0a84e4c2a;xm_grade=0;minorProtectionStatus=0;oaid=bfb6628a-5fd5-4ef4-b309-4f6d16d3e07e;newChannelId=yz-huawei;iccId=89860115831018288234;domain=.ximalaya.com;path=/;
//Cookie2    $version=1
//Accept    */*
//user-agent    ting_6.6.99(BMH-AN10,Android29)
//Host    live.ximalaya.com
//Accept-Encoding    gzip
//Connection    keep-alive






//    GET /lamia/v15/live/homepage?categoryType=12&pageId=1&pageSize=20&sign=1&timeToPreventCaching=1599027586902 HTTP/1.1
//Cookie    1&_device=android&3b415853-d57e-3df9-a2e3-d8ab2232c5c6&6.6.99;1&_token=80567972&DC144AD0340C200530607250F78FFA98C175E4BDCAC509FB7BD1D91C7BEA549B78D8E1E42BE2182M43e28bc5BCB36E7_;channel=and-d3;impl=com.ximalaya.ting.android;osversion=29;fp=006212647z232242vv34vv53294001;device_model=BMH-AN10;XUM=glwKsIw5;XIM=;c-oper=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A;net-mode=WIFI;freeFlowType=0;res=1080%2C2289;NSUP=;AID=5bLMe9aMpws=;manufacturer=HUAWEI;XD=koixdsNp2dRPa7ZjwmVWtAptfNUIxaRXYJVtfpN2i6t1kgBNpFYtv22LGSo6edpNFtGIoHuteSSRZSX5GqOVcxHzuyh5p40gIdxJ2geLrl4oOdKDNwdG7nsmKp7hw9OHlvOf0maf/CAgJxKH2pC+cA==;umid=aibc2597f46aeb52ffe43f62e0a84e4c2a;xm_grade=0;minorProtectionStatus=0;oaid=bfb6628a-5fd5-4ef4-b309-4f6d16d3e07e;newChannelId=yz-huawei;iccId=89860115831018288234;domain=.ximalaya.com;path=/;
//Cookie2    $version=1
//Accept    */*
//user-agent    ting_6.6.99(BMH-AN10,Android29)
//Host    live.ximalaya.com
//Accept-Encoding    gzip
//Connection    keep-alive
//
// http://114.80.170.77/lamia/v15/live/homepage?categoryType=12&pageId=1&pageSize=20&sign=1&timeToPreventCaching=1599027586902
