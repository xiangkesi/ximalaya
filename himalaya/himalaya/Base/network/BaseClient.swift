//
//  BaseRequest.swift
//  gokarting
//
//  Created by Farben on 2020/7/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import Moya
import ObjectMapper
import RxSwift

let base_provider = BaseProvider(endpointClosure: myEndpointClosure, requestClosure: requestClosure, plugins: [myLoggerPlugin, spinerPlugin])
//myLoggerPlugin
let xm_provider = BaseProvider(requestClosure: requestClosure, plugins: [myLoggerPlugin, spinerPlugin])


// MARK: - 默认的网络提示请求插件
private let spinerPlugin = NetworkActivityPlugin { (state,target) in
    if state == .began {
//        print("我开始请求")
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    } else {
        
//        print("我结束请求")
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
    }
}

/// 超市时间
private let requestClosure = { (endpoint: Endpoint, closure: (Result<URLRequest, MoyaError>) -> Void)  -> Void in
    do {
        var  urlRequest = try endpoint.urlRequest()
        urlRequest.timeoutInterval = 30.0
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        urlRequest.httpShouldHandleCookies = false
        closure(.success(urlRequest))
    } catch MoyaError.requestMapping(let url) {
        closure(.failure(MoyaError.requestMapping(url)))
    } catch MoyaError.parameterEncoding(let error) {
        closure(.failure(MoyaError.parameterEncoding(error)))
    } catch {
        closure(.failure(MoyaError.underlying(error, nil)))
    }
    
}

private let myEndpointClosure = { (target: TargetType) -> Endpoint in
    
    let url = target.baseURL.appendingPathComponent(target.path).absoluteString
    var endpoint: Endpoint = Endpoint(
          url: url,
          sampleResponseClosure: {.networkResponse(200, target.sampleData)},
          method: target.method,
          task: target.task,
          httpHeaderFields: target.headers
      )
//    do {
//        //设置通用header
//        var urlRequest = try endpoint.urlRequest()
//        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: publicParameters, options: .prettyPrinted)
//    } catch let error  {
//        print(error)
//    }
    return endpoint.adding(newHTTPHeaderFields: [
        "Content-Type" : "application/x-www-form-urlencoded",
        "Cookie": "domain=.ximalaya.com; path=/; channel=ios-b1; 1&_device=iPhone&1605D009-7E02-4A91-B8AA-E053CE83BA30&6.7.3; impl=com.gemd.iting; XUM=1605D009-7E02-4A91-B8AA-E053CE83BA30; c-oper=%E7%A7%BB%E5%8A%A8; net-mode=WIFI; res=640%2C1136; 1&_token=80567972&6381D010240C98C8D15628A4DDAF3B9FF14344E651845E559FF32AA7619BB11CDDD43583FDA11M09280338C54CC57_; dtoken=249088500&1605D009-7E02-4A91-B8AA-E053CE83BA30; idfa=1605D009-7E02-4A91-B8AA-E053CE83BA30; x_xmly_ts=1600325825561; x_xmly_resource=xm_source%3ApaidCategory%26xm_medium%3ApaidCategory; x_xmly_tid=2471540833; device_model=iPhone5s; XD=iRWWlOOWxA7EO5iwzyv2V29XqF0bWHWF+iGgcf+cgX9IBhQhJTqvwWYM114ZW/I3rDUKuhHxmncD1oSoUESpdA==; fp=0061v2v473232242vv34v153294402; freeFlowType=0; minorProtectionStatus=0",
        "User-Agent": "ting_v6.7.3_c5(CFNetwork, iOS 12.4.8, iPhone6,2)",
        "Accept-Language": "zh-Hans-CN;q=1",
        "Accept-Encoding": "gzip,deflate",
        "Connection": "keep-alive",
//        "Content-Length": "13",
        "Accept": "application/json;application/octet-stream;text/,text/json;text/plain;text/javascript;text/xml;application/x-www-form-urlencoded;image/png;image/jpeg;image/jpg;image/gif;image/bmp;image/*"
    ])
    
}

// MARK: - 调试plugin
private let myLoggerPlugin = NetworkLoggerPlugin(configuration: .init(formatter: .init(responseData: JSONResponseDataFormatter), logOptions: .verbose))

private func JSONResponseDataFormatter(_ data: Data) -> String {
    do {
        let dataAsJSON = try JSONSerialization.jsonObject(with: data)
        let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
        return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
    } catch {
        return String(data: data, encoding: .utf8) ?? ""
    }
}

func cancellAllRequest() {
    base_provider.session.cancelAllRequests(completingOnQueue: DispatchQueue.global()) {
    }

}

class BaseProvider: MoyaProvider<MultiTarget> {
    
}

extension BaseProvider {
    
    internal func base_request_json(target: TargetType) -> Single<Any> {
        return rx.request(MultiTarget(target)).filterSuccessfulStatusCodes().mapJSON()
    }
    
    internal func base_request_model<T: Mappable>(target: TargetType, model: T.Type, callbackQueue: DispatchQueue? = nil) -> Single<T> {
        return rx.request(MultiTarget(target)).filterSuccessfulStatusCodes().mapObject(T.self)
    }
    
    internal func base_request_files(target: TargetType, callbackQueue: DispatchQueue? = nil) -> Observable<ProgressResponse> {
        return rx.requestWithProgress(MultiTarget(target), callbackQueue: callbackQueue)

    }
    
}

extension Reactive where Base: BaseProvider {
    
    internal func base_rx_request_model<T: Mappable>(target: TargetType, model: T.Type, callbackQueue: DispatchQueue? = nil) -> Single<T> {
        
        return base.rx.request(MultiTarget(target), callbackQueue: callbackQueue).filterSuccessfulStatusCodes().mapObject(T.self)
    }
    
    
    internal func base_rx_request_json(target: TargetType, callbackQueue: DispatchQueue? = nil) -> Single<Any> {
        return base.rx.request(MultiTarget(target), callbackQueue: callbackQueue).filterSuccessfulStatusCodes().mapJSON()
    }
    
    
    internal func base_rx_request_files(target: TargetType, callbackQueue: DispatchQueue? = nil) -> Observable<ProgressResponse> {
       return base.rx.requestWithProgress(MultiTarget(target), callbackQueue: callbackQueue)
    }
}
