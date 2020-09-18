//
//  ZSLoadingView.swift
//  gokarting
//
//  Created by Farben on 2020/7/24.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit


class XMLoadingView: UIView {
    
    enum LoadingType {
        case loading
        case noData
        case netError
        case text
        case unknow
    }
    private var clickLoad: (() -> ())?
    
    private var loadingType: LoadingType = .unknow
    private var animatedImageView: UIImageView?
    private var labelTitle: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.xm.xm_255_30_color
        isUserInteractionEnabled = false
        animatedImageView = UIImageView()
        animatedImageView?.contentMode = .scaleAspectFit
        animatedImageView?.animationDuration = 1
        animatedImageView?.animationRepeatCount = 100000
        addSubview(animatedImageView!)
        
        labelTitle = UILabel()
        labelTitle?.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (210, 210, 210))
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 16)
        labelTitle?.xm_size = CGSize(width: 200, height: 30)
        labelTitle?.textAlignment = .center
        labelTitle?.text = "网络连接错误, 点击重试"
        labelTitle?.isHidden = true
        addSubview(labelTitle!)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(actionClick))
        addGestureRecognizer(tap)
        
    }
    
    @objc func actionClick() {
        if loadingType == LoadingType.netError {
            loadingType = LoadingType.loading
            XMLoadingView.startAnimation(self)
            
            if clickLoad != nil {
                clickLoad!()
            }
        }
    }
    
    class func showLoadingView(view: UIView?, loadingType: LoadingType) -> XMLoadingView? {
        if view == nil {
            return nil
        }
        let loadingView = XMLoadingView()
        loadingView.frame = view!.bounds
        loadingView.loadingType = loadingType
        view?.addSubview(loadingView)
//        switch loadingType {
//        case .loading:
//            startAnimation(loadingView)
//        case .noData:
//            noMoreData(loadingView)
//        case .netError:
//            netError(loadingView)
//        default:
//            break
//        }
        return loadingView
        
    }
    
    class func startAnimation(_ loadingView: XMLoadingView?) {
        guard let l_view = loadingView else {
            return
        }
        l_view.loadingType = LoadingType.loading
        l_view.isUserInteractionEnabled = false
        l_view.labelTitle?.isHidden = true
        l_view.animatedImageView?.xm_size = CGSize(width: 30, height: 30)
        l_view.animatedImageView?.xm_centerX = l_view.xm_centerX
        l_view.animatedImageView?.xm_centerY = l_view.xm_centerY - 150
        l_view.animatedImageView?.animationImages = l_view.images
        l_view.animatedImageView?.startAnimating()
    }
    
    class func noMoreData(_ loadingView: XMLoadingView?) {
        guard let l_view = loadingView else {
            return
        }
        l_view.loadingType = LoadingType.noData
        l_view.isUserInteractionEnabled = false
        l_view.labelTitle?.isHidden = true
        if let image = UIImage(named: "noSearchData") {
            let imageSize = image.size
            l_view.animatedImageView?.xm_size = imageSize
            l_view.animatedImageView?.xm_centerX = l_view.xm_centerX
            l_view.animatedImageView?.xm_centerY = l_view.xm_centerY - xm_navgationheight - 100
            l_view.animatedImageView?.image = image
        }
        
    }
    
    class func netError(_ loadingView: XMLoadingView?, click: (()->())? = nil) {
        guard let l_view = loadingView else {
            return
        }
        l_view.clickLoad = click
        l_view.stopAnimation()
        l_view.loadingType = LoadingType.netError
        l_view.isUserInteractionEnabled = true
        if let image = UIImage(named: "rec_pic_netwrong") {
            let imageSize = image.size
            l_view.animatedImageView?.xm_size = imageSize
            l_view.animatedImageView?.xm_centerX = l_view.xm_centerX
            l_view.animatedImageView?.xm_centerY = l_view.xm_centerY - xm_navgationheight - 100
            l_view.animatedImageView?.image = image
        }
        l_view.labelTitle?.isHidden = false
        l_view.labelTitle?.xm_centerX = l_view.xm_centerX
        l_view.labelTitle?.xm_y = l_view.animatedImageView!.xm_bottom
    }
    
    private func stopAnimation() {
        animatedImageView?.stopAnimating()
        animatedImageView?.animationImages = nil
    }
    
    var isAnimationImage: Bool = false {
        didSet {
            if isAnimationImage == true {
                animatedImageView?.animationImages = images
            }else {
                animatedImageView?.stopAnimating()
                animatedImageView?.animationImages = nil
            }
        }
    }
    
    private lazy var images: [UIImage] = {
        var loadingArrayImage = [UIImage]()
        for index in 2..<20 {
            let imageName = "host_play_flag_wave_" + String(index)
            if let image = UIImage(named: imageName) {
                loadingArrayImage.append(image)
            }
        }
        return loadingArrayImage
    }()
    
    override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow != nil {
            if loadingType == LoadingType.loading && animatedImageView?.isAnimating == false {
                animatedImageView?.startAnimating()
            }
        }
    }
    
    deinit {
        print("消失了")
    }
    
    static func disMiss(loadingView: inout XMLoadingView?) {
        if loadingView != nil {
            if loadingView?.animatedImageView?.isAnimating == true {
                loadingView?.animatedImageView?.stopAnimating()
            }
            loadingView?.removeFromSuperview()
            loadingView = nil
            
        }
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
