//
//  XMHomeTopCell.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/13.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMHomeTopSetView: XMCommonView {
    
    var imageView: UIImageView?
    var labelDesc: UILabel?
    var btnSet: UIButton?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = CGRect(x: 10, y: 5, width: xm_height - 10, height: xm_height - 10)
        btnSet?.xm_origin = CGPoint(x: xm_width - btnSet!.xm_width - 10, y: 10)
        labelDesc?.frame = CGRect(x: imageView!.xm_right + 10, y: 10, width: btnSet!.xm_x - labelDesc!.xm_x, height: 30)
        
        
    }
    override func initWithSubViews() {
        super.initWithSubViews()
        
        imageView = UIImageView()
        imageView?.image = UIImage(named: "xm_sleep_tixing")
        addSubview(imageView!)
        
        btnSet = UIButton(type: UIButton.ButtonType.custom)
        btnSet?.xm_size = CGSize(width: 80, height: 30)
        btnSet?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btnSet?.setTitle("未设置", for: UIControl.State.normal)
        btnSet?.contentHorizontalAlignment = .right
        btnSet?.setImage(UIImage(named: "xm_sleep_zhankai"), for: UIControl.State.normal)
        btnSet?.setTitleColor(UIColor.black, for: UIControl.State.normal)
        btnSet?.zs_setImagePositionType(type: ImagePositionType.right, spacing: 2)
        addSubview(btnSet!)
        
        labelDesc = UILabel()
        labelDesc?.text = "喜马拉雅提醒你入睡了"
        labelDesc?.textColor = UIColor.black
        labelDesc?.font = UIFont.systemFont(ofSize: 14)
        labelDesc?.textAlignment = .left
        addSubview(labelDesc!)
        
    }
}

class XMHomeTopHistoryView: XMCommonView {
    
    var viewLeft: UIView?
    var btnRight: UIButton?
    var imageView: UIImageView?
    
    var labelMore: UILabel?
    var imageArrowView: UIImageView?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        viewLeft?.xm_origin = CGPoint(x: 0, y: 0)
        viewLeft?.xm_size = CGSize(width: ceil(xm_width * 0.65), height: xm_height)
        
        imageView?.xm_origin = CGPoint(x: 0, y: 0)
        imageView?.xm_size = CGSize(width: xm_height, height: xm_height)
        
        labelMore?.xm_origin = CGPoint(x: imageView!.xm_right + 10, y: 0)
        labelMore?.xm_size = CGSize(width: xm_width - labelMore!.xm_x - 40, height: xm_height)
        
        imageArrowView?.xm_size = CGSize(width: 16, height: 16)
        imageArrowView?.xm_origin = CGPoint(x: viewLeft!.xm_width - imageArrowView!.xm_width - 10, y: ceil((viewLeft!.xm_height - imageArrowView!.xm_height) * 0.5))
        
        btnRight?.xm_origin = CGPoint(x: viewLeft!.xm_right + 20, y: viewLeft!.xm_y)
        btnRight?.xm_size = CGSize(width: xm_width - btnRight!.xm_x, height: xm_height)
        
    }
    
    override func initWithSubViews() {
        super.initWithSubViews()
        
        viewLeft = UIView()
        viewLeft?.backgroundColor = UIColor.colorWithrgba(72, 84, 131)
        viewLeft?.layer.cornerRadius = 5
        addSubview(viewLeft!)
        
        imageView = UIImageView()
        imageView?.layer.cornerRadius = 5
        imageView?.layer.masksToBounds = true
        imageView?.image = UIImage(named: "find_vip_aggregate_bkg_iphone")
        viewLeft?.addSubview(imageView!)
        
        labelMore = UILabel()
        labelMore?.font = UIFont.systemFont(ofSize: 15)
        labelMore?.textColor = UIColor.white
        labelMore?.text = "更多历史"
        viewLeft?.addSubview(labelMore!)
        
        imageArrowView = UIImageView()
        imageArrowView?.image = UIImage(named: "xm_sleep_history_arrow")
        viewLeft?.addSubview(imageArrowView!)
        
        btnRight = UIButton(type: UIButton.ButtonType.custom)
        btnRight?.backgroundColor = UIColor.colorWithrgba(150, 90, 90)
        btnRight?.layer.cornerRadius = 5
        btnRight?.setImage(UIImage(named: "xm_sleep_hert"), for: UIControl.State.normal)
        btnRight?.setTitle("  喜欢", for: UIControl.State.normal)
        btnRight?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btnRight?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        addSubview(btnRight!)
        
    }
}

