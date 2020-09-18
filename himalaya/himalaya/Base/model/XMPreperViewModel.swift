//
//  XMPreperViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift

class XMPreperViewModel {
    
    static private var disposable: Disposable?
    
    static func requestAds() {
        let request = XMPreloadAdRequest()
       disposable = xm_provider.rx.base_rx_request_model(target: BaseAPI(request: request), model: XMAdResponse<XMAdModel>.self, callbackQueue: DispatchQueue.global()).subscribe(onSuccess: { (result) in
        if result.ret == 0, let models = result.adModels {
            var urlStrings = [String]()
            for model in models {
                if let urls = model.videoUrls, urls.count > 0 {
                    for videoStr in urls {
                        if videoStr.hasSuffix("mp4") {
                            self.disposable?.dispose()
                            urlStrings.append(videoStr)
                        }
                    }
                }
            }
            if urlStrings.count > 0 {
                saveVideos(strings: urlStrings)
            }
        }
        }) { (error) in
            
        }
    }
    
    static func saveVideos(strings: [String]) {
        for urlStr in strings {
            let md5Str = urlStr.md5 + ".mp4"
            if judgeFileExist(fileName: md5Str, folderPath: "launchAdVideo") {
                continue
            }
            print("有新下载的吗")
            let request = XMDownLoadRequest(urlString: urlStr)
            request.fileName = md5Str
            request.folderPath = "launchAdVideo"
            var downLoadDisposable: Disposable?
            downLoadDisposable = xm_provider.rx.base_rx_request_files(target: BaseAPI(request: request), callbackQueue: DispatchQueue.global()).subscribe(onNext: { (progressResponse) in
            }, onError: { (error) in
                downLoadDisposable?.dispose()
            }, onCompleted: {
                downLoadDisposable?.dispose()
            })
        }
        
    }
}
