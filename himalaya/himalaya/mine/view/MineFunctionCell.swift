//
//  MineFunctionCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift

enum MineHeadActionType {
    case actionHeadView //点击头像
    case actionUserName //点击用户名
    case actionFances//点击粉丝
    case actionNotoce//点击关注
    case actionScore//点击福利积分
    case actionVip //点击VIP会员
    case actionLive // 点击直播
    case actionPublish //点击我的作品
    case actionCreation //点击创作中心
    case actionRecording//点击我要录音
    case actionCreationActive //点击创作活动
    case actionBuyOneGetShiSan//买1得13
    case actionDaKaLive//大咖直播
    case actionGetFuli//领福利
    case actionVipFans//VIP宠粉圈
    
}


class MineHeadBottomView: UIView {
    
    var imageBottomView: UIImageView?
    var labelBottomLabel: UILabel?
    
    private var labelTopTitle: UILabel?
    private let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        var selfFrame = CGRect.zero
        if frame.size.width == 0 && frame.size.height == 0 {
            selfFrame.size.width = content_view_width
            selfFrame.size.height = floor(selfFrame.size.width * 0.25 + 95)
        }
        super.init(frame: selfFrame)
        initWithSubViews()
       
    }
    
    
    private func initWithSubViews() {
        backgroundColor = UIColor.xm.xm_255_30_color
        layer.cornerRadius = 5
        layer.masksToBounds = false
        let dics:[(String, String, MineHeadActionType)] = [("我要录音", "me_ic_luyin", .actionRecording),
                                                           ("我要直播", "me_ic_live", .actionLive),
                                                           ("我的作品", "me_ic_zuopin", .actionPublish),
                                                           ("创作中心", "me_ic_chuangzuozhongxin", .actionCreation)]
        
        labelTopTitle = UILabel()
        labelTopTitle?.font = UIFont.boldSystemFont(ofSize: 16)
        labelTopTitle?.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200))
        labelTopTitle?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        labelTopTitle?.xm_size = CGSize(width: content_view_width, height: 30)
        labelTopTitle?.text = "创作服务"
        addSubview(labelTopTitle!)
        
        let top = labelTopTitle!.xm_bottom
        
        var lastBtn: MineFuncCellView?
        for dic in dics {
            let btnWH = ceil(xm_width * 0.25)
            let btn = MineFuncCellView()
            btn.xm_size = CGSize(width: btnWH, height: btnWH)
            btn.xm_origin = CGPoint(x: lastBtn == nil ? 0 : lastBtn!.xm_right, y: top)
            btn.imageView?.image = UIImage(named: dic.1)
            btn.labelTitle?.text = dic.0
            let tap = UITapGestureRecognizer()
            btn.addGestureRecognizer(tap)
//            tap.rx.event.subscribe(onNext: {[weak self] (tap) in
//            }).disposed(by: disposeBag)
            addSubview(btn)
            lastBtn = btn
        }
        
        let bottomView = UIView()
        bottomView.xm_size = CGSize(width: xm_width, height: 50)
        bottomView.xm_origin = CGPoint(x: 0, y: xm_height - bottomView.xm_height)
        bottomView.drawDashLine(strokeColor: UIColor.colorWithrgba(45, 45, 45), lineWidth: 0.5, lineLength: 10, lineSpacing: 5, isBottom: false)
        let tap = UITapGestureRecognizer()
//        tap.rx.event.subscribe(onNext: {[weak self] (tap) in
//        }).disposed(by: disposeBag)
        bottomView.addGestureRecognizer(tap)
        
        addSubview(bottomView)
        
        let imageArrowView = UIImageView()
        imageArrowView.xm_size = CGSize(width: 9, height: 16)
        imageArrowView.xm_y = ceil((bottomView.xm_height - imageArrowView.xm_height) * 0.5)
        imageArrowView.xm_x = bottomView.xm_width - imageArrowView.xm_width - 15
        imageArrowView.image = UIImage(named: "ad_arrow_right")
        bottomView.addSubview(imageArrowView)
        
        imageBottomView = UIImageView()
        imageBottomView?.xm_origin = CGPoint(x: 15, y: 17)
        imageBottomView?.xm_height = 16
        imageBottomView?.xm_width = ceil(imageBottomView!.xm_height * 4.077)
        bottomView.addSubview(imageBottomView!)
              
        labelBottomLabel = UILabel()
        labelBottomLabel?.font = UIFont.systemFont(ofSize: 12)
        labelBottomLabel?.textColor = UIColor.colorWidthHexString(hex: "999999")
        labelBottomLabel?.xm_width = bottomView.xm_width - imageBottomView!.xm_right - 50
        labelBottomLabel?.xm_height = 20
        labelBottomLabel?.xm_x = imageBottomView!.xm_right + 15
        labelBottomLabel?.xm_y = 15
        bottomView.addSubview(labelBottomLabel!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class MineFuncCellView: UIView {
    
    var imageView: UIImageView?
    var labelTitle: UILabel?
    
    var model: MineModel? {
        didSet {
            labelTitle?.text = model?.name
            imageView?.setImage(urlString: model?.icon, placeHolderName: "image_choice_girl_1")
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        addSubview(imageView!)
               
        labelTitle = UILabel()
        labelTitle?.font = UIFont.systemFont(ofSize: 13)
        labelTitle?.textAlignment = .center
        labelTitle?.textColor = UIColor.xm.dynamicRGB((150, 150, 150), (200, 200, 200))
        addSubview(labelTitle!)
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          
          let imageViewWH: CGFloat = ceil(xm_width - xm_width * 0.6)
          let labelTitleH: CGFloat = 20
          let spading: CGFloat = 5
          
          imageView?.xm_size = CGSize(width: imageViewWH, height: imageViewWH)
          labelTitle?.xm_size = CGSize(width: xm_width, height: labelTitleH)
          
          let imageViewX = ceil((xm_width - imageViewWH) * 0.5)
          let imageViewY = ceil((xm_height - imageViewWH - labelTitleH - spading) * 0.5)
          
          
          imageView?.xm_origin = CGPoint(x: imageViewX, y: imageViewY)
          labelTitle?.xm_origin = CGPoint(x: 0, y: imageView!.xm_bottom + spading)
      }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
