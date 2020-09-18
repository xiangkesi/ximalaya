//
//  BundleExtension.swift
//  gokarting
//
//  Created by Farben on 2020/7/21.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation

extension Bundle {
    
    internal static var nameSpace: String{
          get {
              let dic = Bundle.main.infoDictionary
              let spaceName = dic?["CFBundleName"] as? String ?? ""
              return spaceName
          }
    }
}
