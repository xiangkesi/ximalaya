//
//  XMShortVideoCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/13.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMShortVideoBottomView: UIView {
    fileprivate var imageHeadView: UIImageView?
    fileprivate var labelUserName: UILabel?
    fileprivate var btnPraise: UIButton?
    
    
    override init(frame: CGRect) {
        var selfFrame = frame
        if selfFrame.size == CGSize(width: 0, height: 0) {
            let cellWidth = floor((xm_screen_width - 15) * 0.5)
            selfFrame.size = CGSize(width: cellWidth, height: 44)
        }
        super.init(frame: selfFrame)
        imageHeadView = UIImageView()
        imageHeadView?.xm_origin = CGPoint(x: 10, y: 10)
        imageHeadView?.xm_size = CGSize(width: ceil((xm_height - imageHeadView!.xm_y * 2)), height: ceil((xm_height - imageHeadView!.xm_y * 2)))
        imageHeadView?.layer.cornerRadius = imageHeadView!.xm_size.width * 0.5
        imageHeadView?.layer.masksToBounds = true
        addSubview(imageHeadView!)
        labelUserName = UILabel()
        labelUserName?.font = UIFont.systemFont(ofSize: 12)
        labelUserName?.xm_size = CGSize(width: 100, height: 20)
        labelUserName?.xm_origin = CGPoint(x: imageHeadView!.xm_right + 5, y: 12)
        labelUserName?.textColor = UIColor.xm.dynamicRGB((160, 160, 160), (120, 120, 120))
        addSubview(labelUserName!)
        
        btnPraise = UIButton(type: UIButton.ButtonType.custom)
        btnPraise?.xm_size = CGSize(width: 40, height: imageHeadView!.xm_height)
        btnPraise?.xm_origin = CGPoint(x: xm_width - btnPraise!.xm_width - 10, y: imageHeadView!.xm_y)
        btnPraise?.contentHorizontalAlignment = .right
        btnPraise?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btnPraise?.setImage(UIImage(named: "abc_ic_feed_like_default"), for: UIControl.State.normal)
        btnPraise?.setTitle(" 赞", for: UIControl.State.normal)
        btnPraise?.setTitleColor(UIColor.xm.dynamicRGB((160, 160, 160), (120, 120, 120)), for: UIControl.State.normal)
        addSubview(btnPraise!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMShortVideoCell: UICollectionViewCell {
    
    static let XMShortVideoCell_identify = "XMShortVideoCell_identify"
    private var imageView: UIImageView?
    private var labelContent: UILabel?
    
    private var btnCount: UIButton?
    private var bottomView: XMShortVideoBottomView?
    
    var layout: ShortVideoLayout? {
        didSet {
            guard let layout = layout else {
                return
            }
            imageView?.xm_height = layout.imageHeight
            btnCount?.xm_y = imageView!.xm_height - 30
            imageView?.setImage(urlString: layout.coverPath, placeHolderName: nil)
            
            labelContent?.xm_y = imageView!.xm_bottom + layout.labelTopMargin
            labelContent?.xm_height = layout.attrTitleHeight
            labelContent?.attributedText = layout.attrTitle
            bottomView?.xm_y = labelContent!.xm_bottom
            bottomView?.imageHeadView?.setImageRoundCorner(urlString: layout.video?.item?.user?.avatar, placeHolderName: "home_actionsheet_man_sel", corner: 50)
            bottomView?.labelUserName?.text = layout.video?.item?.user?.nickname
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.layer.cornerRadius = 5
//        contentView.clipsToBounds = true
        contentView.layer.masksToBounds = true
        let cellWidth = floor((xm_screen_width - 15) * 0.5)
        
        imageView = UIImageView()
        imageView?.contentMode = .scaleAspectFill
        imageView?.xm_origin = CGPoint(x: 0, y: 0)
        imageView?.xm_size = CGSize(width: cellWidth, height: 0)
        contentView.addSubview(imageView!)
        btnCount = UIButton(type: UIButton.ButtonType.custom)
        btnCount?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        btnCount?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btnCount?.setImage(UIImage(named: "find_play_count"), for: UIControl.State.normal)
        btnCount?.setTitle("2.2万次播放", for: UIControl.State.normal)
        btnCount?.xm_size = CGSize(width: 200, height: 30)
        btnCount?.xm_x = imageView!.xm_width - btnCount!.xm_width - 10
        btnCount?.contentHorizontalAlignment = .right
        contentView.addSubview(btnCount!)
        
        
        
        labelContent = UILabel()
        labelContent?.xm_origin = CGPoint(x: 10, y: imageView!.xm_bottom)
        labelContent?.xm_size = CGSize(width: cellWidth - 20, height: 0)
        labelContent?.numberOfLines = 2
        contentView.addSubview(labelContent!)
        bottomView = XMShortVideoBottomView()
        bottomView?.xm_origin = CGPoint(x: 0, y: 0)
        contentView.addSubview(bottomView!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
