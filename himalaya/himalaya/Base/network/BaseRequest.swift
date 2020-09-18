//
//  BaseRequest.swift
//  gokarting
//
//  Created by Farben on 2020/7/27.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper
import Moya

enum RequestMethod {
    case get
    case post
    case download
    case upload
}
class BaseRequest: Mappable {
    
    var path: String {
        return ""
    }
    
    var baseUrl: URL {
        return URL(string: "")!
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var headerDic: [String: String]? {
        return nil
    }
    
        
    required init?(map: Map) {
        
    }
    
    init() {
        
    }
    
    func mapping(map: Map) {

    }

    /// 下载文件用到
    var downloadDestination: DownloadDestination {
        return { _, _ in return (self.saveUrl, [.removePreviousFile, .createIntermediateDirectories]) }
    }
    
    /// 文件夹
    var folderPath: String?
    
    /// 文件名字
    var fileName: String?
    
    private var saveUrl: URL {
        let manager = FileManager.default
        let baseStr = NSHomeDirectory() + "/Documents/" + (folderPath ?? "folderPath")
        let exist = manager.fileExists(atPath: baseStr)
        if exist == false {
            do {
                try manager.createDirectory(atPath: baseStr, withIntermediateDirectories: true, attributes: nil)
            } catch {
               print("创建失败")
            }
        }
        print("是什么呢\(baseStr)")
        var saveUrl = URL(fileURLWithPath: baseStr)
        saveUrl.appendPathComponent(fileName ?? self.path)
        return saveUrl
    }
}



