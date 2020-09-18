//
//  ConfigKingfisher.swift
//  himalaya
//
//  Created by Farben on 2020/8/25.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import Kingfisher

struct ConfigKingfisher {
    
    static func configKingfisher() {
        let shared = KingfisherManager.shared
        shared.downloader.downloadTimeout = 8
        shared.cache.diskStorage.config.sizeLimit = 50 * 1024 * 1024
//        shared.cache.diskStorage.config.expiration = 60 * 60 * 24 * 3

    }
    
    static func removeMemoryCache() {
        let shared = KingfisherManager.shared.cache
        shared.clearMemoryCache()
    }
    
    static func cancelAllTask() {
        KingfisherManager.shared.downloader.cancelAll()
    }
    
    static func removeDIskCache() {
        KingfisherManager.shared.cache.clearDiskCache()
        // 清理过期或大小超过磁盘限制缓存。这是一个异步的操作
//        KingfisherManager.shared.cache.cleanExpiredDiskCache()
    }
    
    static func downLoadImage() {
//        KingfisherManager.shared.retrieveImage(with: <#T##Resource#>, completionHandler: <#T##((Result<RetrieveImageResult, KingfisherError>) -> Void)?##((Result<RetrieveImageResult, KingfisherError>) -> Void)?##(Result<RetrieveImageResult, KingfisherError>) -> Void#>)
//        KingfisherManager.shared.retrieveImage(with: URL(string: "")!) { (result, error) in
//            
//        }
    }
}
