//
//  XMDownLoadRequest.swift
//  himalaya
//
//  Created by Farben on 2020/8/11.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import ObjectMapper

class XMDownLoadRequest: BaseRequest {
    
    private var requestUrl: String?
    
//    https://fdfs.xmcdn.com/group82/M02/E5/AA/wKg5Il8j7w3TFF4CAChT6BtVWzU464.mp4
//     override var path: String {
//           return "/group82/M02/E5/AA/wKg5Il8j7w3TFF4CAChT6BtVWzU464.mp4"
//       }
           
    init(urlString: String) {
        super.init()
        self.requestUrl = urlString
    }
//       override init() {
//           super.init()
//       }
           
       override var baseUrl: URL {
           return URL(string: requestUrl!)!
       }
       
       override var method: RequestMethod {
           return .download
       }
           
       required init?(map: Map) {
           super.init(map: map)
       }
           
       override func mapping(map: Map) {
           super.mapping(map: map)
       }
    
}
