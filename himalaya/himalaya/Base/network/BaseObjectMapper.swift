//
//  MoyaRxSwiftObjectMapperExtension.swift
//  HimalayanHD
//
//  Created by Farben on 2020/7/10.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper
import Moya

extension Response {

    func mapObject<T: BaseMappable>(type: T.Type) throws -> T {

        /// 喜马拉雅的数据通用格式, 防止数据返回格式不对,闪退
        var jsonString: String = "{\"ret\":2000,\"msg\":\"解析错误了\"}"
        if let text = String(bytes: self.data, encoding: .utf8) {
            jsonString = text
        }
        if let responseModel = Mapper<T>().map(JSONString: jsonString) {
            return responseModel
        }
        return Mapper<T>().map(JSONString: "{\"ret\":2000,\"msg\":\"解析错误了\"}")!
    }

    func mapArray<T: BaseMappable>(type: T.Type) throws -> [T] {
        let text = String(bytes: self.data, encoding: .utf8)
        return Mapper<T>().mapArray(JSONString: text!)!
    }
}

public extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    func mapObject<T: BaseMappable>(_ type: T.Type) -> Single<T> {
        
        return flatMap { response -> Single<T> in
            return Single.just(try response.mapObject(type: type))
        }
        
    }
    
    
    func mapArray<T: BaseMappable>(_ type: T.Type) -> Single<[T]> {
        return flatMap { (response) -> Single<[T]> in
            return Single.just(try response.mapArray(type: type))
        }
    }
}






// MARK: ------Extension for processing Responses into Mappable objects through ObjectMapper

extension ObservableType where Element == Response {
    
    
    func mapObject<T: BaseMappable>(_ type: T.Type) -> Observable<T> {
        
        return flatMap { (response) -> Observable<T> in
            return Observable.just(try response.mapObject(type: type))
        }
    }
    
    func mapArray<T: BaseMappable>(_ type: T.Type) -> Observable<[T]> {
        
        return flatMap { (response) -> Observable<[T]> in
            return Observable.just(try response.mapArray(type: type))
        }
    }
}
