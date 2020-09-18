//
//  XMCacheData.swift
//  himalaya
//
//  Created by Farben on 2020/9/10.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import YYCache

class XMReadOnlyCache {
    
    
    private var cacheDisk: YYDiskCache?
        
    
    private static let shareCache: XMReadOnlyCache = {
        let share = XMReadOnlyCache()
        return share
    }()
    
    static func xmCacheDisk() -> XMReadOnlyCache {
        return XMReadOnlyCache.shareCache
    }
    
    private init() {
        if let path = Bundle.main.path(forResource: "XMCache", ofType: nil) {
            cacheDisk = YYDiskCache(path: path)
        }else {
            fatalError()
//            guard let cacheFolder = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
//                fatalError()
//            }
//            let path = cacheFolder + "/XMCache"
//            cacheDisk = YYDiskCache.init(path: path)
        }
    }
        
//    func saveData(_ json: [String : Any]?, _ key: String){
//        if json == nil {
//            return
//        }
//        guard let jsonObject = json as NSCoding? else {
//            return
//        }
//        
//        cacheDisk?.setObject(jsonObject, forKey: key)
////        cacheDisk?.setObject(jsonObject, forKey: key, with: {
////
////        })
//    }
    
    func readData(_ key: String) -> [String : Any]? {
        if cacheDisk?.containsObject(forKey: key) == false{
            print("存储失败了吗")
            return nil
        }
        if let resultJson = cacheDisk?.object(forKey: key) as? [String : Any] {
            return resultJson
        }
        return nil
    }
}


class XMReadWriteCache {
    
        private var cacheDisk: YYDiskCache?
            
        private static let shareCache: XMReadWriteCache = {
            let share = XMReadWriteCache()
            return share
        }()
        
        static func xmCacheDisk() -> XMReadWriteCache {
            return XMReadWriteCache.shareCache
        }
        
        private init() {
            guard let cacheFolder = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first else {
                    fatalError()
            }
            let path = cacheFolder + "/XMCache"
            cacheDisk = YYDiskCache.init(path: path)
        }
            
        func saveData(_ json: [String : Any]?, _ key: String){
            if json == nil {
                return
            }
            guard let jsonObject = json as NSCoding? else {
                return
            }
            
            cacheDisk?.setObject(jsonObject, forKey: key)
    //        cacheDisk?.setObject(jsonObject, forKey: key, with: {
    //
    //        })
        }
        
        func readData(_ key: String) -> [String : Any]? {
            if cacheDisk?.containsObject(forKey: key) == false{
                print("存储失败了吗")
                return nil
            }
            if let resultJson = cacheDisk?.object(forKey: key) as? [String : Any] {
                return resultJson
            }
            return nil
        }
}
