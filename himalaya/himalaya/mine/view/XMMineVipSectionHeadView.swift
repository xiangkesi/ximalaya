//
//  XMMineVipSectionHeadView.swift
//  himalaya
//
//  Created by Farben on 2020/8/28.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMMineHeadView: UICollectionReusableView {
    
    private var headView: UIImageView?
    private var btnUserName: UIButton?
    private var typeImageView: UIImageView?
    private var btnFances: UIButton?
    private var btnNotice: UIButton?
    private var btnScore: UIButton?
    
    private var btnVip: UIButton?
    
    var userMsg: MineMsgReponse<MineMsgScoreModel>? {
        didSet {
            if let user = userMsg {
                 btnUserName?.setTitle(user.nickname, for: UIControl.State.normal)
                headView?.setImage(urlString: user.mobileSmallLogo, placeHolderName: "recommendfriend_default_head")
                btnScore?.setTitle(user.checkInRemindInfo?.checkInReminder, for: UIControl.State.normal)
//                bottomView?.imageBottomView?.setImage(urlString: user.bannerActivityResult?.imgUrl, placeHolderName: nil)
//                bottomView?.labelBottomLabel?.text = user.bannerActivityResult?.text
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headView = UIImageView()
        headView?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        headView?.xm_size = CGSize(width: 60, height: 60)
        headView?.addRoundingCorner(corners: .allCorners, size: CGSize(width: 30, height: 30))
        headView?.image = UIImage(named: "recommendfriend_default_head")
        headView?.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer()
//        headView?.addGestureRecognizer(tap)
//        tap.rx.event.subscribe(onNext: {[weak self] (tap) in
//            self?.clickAction.onNext(.actionHeadView)
//        }).disposed(by: disposeBag)
        addSubview(headView!)
        
        btnUserName = UIButton(type: UIButton.ButtonType.custom)
        btnUserName?.xm_size = CGSize(width: xm_width - headView!.xm_width - 100 - 15, height: 25)
        btnUserName?.xm_origin = CGPoint(x: headView!.xm_right + xm_padding, y: headView!.xm_y + 5)
        btnUserName?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnUserName?.setTitleColor(UIColor.xm.dynamicRGB((30, 30, 30), (220, 220, 220)), for: UIControl.State.normal)
//        btnUserName?.setTitle("能不能给我一首歌的时间", for: UIControl.State.normal)
        btnUserName?.contentHorizontalAlignment = .left
//        btnUserName?.rx.tap.subscribe(onNext: { [weak self] in
//            self?.clickAction.onNext(.actionUserName)
//        }).disposed(by: disposeBag)
        addSubview(btnUserName!)
        
        btnFances = UIButton(type: UIButton.ButtonType.custom)
        btnFances?.xm_size = CGSize(width: 60, height: 25)
        btnFances?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btnFances?.setTitleColor(UIColor.colorWidthHexString(hex: "999999"), for: UIControl.State.normal)
        btnFances?.xm_origin = CGPoint(x: btnUserName!.xm_x, y: btnUserName!.xm_bottom)
        btnFances?.contentHorizontalAlignment = .left
        btnFances?.setTitle("粉丝 123", for: UIControl.State.normal)
        btnFances?.adjustsImageWhenHighlighted = false
//        btnFances?.rx.tap.subscribe(onNext: { [weak self] in
//            self?.clickAction.onNext(.actionFances)
//            }).disposed(by: disposeBag)
        addSubview(btnFances!)
        
        let line = CALayer()
        line.xm_size = CGSize(width: 1, height: 10)
        line.xm_origin = CGPoint(x: btnFances!.xm_width - 1, y: 7)
        line.backgroundColor = UIColor.colorWidthHexString(hex: "999999").cgColor
        btnFances?.layer.addSublayer(line)
        
        btnNotice = UIButton(type: UIButton.ButtonType.custom)
        btnNotice?.xm_size = btnFances!.xm_size
        btnNotice?.xm_origin = CGPoint(x: btnFances!.xm_right, y: btnFances!.xm_y)
        btnNotice?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btnNotice?.setTitleColor(UIColor.colorWidthHexString(hex: "999999"), for: UIControl.State.normal)
        btnNotice?.contentHorizontalAlignment = .right
        btnNotice?.setTitle("粉丝 123", for: UIControl.State.normal)
        btnNotice?.adjustsImageWhenHighlighted = false
//        btnNotice?.rx.tap.subscribe(onNext: { [weak self] in
//            self?.clickAction.onNext(.actionNotoce)
//            }).disposed(by: disposeBag)
        addSubview(btnNotice!)
        
        btnScore = UIButton(type: UIButton.ButtonType.custom)
        btnScore?.xm_size = CGSize(width: 100, height: 40)
        btnScore?.xm_x = xm_width - btnScore!.xm_width
        btnScore?.xm_centerY = headView!.xm_centerY
        btnScore?.backgroundColor = UIColor.xm.dynamicRGB((255, 255, 255), (30, 30, 30))
        btnScore?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        btnScore?.setTitleColor(UIColor.colorWidthHexString(hex: "666666"), for: UIControl.State.normal)
        btnScore?.addRoundingCorner(corners: [UIRectCorner.topLeft, UIRectCorner.bottomLeft], size: CGSize(width: 15, height: 15), boborderWidth: 1, borderColor: "999999")
        btnScore?.setTitle("积分福利", for: UIControl.State.normal)
        btnScore?.setImage(UIImage(named: "toast_coin_2"), for: UIControl.State.normal)
//        btnScore?.rx.tap.subscribe(onNext: { [weak self] in
//            self?.clickAction.onNext(.actionScore)
//        }).disposed(by: disposeBag)
        addSubview(btnScore!)
        
        btnVip = UIButton(type: UIButton.ButtonType.custom)
        btnVip?.xm_origin = CGPoint(x: headView!.xm_x, y: headView!.xm_bottom + xm_padding)
        btnVip?.xm_size = CGSize(width: xm_width - xm_padding * 2, height: ceil((xm_width - xm_padding * 2) * 0.12754))
        btnVip?.setBackgroundImage(UIImage(named: "vipEntrance"), for: UIControl.State.normal)
//        btnVip?.rx.tap.subscribe(onNext: { [weak self] in
//            self?.clickAction.onNext(.actionVip)
//        }).disposed(by: disposeBag)
        addSubview(btnVip!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMMineHeadViewCell: UICollectionViewCell {
    
    private var bottomView: MineHeadBottomView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        bottomView = MineHeadBottomView()
        bottomView?.xm_origin = CGPoint(x: 0, y: 0)
        contentView.addSubview(bottomView!)
    }
    
    var userMsg: MineMsgReponse<MineMsgScoreModel>? {
        didSet {
            if let user = userMsg {
                bottomView?.imageBottomView?.setImage(urlString: user.bannerActivityResult?.imgUrl, placeHolderName: nil)
                bottomView?.labelBottomLabel?.text = user.bannerActivityResult?.text
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class XMMineVipSectionHeadView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(labelTitle)
    }
    
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (210, 210, 210))
        label.xm_x = xm_padding * 2
        label.xm_y = 10
        label.xm_width = 200
        label.xm_height = xm_height - 10
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMMineSectionCell: UICollectionViewCell {
    
    
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
        labelTitle?.textColor = UIColor.xm.dynamicRGB((45, 45, 45), (120, 120, 120))
        addSubview(labelTitle!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageViewWH: CGFloat = ceil(contentView.xm_width - contentView.xm_width * 0.6)
        let labelTitleH: CGFloat = 20
        let spading: CGFloat = 5
        
        imageView?.xm_size = CGSize(width: imageViewWH, height: imageViewWH)
        labelTitle?.xm_size = CGSize(width: contentView.xm_width, height: labelTitleH)
        
        let imageViewX = ceil((contentView.xm_width - imageViewWH) * 0.5)
        let imageViewY = ceil((contentView.xm_height - imageViewWH - labelTitleH - spading) * 0.5)
        
        
        imageView?.xm_origin = CGPoint(x: imageViewX, y: imageViewY)
        labelTitle?.xm_origin = CGPoint(x: 0, y: imageView!.xm_bottom + spading)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
