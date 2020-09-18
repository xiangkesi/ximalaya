//
//  Const.swift
//  gokarting
//
//  Created by Farben on 2020/7/22.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import UIKit
import FileProvider
import Kingfisher
//https://m.ximalaya.com/explore/subject_detail?id=9046&use_lottie=false

var common_damin = "https://m.ximalaya.com/explore/subject_detail"

enum XMCellType: Equatable {
    
    case module(XMModuleType)
    case album
    case track
    case live
    case special
    case video
    case one_key_listen_scene
    case recent_listen //首页猜你在追
    case dubFeedItem
    case vip_new_status_V3
    case vip_square(XMSquare)
    case history
    case recommendation
    case audition //首页 分页VIP的轮播图
    case vipcategoriewords //自己添加的不是后台返回的,VIP中的分类词
    case unKnow
//    TRACK SPECIAL VIDEO ONE_KEY_LISTEN_SCENE RECENT_LISTEN HISTORY RECOMMENDATION AUDITION VIPCATEGORIEWORDS
}

enum XMModuleType {
    case focus //首页bander图
    case square //首页五个分类功能
    case topBuzz //首页今日热点
    case guessYouLike //首页猜你喜欢
    case ad //首页广告
    case hotSearchList // 首页热词
    case cityCategory //首页听上海
    case hotPlayRank //首页热播排行榜
    case voice_room_card //首页语音房
    case paidCategory //首页精品
    case live //首页直播
    case specialList // 首页听单
    case anchor_card  //首页人气电台
    case fmList //首页FM
    case dubFeedRecoDub
    case dubFeedAd
    case dubFeedRecoAnchor
    case categoryWord //首页的分类词
    case custom_album_aggregate_picture //vip页面的广告,就单张图片那个
    case custom_album_aggregate_card//vip页面的影视原著
    case interest_and_hot_word
    case rank_list //首页vip页面的上新推荐
    case star //明星
    case picture //就单张的图片
    case unknow
}//CUSTOM_ALBUM  INTEREST_AND_HOT_WORD CUSTOM_ALBUM  AGGREGATE_CARD RANK_LIST

enum XMSquare {
    case picture_and_text
    case picture
}

enum DataError: Error {
    case cantParseJSON
}
//PICTURE PICTURE_AND_TEXT
let mainColorString = "EC613E"

let xm_screen_width = UIDevice.screen_width
let xm_screen_height = UIDevice.screen_height
let xm_padding: CGFloat = 15

let xm_navgationheight: CGFloat = UIDevice.navBar_statusHeight


let content_view_width: CGFloat = xm_screen_width - 30



func saveFile(fileData: Data, fileName: String, folderPath: String, isCover: Bool = false) -> Bool {
    let manager = FileManager.default
    let baseStr = NSHomeDirectory() + "/Documents/" + folderPath
    let exist = manager.fileExists(atPath: baseStr)
    if exist == false {
        do {
            try manager.createDirectory(atPath: baseStr, withIntermediateDirectories: true, attributes: nil)
        } catch {
            return false //文件夹创建失败
        }
    }
    let filePath = baseStr + "/" + fileName
    if isCover == false {
        if manager.fileExists(atPath: filePath) {
            print("已经存在无需保存")
            return false
        }
    }
    let pathUrl = URL(fileURLWithPath: filePath)
    do {
        try fileData.write(to: pathUrl)
    } catch  {
        return false
    }
    return true
}


func judgeFileExist(fileName: String, folderPath: String) -> Bool {
    let manager = FileManager.default
    let baseUrl = NSHomeDirectory() + "/Documents/" + folderPath + "/" + fileName
    let exist = manager.fileExists(atPath: baseUrl)
    if exist {
        return true
    }
    return false
}
/// 删除单个文件
/// - Parameters:
///   - fileName: 文件名字
///   - folderPath: 文件所在文件夹
/// - Returns: 成功或者失败
func deleteFile(fileName: String, folderPath: String) -> Bool {
    let manager = FileManager.default
    let baseUrl = NSHomeDirectory() + "/Documents/" + folderPath + "/" + fileName
    let exist = manager.fileExists(atPath: baseUrl)
    if exist == false {
        print("文件不存在无需删除")
        return false
    }else {
        do {
            try manager.removeItem(atPath: baseUrl)
        } catch  {
            print("删除失败")
            return false
        }
        print("删除成功")
        return true
    }
}
func deleteAllFile(folderPath: String) -> Bool {
    let manager = FileManager.default
       let baseStr = NSHomeDirectory() + "/Documents/" + folderPath
       let exist = manager.fileExists(atPath: baseStr)
    if exist == false {
        print("文件夹就不存在,删除个屁")
        return false
    }
    if let files = manager.subpaths(atPath: baseStr), files.count > 0 {
        for file in files {
            do {
                try manager.removeItem(atPath: baseStr + "/\(file)")
            } catch {
                print("清理失败")
            }
        }
         return true
    }
    return false
}
func getTimeStamp() -> Int64 {
    let timeInterval: TimeInterval = Date().timeIntervalSince1970
    return Int64(round(timeInterval*1000))
}

