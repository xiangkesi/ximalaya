//
//  XMMineViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift
import ObjectMapper
import IGListKit

class XMMineViewModel {
    
    let disposeBag = DisposeBag()
    let requestMine = PublishSubject<Bool>()
    let requestMineMsg = PublishSubject<Bool>()
    
    lazy var layouts = [XMMineLayout]()
        
    init(adapter: ListAdapter) {
        creatData()
        let requestMsg = MineMsgRequest()
        self.requestMineMsg.flatMapLatest { (next) -> Single<MineMsgReponse<MineMsgScoreModel>> in
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: requestMsg), model: MineMsgReponse<MineMsgScoreModel>.self)
        }.subscribe(onNext: { (result) in
            if result.ret == 0 {
                if let layout = self.layouts.first {
                    layout.section?.userMsg = result
                    adapter.reloadData(completion: nil)
                }
            }
        }, onError: { (error) in
            
        }).disposed(by: self.disposeBag)
        
        let request = MineRequest()
        self.requestMine.flatMapLatest { (next) -> Single<MineReponse<MineSectionModel>> in
            if next == false { //fasle读取缓存,ture网络加载
                if let saveString = XMDataCache.shareCache.getString(mmkvSaveKey.xm_default_mine_function),
                    let result = Mapper<MineReponse<MineSectionModel>>().map(JSONString: saveString) {
                    return Single.just(result)
                }
            }
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: request), model: MineReponse<MineSectionModel>.self, callbackQueue: DispatchQueue.global())
        }.subscribe(onNext: {[weak self] (result) in
            if result.ret == 0 {
                if let array = result.array {
                    for section in array {
                        let layout = XMMineLayout(sectionModel: section)
                        self?.layouts.append(layout)
                    }
                }
                DispatchQueue.main.async {
                    adapter.performUpdates(animated: true, completion: nil)
                    if result.isNeedCache == false {
                        result.isNeedCache = true
                        if let saveString = result.toJSONString() {
                            XMDataCache.shareCache.set(saveString, mmkvSaveKey.xm_default_mine_function)
                        }
                    }
                }
            }
        }, onError: {(error) in
            print("错误信息是什么\(error)")
           
//                 DispatchQueue.main.async {
//                    if let saveString = XMDataCache.shareCache.getString(mmkvSaveKey.xm_default_mine_function),
//                                   let result = Mapper<MineReponse<MineSectionModel>>().map(JSONString: saveString) {
//                                  if let array = result.array {
//                                       self?.sections += array
//                    tableView.reloadData()
//                 }
//                }
//            }
        }).disposed(by: self.disposeBag)
        
    }
}

extension XMMineViewModel {
    
    private func creatData() {
        let jsonString =  "[{\"linkUrl\":\"\",\"id\":0,\"name\":\"我要录音\",\"icon\":\"me_ic_luyin\"},{\"name\":\"我要直播\",\"icon\":\"me_ic_live\",\"id\":0,\"linkUrl\":\"\"},{\"linkUrl\":\"\",\"id\":0,\"icon\":\"me_ic_zuopin\",\"name\":\"我的作品\"},{\"id\":0,\"icon\":\"me_ic_chuangzuozhongxin\",\"linkUrl\":\"\",\"name\":\"创作中心\"}]"
        let models = Array<MineModel>.init(JSONString: jsonString)
        var mineFunc = MineSectionModel()
        mineFunc.moduleName = "创作服务"
        mineFunc.moduleId = 10001
        mineFunc.models = models
        let layout = XMMineLayout(sectionModel: mineFunc)
        self.layouts.append(layout)
    }
}
