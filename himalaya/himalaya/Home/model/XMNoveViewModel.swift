//
//  XMNoveViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/8/26.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation
import RxSwift
import IGListKit

class XMNoveViewModel {
    
    let requestNoveList = PublishSubject<Bool>()
    
    private lazy var request = XMNoveRequest()
    weak var adapter: ListAdapter?
    let disposeBag = DisposeBag()
    lazy var layouts = [XMNoveLayout]()
    private var loadingView: XMLoadingView?
    init(adapter: ListAdapter) {
        self.adapter = adapter
        
        loadingView = XMLoadingView.showLoadingView(view: adapter.viewController?.view, loadingType: XMLoadingView.LoadingType.loading)
        requestNoveList.flatMapLatest {[weak self] (next) -> Single<XMNoveResponse<XMNoveCategoryContentModel>> in
            XMLoadingView.startAnimation(self?.loadingView)
            self?.request.isHomepage = next
            return base_provider.rx.base_rx_request_model(target: BaseAPI(request: (self?.request)!), model: XMNoveResponse<XMNoveCategoryContentModel>.self, callbackQueue: DispatchQueue.global())
        }.subscribe(onNext: {[weak self] (result) in
            if result.ret == 0 {
                if self?.request.isHomepage == true {
                    self?.layouts.removeAll()
                }
                if let fouceImages = result.fousImage?.focusImageDatas, fouceImages.count > 0, self?.request.isHomepage == true {
                    let layout = XMNoveLayout(fousImage: result.fousImage!)
                    self?.layouts.append(layout)
                }
                if let categoryContent = result.model?.lists, categoryContent.count > 0 {
                    if self?.request.isHomepage == false {
                        if let albums = categoryContent.first?.lists, albums.count > 0 {
                            for album in albums {
                                let layout = XMNoveLayout(album: album)
                                self?.layouts.append(layout)
                            }
                            if categoryContent.first!.offset > 0 {
                                self?.request.offset = categoryContent.first!.offset
                            }
                        }
                    }else{
                        for model in categoryContent {
                            let layout = XMNoveLayout(categoryContents: model)
                            self?.layouts.append(layout)
                            if model.offset > 0 {
                                self?.request.offset = model.offset
                            }
                        }
                    }
               }
                DispatchQueue.main.async {
                    XMLoadingView.disMiss(loadingView: &(self!.loadingView))
                    self?.adapter?.performUpdates(animated: true, completion: { (finish) in
                        if self?.request.isHomepage == true {
                            self?.adapter?.collectionView?.refresh_status = .DropDownSuccess
                        }else {
                            self?.adapter?.collectionView?.refresh_status = .PullSuccessHasMoreData
                        }
                        
                    })
                }
            }
        }, onError: { (error) in
            
        }).disposed(by: disposeBag)
    }
}
