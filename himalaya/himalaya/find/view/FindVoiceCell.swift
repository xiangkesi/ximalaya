//
//  FindVoiceCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/12.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class ZSVideoCell: UICollectionViewCell {
    
    
    private var playerView: FindVoicePlayerView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.dynamicRGB((255, 255, 255), (20, 20, 20))
        playerView = FindVoicePlayerView()
        playerView?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        contentView.addSubview(playerView!)
    }
    
    var row: ActiveSectionRow? {
        didSet {
            playerView?.imageViewBg?.setImage(urlString: row?.imageCover, placeHolderName: "new_playpage_default_wide")
            playerView?.labelTime?.attributedText = row?.videoTitle
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ZSContentLabelCell: UICollectionViewCell {
    
    private var labelContent: UILabel?
    
    var row: ActiveSectionRow? {
           didSet {
            if let row = row {
                labelContent?.xm_height = row.attrTitleHeight
                labelContent?.attributedText = row.attrTitle
            }
            
           }
       }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.dynamicRGB((255, 255, 255), (20, 20, 20))
        labelContent = UILabel()
        labelContent?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        labelContent?.xm_size = CGSize(width: content_view_width, height: 0)
        labelContent?.numberOfLines = 0
        contentView.addSubview(labelContent!)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ZSBottomViewCell: UICollectionViewCell {
    private var bottomView: FindVoiceBottomView?
    
    var row: ActiveSectionRow? {
        didSet {
            if let row = row {
                bottomView?.headImageView?.setImageRoundCorner(urlString: row.userCover, placeHolderName: nil, corner: 50)
                bottomView?.labelUserName?.text = row.userName
                bottomView?.btnPraise?.setTitle(row.attrUserCount, for: UIControl.State.normal)
            }
               
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.dynamicRGB((255, 255, 255), (20, 20, 20))
        bottomView = FindVoiceBottomView()
        bottomView?.xm_origin = CGPoint(x: 0, y: 0)
        contentView.addSubview(bottomView!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class FindVoiceTopView: UIView {
    
    private var btnTopic: UIButton?
    
    override init(frame: CGRect) {
        var selfFrame = frame
        if selfFrame.size.width == 0 && selfFrame.size.height == 0 {
            selfFrame.size = CGSize(width: xm_screen_width, height: 45)
        }
        super.init(frame: selfFrame)
        btnTopic = UIButton(type: UIButton.ButtonType.custom)
        btnTopic?.xm_size = CGSize(width: 200, height: 30)
        btnTopic?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        btnTopic?.layer.cornerRadius = 15
        btnTopic?.layer.masksToBounds = false
        addSubview(btnTopic!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class FindVoicePlayerView: UIView {
    
    var imageViewBg: UIImageView?
    var playerBtn: UIButton?
    var labelTime: UILabel?
    
    
    override init(frame: CGRect) {
        var selfFrame = frame
        if selfFrame.size.width == 0 && selfFrame.size.height == 0 {
            selfFrame.size = CGSize(width: content_view_width, height: ceil(content_view_width * 0.56))
        }
        super.init(frame: selfFrame)
        imageViewBg = UIImageView()
        imageViewBg?.layer.cornerRadius = 5
        imageViewBg?.layer.masksToBounds = true
        imageViewBg?.frame = bounds
        addSubview(imageViewBg!)
        
        let imageView = UIImageView()
        imageView.frame = bounds
        imageView.image = UIImage(named: "find_mask_96")
        addSubview(imageView)
        
        
        
        playerBtn = UIButton(type: UIButton.ButtonType.custom)
        playerBtn?.xm_size = CGSize(width: 50, height: 50)
        playerBtn?.center = center
        playerBtn?.setImage(UIImage(named: "album_video_play"), for: UIControl.State.normal)
        addSubview(playerBtn!)
        
        labelTime = UILabel()
        labelTime?.xm_size = CGSize(width: 200, height: 30)
        labelTime?.xm_origin = CGPoint(x: xm_padding, y: xm_height - labelTime!.xm_height)
        addSubview(labelTime!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FindVoiceBottomView: UIView {
    
    var headImageView: UIImageView?
    var labelUserName: UILabel?
    
    private var btnShare: UIButton?
    var btnPraise: UIButton?
    
    override init(frame: CGRect) {
        var selfFrame = frame
        if selfFrame.size == CGSize(width: 0, height: 0) {
            selfFrame.size = CGSize(width: xm_screen_width, height: 50)
        }
        super.init(frame: selfFrame)
        headImageView = UIImageView()
        headImageView?.xm_origin = CGPoint(x: xm_padding, y: 10)
        headImageView?.xm_size = CGSize(width: 30, height: 30)
        headImageView?.layer.cornerRadius = 15
        headImageView?.layer.masksToBounds = true
        addSubview(headImageView!)
        
        labelUserName = UILabel()
        labelUserName?.textColor = UIColor.xm.dynamicRGB((110, 110, 110), (130, 130, 130))
        labelUserName?.font = UIFont.systemFont(ofSize: 13)
        labelUserName?.xm_size = CGSize(width: xm_width * 0.4, height: 30)
        labelUserName?.xm_origin = CGPoint(x: headImageView!.xm_right + 10, y: 10)
        addSubview(labelUserName!)
        
        btnShare = UIButton(type: UIButton.ButtonType.custom)
        btnShare?.xm_size = CGSize(width: xm_height, height: xm_height)
        btnShare?.xm_origin = CGPoint(x: xm_width - xm_padding - xm_height, y: 0)
        btnShare?.setImage(UIImage(named: "icon_more"), for: UIControl.State.normal)
        btnShare?.contentHorizontalAlignment = .right
        addSubview(btnShare!)
        
        btnPraise = UIButton(type: UIButton.ButtonType.custom)
        btnPraise?.xm_size = CGSize(width: 120, height: 30)
        btnPraise?.xm_origin = CGPoint(x: btnShare!.xm_x - btnPraise!.xm_width, y: 10)
        btnPraise?.contentHorizontalAlignment = .left
        btnPraise?.setTitleColor(UIColor.xm.dynamicRGB((50, 50, 50), (210, 210, 210)), for: UIControl.State.normal)
        btnPraise?.isUserInteractionEnabled = false
        btnPraise?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btnPraise?.setImage(UIImage(named: "voice_people"), for: UIControl.State.normal)
        btnPraise?.contentHorizontalAlignment = .left
        addSubview(btnPraise!)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//class ActiveSelectCell: UICollectionViewCell {
//    
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.backgroundColor = .clear
//        view.alwaysBounceVertical = false
//        view.alwaysBounceHorizontal = true
//        view.showsHorizontalScrollIndicator = false
//        view.contentInset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: 0)
//        self.contentView.addSubview(view)
//        return view
//    }()
//    
//    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        collectionView.frame = contentView.bounds
//    }
//}

class ActiveSelectDetailCell: UICollectionViewCell {
    
    private var imageView: UIImageView?
    private var labelTitle: UILabel?
    
    var item: XMFindVoiceContentModel? {
        didSet {
            imageView?.setImage(urlString: item?.coverPath, placeHolderName: nil)
            labelTitle?.xm_height = item?.contentAttrHeight ?? 0
            labelTitle?.attributedText = item?.contentAttr
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_230_20_color
        imageView = UIImageView()
        imageView?.xm_origin = CGPoint(x: 0, y: 0)
        imageView?.xm_size = CGSize(width: 150, height: 97)
        contentView.addSubview(imageView!)
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: 0, y: imageView!.xm_bottom)
        labelTitle?.xm_size = CGSize(width: imageView!.xm_width, height: 0)
        labelTitle?.numberOfLines = 2
        contentView.addSubview(labelTitle!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ActiveTitleCell: UICollectionViewCell {
    var labelTitle: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_230_20_color
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (210, 210, 210))
        contentView.addSubview(labelTitle!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: 0)
        labelTitle?.xm_size = CGSize(width: 200, height: contentView.xm_height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindVoiceLevelCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_230_20_color
        contentView.addSubview(collectionView)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.contentInset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: 5)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindVoiceTalentCell: UICollectionViewCell {
    
    
    private var imageViewBg: UIImageView?
    private var labelTopTitle: UILabel?
    
    private var imageHeadView: UIImageView?
    private var labelUserName: UILabel?
    private var labelPraiseCount: UILabel?
    private var buttonNotice: UIButton?
    
    
    var item: XMFindVoiceContentModel? {
        didSet {
            imageHeadView?.setImage(urlString: item?.logoPic, placeHolderName: "find_vip_default_icon")
            labelUserName?.text = item?.nickname
            labelPraiseCount?.text = " 获赞数\(item?.favorites ?? 0)"
            
            guard let contents = item?.productModels else {
                return
            }
            for (index, view) in bottomViews.enumerated() {
                if index < contents.count{
                    let content = contents[index]
                    view.imageView?.setImage(urlString: content.coverSmall, placeHolderName: "find_vip_default_icon")
                    view.labelTitle?.text = content.title
                    view.labelDetail?.text = "\(content.playTimes)次播放"
                }
            }
        }
    }
    
    
    private var bottomViews = [XMFindVoiceTalentBottomView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageViewBg = UIImageView()
        imageViewBg?.layer.cornerRadius = 5
        imageViewBg?.layer.masksToBounds = true
        imageViewBg?.image = UIImage(named: "bg_vip_logout_alert_iphone")
        imageViewBg?.frame = contentView.bounds
//        imageViewBg?.alpha = 0.5
        contentView.addSubview(imageViewBg!)
        
        let cellWidth: CGFloat = 280
        imageHeadView = UIImageView()
        imageHeadView?.xm_size = CGSize(width: 46, height: 46)
        imageHeadView?.xm_origin = CGPoint(x: 20, y: 20)
        imageHeadView?.layer.cornerRadius = 23
        imageHeadView?.layer.masksToBounds = true
        contentView.addSubview(imageHeadView!)
        
        labelUserName = UILabel()
        labelUserName?.font = UIFont.boldSystemFont(ofSize: 16)
        labelUserName?.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (210, 210, 210))
        labelUserName?.xm_origin = CGPoint(x: imageHeadView!.xm_right + 10, y: imageHeadView!.xm_y)
        labelUserName?.xm_size = CGSize(width: cellWidth - labelUserName!.xm_x - 50, height: 24)
        contentView.addSubview(labelUserName!)
        
        labelPraiseCount = UILabel()
        labelPraiseCount?.xm_origin = CGPoint(x: labelUserName!.xm_x, y: labelUserName!.xm_bottom)
        labelPraiseCount?.xm_size = CGSize(width: labelUserName!.xm_width, height: 15)
        labelPraiseCount?.font = UIFont.systemFont(ofSize: 12)
        labelPraiseCount?.textColor = UIColor.colorWithrgba(189, 94, 89)
        contentView.addSubview(labelPraiseCount!)
        
        labelTopTitle = UILabel()
        labelTopTitle?.font = UIFont.systemFont(ofSize: 13)
        labelTopTitle?.xm_origin = CGPoint(x: 20, y: imageHeadView!.xm_bottom + 20)
        labelTopTitle?.xm_size = CGSize(width: cellWidth - 40, height: 14)
        labelTopTitle?.textColor = UIColor.xm.dynamicRGB((124, 124, 124), (130, 130, 130))
        labelTopTitle?.text = "你好周杰伦"
        contentView.addSubview(labelTopTitle!)
        
        for index in 0..<3 {
            let bottomView = XMFindVoiceTalentBottomView()
            bottomView.xm_x = 20
            bottomView.xm_size = CGSize(width: cellWidth - 40, height: 60)
            bottomView.xm_y = labelTopTitle!.xm_bottom + CGFloat(index) * bottomView.xm_height
            contentView.addSubview(bottomView)
            bottomViews.append(bottomView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindVoiceTalentBottomView: UIView {
    
    fileprivate var imageView: UIImageView?
    fileprivate var labelTitle: UILabel?
    fileprivate var labelDetail: UILabel?
    fileprivate var imageViewArrow: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        imageView?.xm_size = CGSize(width: 40, height: 40)
        imageView?.xm_origin = CGPoint(x: 0, y: 10)
        imageView?.layer.cornerRadius = 5
        imageView?.layer.masksToBounds = true
        imageView?.contentMode = .scaleAspectFill
        addSubview(imageView!)
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: imageView!.xm_right + 10, y: imageView!.xm_y)
        labelTitle?.xm_size = CGSize(width: 180, height: 20)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (210, 210, 210))
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 14)
        addSubview(labelTitle!)
        
        labelDetail = UILabel()
        labelDetail?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: labelTitle!.xm_bottom)
        labelDetail?.xm_size = CGSize(width: labelTitle!.xm_width, height: 20)
        labelDetail?.textColor = UIColor.xm.dynamicRGB((120, 120, 120), (90, 90, 90))
        labelDetail?.font = UIFont.systemFont(ofSize: 12)
        addSubview(labelDetail!)
        
        imageViewArrow = UIImageView()
        imageViewArrow?.xm_size = CGSize(width: 8, height: 14)
        imageViewArrow?.xm_origin = CGPoint(x: 230, y: ceil((60 - imageViewArrow!.xm_height) * 0.5))
        imageViewArrow?.image = UIImage(named: "ad_arrow_right")
        addSubview(imageViewArrow!)
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
