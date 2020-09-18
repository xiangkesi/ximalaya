//
//  UIImageViewExtension.swift
//  gokarting
//
//  Created by Farben on 2020/7/28.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import KingfisherWebP
import Kingfisher

extension UIImageView {
    
    
    
    func setWebpImage(urlString: String?, placeHolderName: String?) {
        guard let urlStr = urlString else {
            return
        }
        guard let url = URL(string: urlStr) else {
            return
        }
        var placerImage: UIImage? = nil
        if let holderName = placeHolderName {
            placerImage = UIImage(named: holderName)
        }
        kf.setImage(with: url, placeholder: placerImage, options: [KingfisherOptionsInfoItem.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)])
        
    }
    
    
    func setGifImage() {
        
    }
//    RectCorner
    func setWebpRoundImage(urlString: String?,
                           placeHolderName: String?,
                           corner: CGFloat = 5,
                           rectCorner: UIRectCorner = .allCorners,
                           borderColor: UIColor = UIColor.white,
                           borderWidth: CGFloat = 0) {
        guard let urlStr = urlString else {
            return
        }
        guard let url = URL(string: urlStr) else {
            return
        }
        var placerImage: UIImage? = nil
        if let holderName = placeHolderName {
            placerImage = UIImage(named: holderName)
        }
        let md5String = urlString!.md5
        self.image = placerImage
        self.readCacheImage(url: url,
                            keyString: md5String,
                            corner: corner,
                            rectCorner: rectCorner)
        

        
//        kf.setImage(with: url, placeholder: placerImage, options: [.processor(WebPProcessor.default), .cacheSerializer(WebPSerializer.default)])
//        kf.setImage(with: url, placeholder: placerImage, options: [.processor(WebPProcessor.default)], progressBlock: nil) { (result) in
//            switch result {
//            case .success(let image):
//                let a = image.image
//                print("每次都运行吗\(a)")
//
//                break
//            case .failure(_):
//                break
//            }
//        }
    
    }
    
    func readCacheImage(url: URL,
                        keyString: String,
                        corner: CGFloat = 5,
                        rectCorner: UIRectCorner = .allCorners,
                        borderColor: UIColor = UIColor.white,
                        borderWidth: CGFloat = 0) {
//        diskStorage.config.sizeLimit
        
    
        ImageCache.default.retrieveImage(forKey: keyString) { (result) in
                   switch result {
                   case .success(let caceImage):
                       switch caceImage {
                       case .none:
                        self.downImage(url: url,
                                       keyString: keyString,
                                       corner: corner,
                                       rectCorner: rectCorner,
                                       borderColor: borderColor,
                                       borderWidth: borderWidth)
                           break
                       default:
                           self.image = caceImage.image
                           break
                       }
                       break
                   case .failure(let error):
                       print("出错了\(error)")
                       break
                   }
               }
    }
    
    func downImage(url: URL,
                   keyString: String,
                   corner: CGFloat = 5,
                   rectCorner: UIRectCorner = .allCorners,
                   borderColor: UIColor = UIColor.white,
                   borderWidth: CGFloat = 0) {
        ImageDownloader.default.downloadTimeout = 5
        ImageDownloader.default.downloadImage(with: url, options: [.processor(WebPProcessor.default)], progressBlock: nil) { (result) in
                   switch result {
                   case .success(let imageLoading):
                    DispatchQueue.global().async {
                        let image = imageLoading.image.imageByAddingCornerRadius(corner: corner, rectCorner: rectCorner, borderColor: borderColor, boderWidth: 0)
                         ImageCache.default.store(image, forKey: keyString)
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    }
                    break
                   case .failure(_):
                    print("下载失败了")
                       break
                   }
               }
    }
    
    func setImage(urlString: String?, placeHolderName: String?) {
            var placerImage: UIImage? = nil
            if let holderName = placeHolderName {
                placerImage = UIImage(named: holderName)
            }
           guard let urlStr = urlString else {
                image = placerImage
               return
           }
           guard let url = URL(string: urlStr) else {
                image = placerImage
               return
           }
           kf.setImage(with: url, placeholder: placerImage)
    }
    
    func cancelRequest() {
        kf.cancelDownloadTask()
    }
    
    func setImageRoundCorner(urlString: String?, placeHolderName: String?, corner: CGFloat = 5, rectCorner: RectCorner = .all) {
        var placerImage: UIImage? = nil
        if let holderName = placeHolderName {
            placerImage = UIImage(named: holderName)
        }
        guard let urlStr = urlString else {
             image = placerImage
            return
        }
        guard let url = URL(string: urlStr) else {
             image = placerImage
            return
        }
        kf.setImage(with: url, placeholder: placerImage, options: [.processor(RoundCornerImageProcessor(cornerRadius: corner)), .targetCache(ImageCache.default)])
    }
}