class XMHomeTopCell: XMCommonCollectionViewCell {
    
    var labelTitle: UILabel?
    var btnCommon: UIButton?
    var labelDetail: UILabel?
    var viewSetBg: XMHomeTopSetView?
    
    var hitoryView: XMHomeTopHistoryView?
    

    override func initWithSubViews() {
        super.initWithSubViews()
        labelTitle = UILabel()
        labelTitle?.font = UIFont(name: "Helvetica-Bold", size: 23)
        labelTitle?.xm_origin = CGPoint(x: 30, y: 100)
        labelTitle?.xm_size = CGSize(width: contentView.xm_width - 60, height: 30)
        labelTitle?.textColor = UIColor.white
        labelTitle?.text = "王力宏_刘德华"
        labelTitle?.sizeToFit()
        labelTitle?.xm_height = 30
        contentView.addSubview(labelTitle!)
        
        btnCommon = UIButton(type: UIButton.ButtonType.custom)
        btnCommon?.xm_size = CGSize(width: 20, height: 20)
//        btnCommon?.xm_origin = CGPoint(x: labelTitle!.xm_right + xm_padding, y: labelTitle!.xm_y + 6)
        btnCommon?.xm_x = labelTitle!.xm_right + xm_padding
        btnCommon?.xm_centerY = labelTitle!.xm_centerY
        btnCommon?.setImage(UIImage(named: "xm_sleep_message"), for: UIControl.State.normal)
        contentView.addSubview(btnCommon!)
        
        viewSetBg = XMHomeTopSetView()
        viewSetBg?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: labelTitle!.xm_bottom + 50)
        viewSetBg?.xm_size = CGSize(width: contentView.xm_width - 60, height: 50)
        viewSetBg?.backgroundColor = UIColor(white: 0.8, alpha: 0.5)
        viewSetBg?.layer.cornerRadius = 5
        contentView.addSubview(viewSetBg!)
        
        
        hitoryView = XMHomeTopHistoryView()
        contentView.addSubview(hitoryView!)
        hitoryView?.xm_origin = CGPoint(x: viewSetBg!.xm_x, y: viewSetBg!.xm_bottom + 50)
        hitoryView?.xm_size = CGSize(width: viewSetBg!.xm_width, height: 60)
    }
}

class XMSleepTitleCell: XMCommonCollectionViewCell {
    
    var labelTitle: UILabel?
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        labelTitle = UILabel()
        labelTitle?.backgroundColor = UIColor.colorWithrgba(13, 15, 25)
        labelTitle?.layer.cornerRadius = 15
        labelTitle?.layer.masksToBounds = true
        labelTitle?.xm_height = 30
        labelTitle?.xm_origin = CGPoint(x: 30, y: 5)
        labelTitle?.xm_width = 0
        contentView.addSubview(labelTitle!)
    }
}

class XMSleepCollectionViewCell: XMCommonCollectionViewCell {
    
    override func initWithSubViews() {
        super.initWithSubViews()
        contentView.addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        c_view.backgroundColor = .clear
        c_view.showsHorizontalScrollIndicator = false
        c_view.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: xm_padding)
        return c_view
    }()
}


class XMSleepCollectionViewDetailCell: XMCommonCollectionViewCell {
    
    
    private var topView: UIView?
    private var imageView: UIImageView?
    private var imagePlay: UIImageView?
    private var labelBottom: UILabel?
    private var backBg: UIImageView?
    private var labelTitle: UILabel?
    
    var detailModel: XMSleepDetailDataListModel? {
        didSet {
            imageView?.setImage(urlString: detailModel?.cover, placeHolderName: "find_albumcell_cover_bg")
            labelTitle?.text = detailModel?.customTitle
        }
    }
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        
        topView = UIView()
        contentView.addSubview(topView!)
        
