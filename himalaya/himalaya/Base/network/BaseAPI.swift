//
//  BaseAPI.swift
//  gokarting
//
//  Created by Farben on 2020/7/27.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import Moya

struct BaseAPI {
    
    private var request: BaseRequest
    
    init(request: BaseRequest) {
        self.request = request
    }
    
}

extension BaseAPI: TargetType {
    var baseURL: URL {
        return request.baseUrl
    }
    
    var path: String {
        return request.path
    }
    
    var method: Moya.Method {
        
        switch request.method {
        case .get,
             .download:
            return .get
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        
        switch request.method {
            case RequestMethod.download:
                return .downloadDestination(request.downloadDestination)
            default:
                return .requestParameters(parameters: request.toJSON(), encoding: URLEncoding.default)
        }
        
    }
    
    var headers: [String : String]? {
        return request.headerDic
    }
}
