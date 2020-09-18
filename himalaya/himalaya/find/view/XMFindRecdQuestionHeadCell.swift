//
//  XMFindRecdQuestionHeadCell.swift
//  himalaya
//
//  Created by Farben on 2020/9/3.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMFindRecdQuestionHeadProfileView: UIView {
    
    
    fileprivate var labelUserName: UILabel?
    override init(frame: CGRect) {
        var selfFrame = frame
        if selfFrame.size == CGSize(width: 0, height: 0) {
            selfFrame.size = CGSize(width: xm_screen_width, height: 24)
        }
        super.init(frame: selfFrame)
        imageView.xm_size = CGSize(width: xm_height, height: xm_height)
        imageView.xm_origin = CGPoint(x: xm_padding, y: 0)
        addSubview(imageView)
        
        labelUserName = UILabel()
        labelUserName?.xm_x = imageView.xm_right + 10
        labelUserName?.xm_y = 0
        labelUserName?.xm_size = CGSize(width: xm_width - labelUserName!.xm_x - xm_padding, height: xm_height)
        labelUserName?.textColor = UIColor.xm.dynamicRGB((160, 160, 160), (130, 130, 130))
        labelUserName?.font = UIFont.systemFont(ofSize: 14)
        addSubview(labelUserName!)
    }
    
    fileprivate lazy var imageView: UIImageView = {
        let i_view = UIImageView()
        i_view.layer.cornerRadius = 12
        i_view.layer.masksToBounds = true
        return i_view
    }()

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XMFindRecdQuestionHeadCell: UICollectionViewCell {
    
    
    private var labelTitle: XMLabel?
    private var profileView: XMFindRecdQuestionHeadProfileView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        labelTitle = XMLabel()
        labelTitle?.xm_displaysAsynchronously = true
        labelTitle?.xm_ignoreCommonProperties = false
        labelTitle?.xm_fadeOnAsynchronouslyDisplay = false
        labelTitle?.xm_fadeOnHighlight = false
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        labelTitle?.xm_size = CGSize(width: contentView.xm_width - 30, height: 0)
        contentView.addSubview(labelTitle!)
        
        profileView = XMFindRecdQuestionHeadProfileView()
        profileView?.xm_y = contentView.xm_height - profileView!.xm_height
        contentView.addSubview(profileView!)
        
    }
