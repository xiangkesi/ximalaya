//
//  XMLaunchBanderView.swift
//  himalaya
//
//  Created by Farben on 2020/8/11.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class XMLaunchBanderView: UIView {

    private var imagePhotoView: UIImageView?
    
    private var buttonSkip: UIButton?
    
    private var topImageView: UIImageView?
    
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        var selfFrame = frame
        if selfFrame.size.width == 0 && selfFrame.size.height == 0 {
            selfFrame.size.width = xm_screen_width
            selfFrame.size.height = xm_screen_height
        }
        super.init(frame: selfFrame)
        
        let request = XMAdRequest()
        base_provider.rx.base_rx_request_model(target: BaseAPI(request: request), model: XMAdResponse<XMAdModel>.self, callbackQueue: DispatchQueue.global()).subscribe(onSuccess: { (result) in
            if result.ret == 0 {
                if let array = result.adModels, let model = array.last, let urlString = model.cover {
                    DispatchQueue.main.async {
                        self.imagePhotoView?.kf.setImage(with: URL(string: urlString), placeholder: nil, options: nil, progressBlock: nil, completionHandler: { (result) in
                                 switch result {
                                 case .success(_):
                                    self.creatTimer()
                                    self.topImageView?.isHidden = true
                                     break
                                 default:
                                    self.removeFromSuperview()
                                     break
                                 }
                             })
                    }
                }
            }
        }) { (error) in
            self.removeFromSuperview()
        }.disposed(by: disposeBag)
        
        imagePhotoView = UIImageView()
        imagePhotoView?.frame = bounds
        imagePhotoView?.contentMode = .scaleAspectFill
        addSubview(imagePhotoView!)
        
        buttonSkip = UIButton(type: UIButton.ButtonType.custom)
        buttonSkip?.xm_size = CGSize(width: 80, height: 30)
        buttonSkip?.xm_origin = CGPoint(x: xm_width - 100, y: UIDevice.navigationBarHeight)
        buttonSkip?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        buttonSkip?.backgroundColor = UIColor.colorWidthHexString(hex: "F0F0F0")
        buttonSkip?.setTitleColor(UIColor.colorWidthHexString(hex: "333333"), for: UIControl.State.normal)
        buttonSkip?.setTitle("点击跳过5", for: UIControl.State.normal)
        buttonSkip?.layer.cornerRadius = 5
        buttonSkip?.rx.tap.subscribe(onNext: {[weak self] in
            self?.disposable?.dispose()
            self?.removeFromSuperview()
        }).disposed(by: disposeBag)
        addSubview(buttonSkip!)
        
        topImageView = UIImageView()
        topImageView?.contentMode = .scaleToFill
        topImageView?.frame = bounds
        topImageView?.image = UIImage(named: "LaunchImage-700-568h")
        addSubview(topImageView!)
        
        let imageTop = UIImageView()
        imageTop.image = UIImage(named: "launchLogoTop")
        topImageView?.addSubview(imageTop)
        imageTop.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(imageTop.snp.width).dividedBy(0.822)
        }
        let bottomView = UIImageView()
        bottomView.image = UIImage(named: "launchLogo1")
        topImageView?.addSubview(bottomView)
        bottomView.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
            make.height.equalTo(bottomView.snp.width).dividedBy(8.5)
        })
    }
    
    
    private var disposable: Disposable?
    private func creatTimer() {
        let secondTime: Int = 4
        let obserVable = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        disposable = obserVable.take(5).map{secondTime - $0}.map{"点击跳过\($0)"}.subscribe(onNext: { (text) in
            self.buttonSkip?.setTitle(text, for: UIControl.State.normal)
        }, onCompleted: {
            self.removeFromSuperview()
        })
    }
    
    deinit {
        print("广告位销毁了吗")
    }
    
    
    class func show(fatnerView: UIView) {
        
        
        let banderView = XMLaunchBanderView()
        fatnerView.addSubview(banderView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