func getStringRect(aString: NSAttributedString, width: CGFloat) -> CGFloat {
    let strSize = aString.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
    return ceil(strSize.height) + 1
}


func getAttring(aString: String, font: UIFont?, color: UIColor?, lineSpace: CGFloat = 0) -> NSMutableAttributedString {
    
    let mutableAttr = NSMutableAttributedString(string: aString)
    if font != nil {
        mutableAttr.addAttribute(NSAttributedString.Key.font, value: font!, range: NSRange(location: 0, length: mutableAttr.length))
    }
    if color != nil {
        mutableAttr.addAttribute(NSAttributedString.Key.foregroundColor, value: color!, range: NSRange(location: 0, length: mutableAttr.length))
    }
    if lineSpace > 0 {
         let paragraphStyle = NSMutableParagraphStyle()
         paragraphStyle.lineSpacing = lineSpace
        mutableAttr.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: mutableAttr.length))

    }
    return mutableAttr
    
}
//func getAttrString(aString: String, font: UIFont, color: UIColor, lineSpage: CGFloat = 0) -> NSAttributedString {
//    
//}

func getStringWidth(aString: NSAttributedString, height: CGFloat) -> CGFloat {
     let strSize = aString.boundingRect(with: CGSize(width: xm_screen_width - 40, height: height), options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
    return ceil(strSize.width) + 1
}

func timeToTimeStamp() -> Int64 {
    let timeInterval = Date().timeIntervalSince1970
    return Int64(timeInterval)    
}

func xmResponseDataFormatter(_ data: Data) -> String {
      do {
          let dataAsJSON = try JSONSerialization.jsonObject(with: data)
          let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
          return String(data: prettyData, encoding: .utf8) ?? String(data: data, encoding: .utf8) ?? ""
      } catch {
          return String(data: data, encoding: .utf8) ?? ""
      }
}

/// 次播放或者观看次数
 /// - Parameter count:
 /// - Returns:
func countOther(count: Int64) -> String {
     var playerCountStr = ""
     if count < 10000 {
         playerCountStr = " \(count)"
     }else if count > 10000 && count < 100000000 {
         playerCountStr = String(format: " %.2f万", CGFloat(count) / 10000)
     }else {
         playerCountStr = String(format: " %.2f亿", CGFloat(count) / 100000000)
     }
     return playerCountStr
 }

/// 第几个半颗星
/// - Parameter score: 评分
/// - Returns: 第几个半颗星
 func scoreStar(score: CGFloat) -> Int {
    switch score {
    case 0:
        return 0
    case 1..<2:
        return 1
    case 2..<4:
        return 2
    case 4..<6:
        return 3
    case 6..<8:
        return 4
    case 8..<10:
        return 5
    default:
        return 6
    }
}


enum XMCurrnetModel {
    case light
    case dark
    case unKnow
}
   
var currentModel: XMCurrnetModel {
    get {
        if #available(iOS 13.0, *) {
            if UITraitCollection.current.userInterfaceStyle == .dark {
                return .dark
            }else {
                return .light
               }
        } else {
               return .light
        }
    }
}

var _dfmatter: DateFormatter?
private var dfmatter: DateFormatter = {
    if _dfmatter == nil {
        _dfmatter = DateFormatter()
    }
    return _dfmatter!
}()


func timeStampToInt64(timeStamp: Int64) -> String {
    dfmatter.dateFormat = "MM-dd HH:ss"
    let time = timeStamp / 1000
    let date = Date(timeIntervalSince1970: TimeInterval(time))
    let dateString = dfmatter.string(from: date)
    return dateString
}

