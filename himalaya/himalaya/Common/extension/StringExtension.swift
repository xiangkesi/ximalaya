//
//  StringExtension.swift
//  himalaya
//
//  Created by cocoazhang on 2020/8/9.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    /// 截取到任意位置
      func subString(to: Int) -> String {
          let index: String.Index = self.index(startIndex, offsetBy: to)
          return String(self[..<index])
      }
      /// 从任意位置开始截取
      func subString(from: Int) -> String {
          let index: String.Index = self.index(startIndex, offsetBy: from)
          return String(self[index ..< endIndex])
      }
      /// 从任意位置开始截取到任意位置
      func subString(from: Int, to: Int) -> String {
          let beginIndex = self.index(self.startIndex, offsetBy: from)
          let endIndex = self.index(self.startIndex, offsetBy: to)
          return String(self[beginIndex...endIndex])
      }
      //使用下标截取到任意位置
      subscript(to: Int) -> String {
          let index = self.index(self.startIndex, offsetBy: to)
          return String(self[..<index])
      }
      //使用下标从任意位置开始截取到任意位置
      subscript(from: Int, to: Int) -> String {
          let beginIndex = self.index(self.startIndex, offsetBy: from)
          let endIndex = self.index(self.startIndex, offsetBy: to)
          return String(self[beginIndex...endIndex])
      }
    
    
    var md5:String {
        let utf8 = cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(utf8, CC_LONG(utf8!.count - 1), &digest)
        return digest.reduce("") { $0 + String(format:"%02X", $1) }
    }
    
    func qmui_queryItems() -> [String: String]? {
        if self.count == 0 {
            return nil
        }
        if let urlComponent = URLComponents(string: self), let urlComponents = urlComponent.queryItems {
            var params = [String: String]()
            for obj in urlComponents {
                params[obj.name] = (obj.value != nil) ? obj.value : ""
            }
            return params
        }
        return nil
    }
    
    mutating func urlAddCompnentForDic(dic: [String: String]) {
        for (key, value) in dic {
            urlAddCompnentForValue(with: key, value: value)
        }
    }
    mutating func urlAddCompnentForValue(with key: String, value: String) {
          //先判断链接是否带？
          if self.contains("?") {
              //?号是否在最后一个字符
              if self.last == "?" {
                  self += "\(key)=\(value)"
              } else {
                  //最后一个字符是否是&
                  if self.last == "&" {
                      self += "\(key)=\(value)"
                  } else {
                      self += "&\(key)=\(value)"
                  }
              }
          } else {
              //不带问号
              self += "?\(key)=\(value)"
          }
      }

}
