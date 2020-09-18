//
//  XMDataCache.swift
//  HimalayanHD
//
//  Created by Farben on 2020/7/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import MMKV


/// 业务需要区别存储，单独创建自己的实例：
enum mmkvMmapID: String, CaseIterable {
    case xm_default //默认的
}

enum mmkvSaveKey: String {
    case xm_default_mine_function//我的界面功能
    case xm_default_home_data
}
class XMDataCache {
        
    static let shareCache: XMDataCache = {
        let shared = XMDataCache()
        return shared
    }()
    
    private init() {
        MMKV.initialize(rootDir: nil, logLevel: .error)
    }
    
    
//    MARK:  --------------------------------数据存储------------------------------
    @discardableResult
    func set(_ data: Any?,mapId: mmkvMmapID = .xm_default,_ saveKey: mmkvSaveKey) -> Bool? {
        if data == nil {
            return false
        }
        guard let mmkv = mmkv(mapId) else {
            return false
        }
        switch data.self {
        case is Bool:
            return mmkv.set(data as! Bool, forKey: saveKey.rawValue)
        case is Int32:
            return mmkv.set(data as! Int32, forKey: saveKey.rawValue)
        case is Int64:
            return mmkv.set(data as! Int64, forKey: saveKey.rawValue)
        case is Float:
            return mmkv.set(data as! Float, forKey: saveKey.rawValue)
        case is String:
            return mmkv.set(data as! String, forKey: saveKey.rawValue)
        case is Data:
            return mmkv.set(data as! Data, forKey: saveKey.rawValue)
        case is Date:
            return mmkv.set(data as! Date, forKey: saveKey.rawValue)
        default:
            return false
        }
    }
    
    
//    MARK:  --------------------------------数据读取------------------------------

    func getBool(mapId: mmkvMmapID = .xm_default,_ saveKey: mmkvSaveKey) -> Bool? {
        guard let mmkv = mmkv(mapId) else {
            return nil
        }
        return mmkv.bool(forKey: saveKey.rawValue)
    }
    
    func getInt32(mapId: mmkvMmapID = .xm_default,_ saveKey: mmkvSaveKey) -> Int32? {
        guard let mmkv = mmkv(mapId) else {
            return nil
        }
        return mmkv.int32(forKey: saveKey.rawValue)
    }
    
    func getInt64(mapId: mmkvMmapID = .xm_default,_ saveKey: mmkvSaveKey) -> Int64? {
        guard let mmkv = mmkv(mapId) else {
            return nil
        }
        return mmkv.int64(forKey: saveKey.rawValue)
    }
    
    func getFloat(mapId: mmkvMmapID = .xm_default,_ saveKey: mmkvSaveKey) -> Float? {
        guard let mmkv = mmkv(mapId) else {
            return nil
        }
        return mmkv.float(forKey: saveKey.rawValue)
    }
    
    func getString(mapId: mmkvMmapID = .xm_default,_ saveKey: mmkvSaveKey) -> String? {
        guard let mmkv = mmkv(mapId) else {
            return nil
        }
        return mmkv.string(forKey: saveKey.rawValue)
    }
    
    func getData(mapId: mmkvMmapID = .xm_default,_ saveKey: mmkvSaveKey) -> Data? {
        guard let mmkv = mmkv(mapId) else {
            return nil
        }
        return mmkv.data(forKey: saveKey.rawValue)
    }
    
    func getDate(mapId: mmkvMmapID = .xm_default,_ saveKey: mmkvSaveKey) -> Date? {
        guard let mmkv = mmkv(mapId) else {
            return nil
        }
        return mmkv.date(forKey: saveKey.rawValue)
    }
    
    
//    MARK:  --------------------------------清除磁盘数据------------------------------

    
    
    /// 移除单个mmkv内的单个key的值
    /// - Parameters:
    ///   - mapId: 哪个mmkv
    ///   - saveKey: 哪个key
    func removeValue(mapId: mmkvMmapID = .xm_default, saveKey: mmkvSaveKey) {
        guard let mmkv = mmkv(mapId) else {
            return
        }
        mmkv.removeValue(forKey: saveKey.rawValue)
    }
    
    /// 清除单个mmkv内的几个keys
    /// - Parameters:
    ///   - mapId: 单个mmkv
    ///   - saveKeys: 单个mmkv内的keys
    func removeValues(mapId: mmkvMmapID = .xm_default,_ saveKeys: [mmkvSaveKey.RawValue]) {
        
        guard let mmkv = mmkv(mapId) else {
            return
        }
        mmkv.removeValues(forKeys: saveKeys)
    }
    
    /// 清楚单个mmkv内的数据
    /// - Parameter mapId: 哪个mmkv
    func clearAll(_ mapId: mmkvMmapID = .xm_default) {
        guard let mmkv = mmkv(mapId) else {
            return
        }
        mmkv.clearAll()
    }
    
    /// 清除所有的mmkv对象内的数据
      func mmkvsClearAll() {
          for cases in mmkvMmapID.allCases {
              clearAll(cases)
          }
      }
    
//    MARK:  --------------------------------数据大小------------------------------

    /// 单个mmkv内的数据大小
    /// - Parameter mapId: 单个mmkv
    /// - Returns: 返回的大小
    func totalSize(_ mapId: mmkvMmapID = .xm_default) -> Int {
        guard let mmkv = mmkv(mapId) else {
            return 0
        }
        return mmkv.totalSize()
    }
    
    /// 所有的mmkv内的大小
    /// - Returns: 返回大小
    func allMmmkvTotalSize() -> Int {
        var allSize = 0
        for cases in mmkvMmapID.allCases {
            allSize += totalSize(cases)
        }
        return allSize
    }
    
    
    /// 单个mmkv内数量
    /// - Parameter mapId: 单个mmkv
    /// - Returns: 个数
    func mmkvCount(_ mapId: mmkvMmapID = .xm_default) -> Int {
        guard let mmkv = mmkv(mapId) else {
            return 0
        }
        return mmkv.count()
    }
    
    
    /// 所有的mmkv
    /// - Returns: 个数
    func allMmkvCount() -> Int {
        var count = 0
        for cases in mmkvMmapID.allCases {
            count += mmkvCount(cases)
        }
        return count
    }

//    MARK:  --------------------------------清除内存缓存------------------------------

    
    /// 清除单个mmkv内存缓存
    /// - Parameter mapId: 哪个mmkv
    func clearMemoryCache(_ mapId: mmkvMmapID = .xm_default) {
         if let mmkv = mmkv(mapId) {
            mmkv.clearMemoryCache()
        }
    }
    
    /// 清除所有的mmkv内存缓存
    func clearAllMemoryCache() {
        for cases in mmkvMmapID.allCases {
            if let mmkv = mmkv(cases) {
                mmkv.clearMemoryCache()
            }
        }
    }
    
//    + (NSString *)mmkvBasePath
    
    
    var mmkvBasePath: String {
        get {MMKV.mmkvBasePath()}
    }
    
    
    private func mmkv(_ mapId: mmkvMmapID) -> MMKV? {
        if MMKV.isFileValid(for: mapId.rawValue) == false {
            return nil
        }
        return MMKV(mmapID: mapId.rawValue)
    }
}