        imageView = UIImageView()
        imageView?.layer.cornerRadius = 5
        imageView?.layer.masksToBounds = true
        topView?.addSubview(imageView!)
        
        backBg = UIImageView()
        backBg?.image = UIImage(named: "find_mask_96")
        topView?.addSubview(backBg!)
        
        
        
        imagePlay = UIImageView()
        imagePlay?.xm_size = CGSize(width: 30, height: 30)
        imagePlay?.image = UIImage(named: "xm_sleep_play")
        topView?.addSubview(imagePlay!)
        
        labelBottom = UILabel()
        labelBottom?.xm_x = 10
        labelBottom?.xm_height = 22
        topView?.addSubview(labelBottom!)
        
        labelTitle = UILabel()
        labelTitle?.textColor = UIColor.colorWithrgba(180, 180, 180)
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTitle?.textAlignment = .center
        contentView.addSubview(labelTitle!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topView?.xm_origin = CGPoint(x: 0, y: 0)
        topView?.xm_size = CGSize(width: contentView.xm_width, height: contentView.xm_width)
        
        imageView?.frame = topView!.bounds
        backBg?.frame = topView!.bounds
        
        imagePlay?.center = topView!.center
        
        labelBottom?.xm_width = contentView.xm_width - 20
        labelBottom?.xm_y = contentView.xm_height - labelTitle!.xm_height
        
        labelTitle?.xm_origin = CGPoint(x: 0, y: topView!.xm_bottom)
        labelTitle?.xm_size = CGSize(width: contentView.xm_width, height: contentView.xm_height - topView!.xm_height)
        
    }
}


class XMSleepCollectionDiyCell: XMCommonCollectionViewCell {
    
    var imageView: UIImageView?
    
    var labelTitle: UILabel?
    var imageViewIcon: UIImageView?
    var labelDetail: UILabel?
    
    
    
    var detailModel: XMSleepDetailDataListModel? {
        didSet {
            imageView?.setImage(urlString: detailModel?.cardCover, placeHolderName: "new_playpage_default_wide")
            labelTitle?.xm_width = detailModel?.attrWidth ?? 0
            labelTitle?.attributedText = detailModel?.attrTitle
            imageViewIcon?.xm_x = labelTitle!.xm_right
            labelDetail?.text = detailModel?.top3TrackTitleStr
        }
    }
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        imageView = UIImageView()
        imageView?.layer.cornerRadius = 5
        imageView?.layer.masksToBounds = true
        contentView.addSubview(imageView!)
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: xm_padding + 30, y: ceil((contentView.xm_height - 50) * 0.5))
        labelTitle?.xm_size = CGSize(width: 0, height: 20)
        contentView.addSubview(labelTitle!)
        
        imageViewIcon = UIImageView()
        imageViewIcon?.xm_size = CGSize(width: 20, height: 20)
        imageViewIcon?.xm_origin = CGPoint(x: labelTitle!.xm_right, y: labelTitle!.xm_y)
        imageViewIcon?.image = UIImage(named: "xm_sleep_play")
        contentView.addSubview(imageViewIcon!)
        
        labelDetail = UILabel()
        labelDetail?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: labelTitle!.xm_bottom + 10)
        labelDetail?.xm_size = CGSize(width: 260, height: 20)
        labelDetail?.font = UIFont.systemFont(ofSize: 13)
        labelDetail?.textColor = UIColor.colorWithrgba(180, 180, 180)
        contentView.addSubview(labelDetail!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.xm_origin = CGPoint(x: 30, y: 0)
        imageView?.xm_size = CGSize(width: contentView.xm_width - 60, height: contentView.xm_height)
    }
}


class XMSleepCommonBottomCell: XMCommonCollectionViewCell {
    
    
    private var labelTitle: UILabel?
    override func initWithSubViews() {
        super.initWithSubViews()
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.systemFont(ofSize: 12)
        labelTitle?.textColor = UIColor.colorWithrgba(180, 180, 180)
        labelTitle?.textAlignment = .center
        labelTitle?.text = "- 喜马拉雅与顶空共享音频内容 -"
        contentView.addSubview(labelTitle!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelTitle?.frame = contentView.bounds
    }
}