private var _regexAt: NSRegularExpression?
var regexAt: NSRegularExpression {
    if _regexAt == nil {
        _regexAt = try? NSRegularExpression(pattern:"@[-_a-zA-Z0-9\u{4E00}-\u{9FA5}]+", options: [])
    }
    return _regexAt!
}

private var _regexQuotationMark: NSRegularExpression?
var regexQuotationMark: NSRegularExpression {
    if _regexQuotationMark == nil {
        _regexQuotationMark = try? NSRegularExpression(pattern:"《[^@#]+?》", options: [])
    }
    return _regexQuotationMark!
}
private var _regexTopic: NSRegularExpression?
var regexTopic: NSRegularExpression {
    if _regexTopic == nil {
        _regexTopic = try? NSRegularExpression(pattern:"#[^@#]+?#", options: [])
    }
    return _regexTopic!
}

struct Const {
    
    static func getMMSSFromSS(totalTime: Int) -> String {
        if totalTime < 60 {
            return "0:\(60)"
        }else if totalTime > 60 && totalTime < 3600 {
            let m = (totalTime % 3600) / 60
            let s = totalTime % 60
            return "\(m):\(s)"
        }else {
            let h = totalTime / 3600
            let m = (totalTime % 3600) / 60
            let s = totalTime % 60
            return "\(h):\(m):\(s)"
        }
    }
    
    static func updateTimeToCurrennTime(timeStamp: Int64) -> String {
          //获取当前的时间戳
          let currentTime = Date().timeIntervalSince1970
          let timeSta:TimeInterval = TimeInterval(timeStamp / 1000)
          //时间差
          let reduceTime : TimeInterval = currentTime - timeSta
          //时间差小于60秒
          if reduceTime < 60 {
              return "刚刚"
          }
          //时间差大于一分钟小于60分钟内
          let mins = Int(reduceTime / 60)
          if mins < 60 {
              return "\(mins)分钟前"
          }
          let hours = Int(reduceTime / 3600)
          if hours < 24 {
              return "\(hours)小时前"
          }
          let days = Int(reduceTime / 3600 / 24)
          if days < 30 {
              return "\(days)天前"
          }
          //不满足上述条件---或者是未来日期-----直接返回日期
          let date = Date(timeIntervalSince1970: timeSta)
          //yyyy-MM-dd HH:mm:ss
          dfmatter.dateFormat="yyyy年MM月dd日 HH:mm:ss"
        return dfmatter.string(from: date)
      }
}


//    func setGifImage(imageView: XMAnimationView ,urlString: String?, placeHolderName: String?) {
//        
//        var placerImage: UIImage? = nil
//         if let holderName = placeHolderName {
//             placerImage = UIImage(named: holderName)
//         }
//        guard let urlStr = urlString else {
//            imageView.image = placerImage
//            return
//        }
//
//        guard let url = URL(string: urlStr) else {
//            imageView.image = placerImage
//            return
//        }
//
//        print(url)
//        
////        KingfisherManager.shared.cache.retrieveImage(forKey: urlString!) { (Result<ImageCacheResult, KingfisherError>) in
////            <#code#>
////        }
//        
//        KingfisherManager.shared.downloader.downloadImage(with: url, options: nil, progressBlock: nil) { result in
//            
//            switch result {
//            case .success( let imageResult):
//                let animation = XMAnimatedImage(animatedGIFData: imageResult.originalData)
//                imageView.animatedImage = animation
//                break
//            case .failure(_):
//                break
//            }
//        }
////        KingfisherManager.shared.retrieveImage(with: url) { (result) in
////            switch result {
////            case .success(let image):
////                
////                print("image.image竟然下载失败了\(image.image)---\(image.originalSource)")
////                
////                
////                switch image.originalSource {
////                case .provider(let dataP):
////                    dataP.data { (r) in
////                        switch r {
////                        case .success(let data):
////                            let animation = XMAnimatedImage(animatedGIFData: data)
////                            imageView.animatedImage = animation
////                            break
////                        case .failure(_):
////                            break
////                        }
////                    }
////                    break
////                default:
////                    break
////                }
////                break
////            case .failure(_):
////                break
////            }
////        }
//    }