//    35 - 24 = 11
    var row: XMFindRecdSectionRow? {
        didSet {
            labelTitle?.xm_height = row!.contentHeight
            labelTitle?.xm_textLayout = row?.contentLayout
            profileView?.xm_y = row!.cellHeight - profileView!.xm_height
            profileView?.imageView.setImage(urlString: row?.avatar, placeHolderName: "find_vip_default_icon")
            profileView?.labelUserName?.attributedText = row?.contentAttr
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindProfileCell: UICollectionViewCell {
    
    
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.addSubview(headView)
        contentView.addSubview(labelUserName)
        contentView.addSubview(labelDesc)
        contentView.addSubview(buttonNotice)
        
        
        
    }
    
    var layout: XMFindRecdLayout? {
        didSet {
            headView.setImage(urlString: layout?.findItem?.item?.userInfo?.avatar, placeHolderName: "find_vip_default_icon")
            labelUserName.text = layout?.findItem?.item?.userInfo?.nickname
            labelDesc.text = layout?.findItem?.item?.recReason
            buttonNotice.isHidden = layout?.findItem?.item?.isFollowed ?? true
        }
    }
    
    
    fileprivate lazy var headView: UIImageView = {
        let h_view = UIImageView()
        h_view.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        h_view.xm_size = CGSize(width: 50, height: 50)
        h_view.layer.cornerRadius = 25
        h_view.layer.masksToBounds = true
        
        return h_view
    }()
    
    fileprivate lazy var labelUserName: UILabel = {
        let l_name = UILabel()
        l_name.font = UIFont.boldSystemFont(ofSize: 15)
        l_name.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (230, 230, 230))
        l_name.xm_origin = CGPoint(x: headView.xm_right + 10, y: headView.xm_y)
        l_name.xm_size = CGSize(width: contentView.xm_width - l_name.xm_x - 90, height: 24)
        return l_name
    }()
    
    fileprivate lazy var labelDesc: UILabel = {
        let l_desc = UILabel()
        l_desc.font = UIFont.systemFont(ofSize: 13)
        l_desc.textColor = UIColor.xm.dynamicRGB((100, 100, 100), (150, 150, 150))
        l_desc.xm_size = CGSize(width: labelUserName.xm_width, height: 20)
        l_desc.xm_origin = CGPoint(x: labelUserName.xm_x, y: headView.xm_bottom - l_desc.xm_height - 3)
        return l_desc
    }()
    
    fileprivate lazy var buttonNotice: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.xm_size = CGSize(width: 68, height: 30)
        btn.xm_origin = CGPoint(x: contentView.xm_width - xm_padding - btn.xm_width, y: headView.xm_centerY - xm_padding)
//        btn.backgroundColor = UIColor.yellow
        btn.setBackgroundImage(UIImage(named: "follow_hotUser_hightlight"), for: UIControl.State.normal)
        return btn
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindVideoCell: UICollectionViewCell {
    
    
    var videoView: XMFindVideoView?
    
//    var layout: XMFindRecdLayout? {
//        didSet {
//            videoView?.imagePhoto.setImage(urlString: layout?.findItem.item?.contentModel?.nodes?.last?.nodeDetail?.coverUrl, placeHolderName: "new_playpage_default_wide")
//        }
//    }
    
    var row: XMFindRecdSectionRow? {
        didSet {
            videoView?.imagePhoto.setImage(urlString: row?.node?.nodeDetail?.coverUrl, placeHolderName: "new_playpage_default_wide")
            videoView?.imageView.setImage(urlString: row?.node?.nodeDetail?.coverUrl, placeHolderName: "new_playpage_default_wide")
            videoView?.xm_height = row!.contentHeight
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        videoView = XMFindVideoView()
        videoView?.xm_origin = CGPoint(x: xm_padding, y: 10)
        videoView?.xm_width = content_view_width
        contentView.addSubview(videoView!)
    }
    
  
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoView?.xm_height = contentView.xm_height - 10
    }
    
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindVideoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imagePhoto)
        imagePhoto.addSubview(effectview)
        addSubview(imageView)
        addSubview(btnPlayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imagePhoto.frame = bounds
        effectview.frame = imagePhoto.bounds
        imageView.frame = bounds
        btnPlayer.center = center
    }
     
    fileprivate lazy var btnPlayer: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.xm_size = CGSize(width: 50, height: 50)
        btn.setImage(UIImage(named: "newer_rec_video_play"), for: UIControl.State.normal)
        return btn
    }()
     fileprivate lazy var imagePhoto: UIImageView = {
         let i_photo = UIImageView()
         i_photo.contentMode = .scaleAspectFill
        i_photo.layer.cornerRadius = 5
        i_photo.layer.masksToBounds = true
         return i_photo
     }()
    
    fileprivate lazy var effectview: UIVisualEffectView = {
        let e_view = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffect.Style.dark))
          return e_view
      }()
     
    fileprivate lazy var imageView: UIImageView = {
        let i_view = UIImageView()
        i_view.contentMode = .scaleAspectFit
        return i_view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindPictureCell: UICollectionViewCell {
    
    private lazy var imageViews = [UIImageView]()
    
    var row: XMFindRecdSectionRow? {
        didSet {
            guard let pics = row?.node?.pictureModels else {
                return
            }
            let picCount = pics.count
                labelMore?.isHidden = true
                for (index, view) in imageViews.enumerated() {
                    if index < picCount {
                        view.isHidden = false
                        let pic = pics[index]
                        view.frame = row!.picFrames[index]
                        view.setImage(urlString: pic.thumbnailUrlOfRowContainThree, placeHolderName: "new_playpage_default_wide")
                     }else {
                        view.cancelRequest()
                        view.isHidden = true
                     }
                 }
                    if picCount > 6 {
                        labelMore?.isHidden = false
                        labelMore?.text = "+\(picCount - 6)"
                        labelMore?.frame = row!.picFrames.last!
                    }
        }
    }
    
    private var labelMore: UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        for _ in 0..<6 {
            let imageView = UIImageView()
            imageView.xm_size = CGSize(width: 100, height: 100)
            imageView.isHidden = true
            imageView.contentMode = .scaleAspectFill
//            imageView.clipsToBounds = true
            contentView.addSubview(imageView)
            imageView.layer.cornerRadius = 3
            imageView.layer.masksToBounds = true
            imageViews.append(imageView)
        }
        labelMore = UILabel()
        labelMore?.textColor = UIColor.colorWithrgba(255, 255, 255)
        labelMore?.font = UIFont.boldSystemFont(ofSize: 25)
        labelMore?.textAlignment = .center
        labelMore?.layer.cornerRadius = 3
        labelMore?.backgroundColor = UIColor(white: 0.2, alpha: 0.2)
        labelMore?.xm_origin = CGPoint(x: 0, y: 0)
        labelMore?.xm_size = CGSize(width: ceil((content_view_width - 6) / 3), height: ceil((content_view_width - 6) / 3))
        labelMore?.isHidden = true
        contentView.addSubview(labelMore!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindBottomViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.addSubview(btnShare)
        contentView.addSubview(btnComment)
        contentView.addSubview(btnPraise)
    }
    
    fileprivate lazy var btnShare: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.xm_size = CGSize(width: 70, height: 30)
        btn.xm_origin = CGPoint(x: xm_padding, y: 10)
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(UIColor.xm.dynamicRGB((170, 170, 170), (185, 185, 185)), for: UIControl.State.normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        btn.setTitle("分享", for: UIControl.State.normal)
//        btn.backgroundColor = UIColor.red
        
        btn.setImage(UIImage(named: "abc_ic_feed_share"), for: UIControl.State.normal)
        return btn
    }()
    
    fileprivate lazy var btnComment: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.xm_size = btnShare.xm_size
        btn.xm_origin = CGPoint(x: btnShare.xm_right + 20, y: btnShare.xm_y)
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
//        btn.backgroundColor = UIColor.red
        btn.setTitleColor(UIColor.xm.dynamicRGB((170, 170, 170), (185, 185, 185)), for: UIControl.State.normal)
        btn.setImage(UIImage(named: "abc_ic_feed_comment"), for: UIControl.State.normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        btn.setTitle("评论", for: UIControl.State.normal)
        return btn
    }()
    
    fileprivate lazy var btnPraise: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.xm_size = btnComment.xm_size
        btn.xm_origin = CGPoint(x: btnComment.xm_right + 20, y: btnComment.xm_y)
        btn.contentHorizontalAlignment = .left
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btn.setTitleColor(UIColor.xm.dynamicRGB((170, 170, 170), (185, 185, 185)), for: UIControl.State.normal)
//        btn.backgroundColor = UIColor.red
        btn.setImage(UIImage(named: "abc_ic_feed_like_default"), for: UIControl.State.normal)
        btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        btn.setTitle("100", for: UIControl.State.normal)
        return btn
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindTextCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.addSubview(labelText)
    }
    
    var row: XMFindRecdSectionRow? {
        didSet {
            labelText.xm_textLayout = row?.contentLayout
            labelText.xm_height = row!.contentHeight
        }
    }
    
    fileprivate lazy var labelText: XMLabel = {
        let l_name = XMLabel()
       
        l_name.xm_displaysAsynchronously = true
        l_name.xm_ignoreCommonProperties = true
        l_name.xm_fadeOnAsynchronouslyDisplay = false
        l_name.xm_fadeOnHighlight = false
        l_name.xm_origin = CGPoint(x: xm_padding, y: 10)
        l_name.xm_size = CGSize(width: content_view_width, height: contentView.xm_height)
        return l_name
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindFromCycleCell: UICollectionViewCell {
    
    private var labelTitle: XMLabel?
    
    var row: XMFindRecdSectionRow? {
        didSet {
            labelTitle?.xm_textLayout = row?.contentLayout
//            textLayout = row?.contentLayout
        }
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
//        contentView.backgroundColor = UIColor.red
        labelTitle = XMLabel()
//        labelTitle?.backgroundColor = UIColor.green
        labelTitle?.xm_displaysAsynchronously = true
        labelTitle?.xm_ignoreCommonProperties = true
        labelTitle?.xm_fadeOnAsynchronouslyDisplay = false
        labelTitle?.xm_fadeOnHighlight = false
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: 15)
        labelTitle?.xm_size = CGSize(width: contentView.xm_width - 30, height: 15)
        contentView.addSubview(labelTitle!)
        
        labelTitle?.highlightTapAction = { (containerView, text, range, rect) in
            print("点击了")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindTrackCell: UICollectionViewCell {
    
      var row: XMFindRecdSectionRow? {
            didSet {
                imageView?.setImage(urlString: row?.node?.nodeDetail?.coverUrl, placeHolderName: "find_albumcell_cover_bg")
                labelTitle?.text = row?.node?.nodeDetail?.title
                labelDetail?.attributedText = row?.contentAttr
                labelBottom?.attributedText = row?.titleAttr
            }
            
        }
    
    
    private var mainView: UIView?
    private var imageView: UIImageView?
    private var labelTitle: UILabel?
    private var labelDetail: UILabel?
    private var labelBottom: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        
        mainView = UIView()
        mainView?.backgroundColor = UIColor.xm.dynamicRGB((235, 235, 235), (50, 50, 50))
        mainView?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        mainView?.xm_size = CGSize(width: content_view_width, height: 80)
        mainView?.layer.cornerRadius = 5
        contentView.addSubview(mainView!)
        
        imageView = UIImageView()
        imageView?.layer.cornerRadius = 3
        imageView?.layer.masksToBounds = true
        imageView?.xm_origin = CGPoint(x: 10, y: 10)
        imageView?.xm_size = CGSize(width: mainView!.xm_height - 20, height: mainView!.xm_height - 20)
        mainView?.addSubview(imageView!)
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: imageView!.xm_right + 10, y: 10)
        labelTitle?.xm_size = CGSize(width: mainView!.xm_width - labelTitle!.xm_x - xm_padding, height: 16)
        labelTitle?.font = UIFont.systemFont(ofSize: 13)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((20, 20, 20), (196, 196, 196))
        mainView?.addSubview(labelTitle!)
        
        labelDetail = UILabel()
        labelDetail?.xm_size = CGSize(width: labelTitle!.xm_width, height: 16)
        labelDetail?.xm_x = labelTitle!.xm_x
        labelDetail?.xm_centerY = imageView!.xm_centerY
        mainView?.addSubview(labelDetail!)
        
        labelBottom = UILabel()
        labelBottom?.xm_size = labelDetail!.xm_size
        labelBottom?.xm_x = labelDetail!.xm_x
        labelBottom?.xm_y = imageView!.xm_bottom - labelBottom!.xm_height
        mainView?.addSubview(labelBottom!)
        
        
       
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFindHotCommentCell: UICollectionViewCell {
    private var mainView: UIView?
    private var imageHotView: UIImageView?
    private var imageHeadView: UIImageView?
    private var labelTitle: UILabel?
    private var labelComment: XMLabel?
    private var btnPraise: UIButton?
    
    
    
    var row: XMFindRecdSectionRow? {
        didSet {
            guard let r = row else {
                return
            }
            mainView?.xm_height = r.cellHeight - 10
            imageHeadView?.setImage(urlString: row?.avatar, placeHolderName: "find_vip_default_icon")
            labelTitle?.attributedText = row?.contentAttr
            btnPraise?.setAttributedTitle(row?.titleAttr, for: UIControl.State.normal)
            labelComment?.xm_height = r.contentHeight
            labelComment?.xm_textLayout = r.contentLayout
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        mainView = UIView()
        mainView?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        mainView?.xm_size = CGSize(width: content_view_width, height: 60)
        mainView?.backgroundColor = UIColor.xm.dynamicRGB((242, 245, 246), (12, 12, 12))
        mainView?.layer.cornerRadius = 5
        contentView.addSubview(mainView!)
        
        imageHotView = UIImageView()
        imageHotView?.xm_origin = CGPoint(x: 0, y: 0)
        imageHotView?.xm_size = CGSize(width: 22, height: 22)
        imageHotView?.image = UIImage(named: "XMMoment_moment_hot_comment_tag")
        mainView?.addSubview(imageHotView!)
        
        imageHeadView = UIImageView()
        imageHeadView?.xm_size = CGSize(width: 30, height: 30)
        imageHeadView?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        imageHeadView?.layer.cornerRadius = 15
        imageHeadView?.layer.masksToBounds = true
        mainView?.addSubview(imageHeadView!)
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: imageHeadView!.xm_right + 10, y: imageHeadView!.xm_y)
        labelTitle?.xm_size = CGSize(width: mainView!.xm_width - labelTitle!.xm_x - 100, height: 20)
        mainView?.addSubview(labelTitle!)
        
        btnPraise = UIButton(type: UIButton.ButtonType.custom)
        btnPraise?.xm_size = CGSize(width: 60, height: 30)
        btnPraise?.xm_origin = CGPoint(x: mainView!.xm_width - btnPraise!.xm_width - xm_padding, y: 10)
        btnPraise?.contentHorizontalAlignment = .right
        btnPraise?.setImage(UIImage(named: "abc_ic_feed_like_default"), for: UIControl.State.normal)
        btnPraise?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        mainView?.addSubview(btnPraise!)
        
        
        labelComment = XMLabel()
        labelComment?.xm_displaysAsynchronously = true
        labelComment?.xm_ignoreCommonProperties = true
        labelComment?.xm_fadeOnAsynchronouslyDisplay = false
        labelComment?.xm_fadeOnHighlight = false
        labelComment?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: imageHeadView!.xm_bottom - 3)
        labelComment?.xm_size = CGSize(width: mainView!.xm_width - labelComment!.xm_x - xm_padding, height: 0)
        mainView?.addSubview(labelComment!)
        
//        labelComment = UILabel()
//        labelComment?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: imageHeadView!.xm_bottom)
//        labelComment?.xm_size = CGSize(width: mainView!.xm_width - labelComment!.xm_x - xm_padding, height: 0)
//        mainView?.addSubview(labelComment!)
        
        
    }
    
    
//        fileprivate lazy var btnPraise: UIButton = {
//            let btn = UIButton(type: UIButton.ButtonType.custom)
//            btn.xm_size = btnComment.xm_size
//            btn.xm_origin = CGPoint(x: btnComment.xm_right + 20, y: btnComment.xm_y)
//            btn.contentHorizontalAlignment = .left
//            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
//            btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
//            btn.setTitleColor(UIColor.xm.dynamicRGB((170, 170, 170), (185, 185, 185)), for: UIControl.State.normal)
//    //        btn.backgroundColor = UIColor.red
//            btn.setImage(UIImage(named: "abc_ic_feed_like_default"), for: UIControl.State.normal)
//            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
//            btn.setTitle("100", for: UIControl.State.normal)
//            return btn
//        }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMFinRecdVoteFooterCell: UICollectionViewCell {
    
    
    fileprivate var btnVote: UIButton?
    
    
//    var row: XMFindRecdSectionRow? {
//        didSet {
//
//        }
//    }
    
//    var layout: XMFindRecdLayout? {
//        didSet {
//            if layout!.voteCellLastIndex > 2 {//有需要展开的
//                btnVote?.setTitle("点击展开", for: UIControl.State.normal)
//                btnVote?.backgroundColor = UIColor.clear
//            }else {
//                btnVote?.setTitle("投票", for: UIControl.State.normal)
//                btnVote?.backgroundColor = UIColor.colorWidthHexString(hex: mainColorString)
//            }
//        }
//    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        btnVote = UIButton(type: UIButton.ButtonType.custom)
        btnVote?.backgroundColor = UIColor.colorWidthHexString(hex: mainColorString)
        btnVote?.xm_size = CGSize(width: content_view_width - 30, height: 40)
        btnVote?.xm_origin = CGPoint(x: 30, y: 10)
        btnVote?.layer.cornerRadius = 20
        btnVote?.setTitleColor(UIColor.colorWithrgba(240, 240, 240), for: UIControl.State.normal)
        btnVote?.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        btnVote?.setTitle("投票", for: UIControl.State.normal)
        contentView.addSubview(btnVote!)
        
        let leftView = UIView()
        leftView.backgroundColor = UIColor.xm.dynamicRGB((240, 240, 240), (50, 50, 50))
        leftView.xm_y = 0
        leftView.xm_x = xm_padding
        
        leftView.xm_size = CGSize(width: 1, height: 65)
        contentView.addSubview(leftView)
        
        let bottomView = UIView()
        bottomView.backgroundColor = UIColor.xm.dynamicRGB((240, 240, 240), (50, 50, 50))
        bottomView.xm_origin = CGPoint(x: xm_padding, y: 64)
        bottomView.xm_size = CGSize(width: content_view_width, height: 1)
        contentView.addSubview(bottomView)
        
        let rightView = UIView()
        rightView.backgroundColor = UIColor.xm.dynamicRGB((240, 240, 240), (50, 50, 50))
        rightView.xm_y = 0
        rightView.xm_x = content_view_width + xm_padding
        
        rightView.xm_size = CGSize(width: 1, height: 65)
        contentView.addSubview(rightView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class XMFinRecdChooseHeadCell: UICollectionViewCell {
    
    var row: XMFindRecdSectionRow? {
        didSet {
            labelTitle?.attributedText = row?.contentAttr
            labelDetail?.attributedText = row?.titleAttr
        }
    }
    
    private var labelTitle: UILabel?
    private var labelDetail: UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: xm_padding * 2, y: 30)
        labelTitle?.xm_size = CGSize(width: content_view_width - 30, height: 20)
        contentView.addSubview(labelTitle!)
        
        labelDetail = UILabel()
        labelDetail?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: labelTitle!.xm_bottom + 10)
        labelDetail?.xm_size = CGSize(width: labelTitle!.xm_width, height: 14)
        contentView.addSubview(labelDetail!)
        
        let leftView = UIView()
        leftView.backgroundColor = UIColor.xm.dynamicRGB((240, 240, 240), (50, 50, 50))
        leftView.xm_y = 20
        leftView.xm_x = xm_padding
        
        leftView.xm_size = CGSize(width: 1, height: 60)
        contentView.addSubview(leftView)
        
        let topView = UIView()
        topView.backgroundColor = UIColor.xm.dynamicRGB((240, 240, 240), (50, 50, 50))
        topView.xm_origin = leftView.xm_origin
        topView.xm_size = CGSize(width: content_view_width, height: 1)
        contentView.addSubview(topView)
        
        let rightView = UIView()
        rightView.backgroundColor = UIColor.xm.dynamicRGB((240, 240, 240), (50, 50, 50))
        rightView.xm_y = 20
        rightView.xm_x = content_view_width + xm_padding
        
        rightView.xm_size = CGSize(width: 1, height: 60)
        contentView.addSubview(rightView)
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XMFindRecdChooseCell: UICollectionViewCell {
    
    
    fileprivate var mainView: UIView?
    fileprivate var labelTitle: UILabel?
    fileprivate var btn: UIButton?
    
    var row: XMFindRecdSectionRow? {
        didSet {
            labelTitle?.text = row?.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        mainView = UIView()
        mainView?.xm_size = CGSize(width: content_view_width - 30, height: 40)
        mainView?.xm_origin = CGPoint(x: 30, y: 5)
        mainView?.layer.cornerRadius = 20
        mainView?.backgroundColor = UIColor.xm.dynamicRGB((247, 250, 251), (70, 70, 70))
        contentView.addSubview(mainView!)
        
        labelTitle = UILabel()
        labelTitle?.xm_size = CGSize(width: mainView!.xm_width - 40, height: mainView!.xm_height)
        labelTitle?.xm_origin = CGPoint(x: 20, y: 0)
        labelTitle?.font = UIFont.systemFont(ofSize: 14)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((100, 100, 100), (200, 200, 200))
        mainView?.addSubview(labelTitle!)//
        
        btn = UIButton(type: UIButton.ButtonType.custom)
        btn?.xm_size = CGSize(width: 32, height: 32)
        btn?.setImage(UIImage(named: "anchorcenter_ic_choose_n"), for: UIControl.State.normal)
        btn?.xm_origin = CGPoint(x: mainView!.xm_width - btn!.xm_width - xm_padding, y: 4)
        mainView?.addSubview(btn!)
        
        let leftView = UIView()
        leftView.backgroundColor = UIColor.xm.dynamicRGB((240, 240, 240), (50, 50, 50))
        leftView.xm_y = 0
        leftView.xm_x = xm_padding
        
        leftView.xm_size = CGSize(width: 1, height: mainView!.xm_bottom)
        contentView.addSubview(leftView)
        
        let rightView = UIView()
        rightView.backgroundColor = UIColor.xm.dynamicRGB((240, 240, 240), (50, 50, 50))
        rightView.xm_y = 0
        rightView.xm_x = xm_padding + content_view_width
        
        rightView.xm_size = CGSize(width: 1, height: mainView!.xm_bottom)
        contentView.addSubview(rightView)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class XMFindRecdCycleCell: UICollectionViewCell {
    
    
    var imageView: UIImageView?
    var labelTitle: UILabel?
    var buttonJoin: UIButton?
    
    var imageBageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_230_20_color
        imageView = UIImageView()
        imageView?.layer.cornerRadius = 5
        imageView?.layer.masksToBounds = true
        imageView?.xm_size = CGSize(width: contentView.xm_width, height: contentView.xm_width)
        imageView?.xm_origin = CGPoint(x: 0, y: 0)
        contentView.addSubview(imageView!)
        
        imageBageView = UIImageView()
        imageBageView?.contentMode = .scaleAspectFit
        imageBageView?.xm_origin = CGPoint(x: 0, y: 0)
        imageBageView?.xm_size = CGSize(width: 40, height: 19)
        contentView.addSubview(imageBageView!)
//        imageBageView?.snp.makeConstraints({ (make) in
//            make.left.top.equalToSuperview()
//            make.width.lessThanOrEqualTo(50)//23
//        })
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: 0, y: imageView!.xm_bottom)
        labelTitle?.xm_size = CGSize(width: imageView!.xm_width, height: 60)
        labelTitle?.numberOfLines = 2
//        labelTitle?.textAlignment = .center
        contentView.addSubview(labelTitle!)
        
        buttonJoin = UIButton(type: UIButton.ButtonType.custom)
        buttonJoin?.xm_size = CGSize(width: 60, height: 26)
        buttonJoin?.xm_origin = CGPoint(x: ceil((contentView.xm_width - buttonJoin!.xm_width) * 0.5), y: labelTitle!.xm_bottom)
        buttonJoin?.backgroundColor = UIColor.xm.dynamicRGB((210, 210, 210), (40, 40, 40))
        buttonJoin?.layer.cornerRadius = 13
        buttonJoin?.setTitle("+ 加入", for: UIControl.State.normal)
        buttonJoin?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        buttonJoin?.setTitleColor(UIColor.colorWidthHexString(hex: mainColorString), for: UIControl.State.normal)
        contentView.addSubview(buttonJoin!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
