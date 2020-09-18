//
//  HomeNoveManWomenLoveCell.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/8.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit


class HomeNoveManWomenLoveLevelListCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(collectionView)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 15)
//        view.contentInset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: 5)
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


class HomeNoveManWomenLoveTopCell: XMCommonCollectionViewCell {
    
    var labelTitle: UILabel?
    private var btnMore: UIButton?
    
    override func initWithSubViews() {
        super.initWithSubViews()
        labelTitle = UILabel()
        labelTitle?.xm_size = CGSize(width: contentView.xm_width - 100, height: 30)
        labelTitle?.xm_origin = CGPoint(x: 0, y: contentView.xm_height - labelTitle!.xm_height)
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 14)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((60, 60, 60), (210, 210, 210))
        contentView.addSubview(labelTitle!)
    }
 
}

class HomeNoveManWomenLoveCell: XMCommonCollectionViewCell {
    
     private var imageView: UIImageView?
     private var labelTop: UILabel?
     private var labelTitle: UILabel?
     private var labelDesc: UILabel?
     private var labelBottom: UILabel?
    
    
    var loveModel: XMHomeNoveNanNvLoveModel? {
        didSet {
            imageView?.setWebpRoundImage(urlString: loveModel?.coverSmall, placeHolderName: "find_albumcell_cover_bg", corner: 5, rectCorner: [.topLeft, .bottomLeft])
            labelTop?.attributedText = loveModel?.topAttr
            labelTitle?.text = loveModel?.title
            labelDesc?.text = loveModel?.intro
            labelBottom?.attributedText = loveModel?.bottomAttr
        }
    }
    
     
     override func initWithSubViews() {
        super.initWithSubViews()
        contentView.backgroundColor = UIColor.xm.xm_230_20_color
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = false
        imageView = UIImageView()
        imageView?.xm_origin = CGPoint(x: 0, y: 0)
        imageView?.xm_size = CGSize(width: contentView.xm_height, height: contentView.xm_height)
        contentView.addSubview(imageView!)
         
        labelTop = UILabel()
        labelTop?.xm_origin = CGPoint(x: imageView!.xm_right + 10, y: 5)
        labelTop?.xm_size = CGSize(width: 100, height: 14)
        contentView.addSubview(labelTop!)
         
        labelTitle = UILabel()
        labelTitle?.font = UIFont.systemFont(ofSize: 13)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((80, 80, 80), (180, 180, 180))
        labelTitle?.xm_origin = CGPoint(x: labelTop!.xm_x, y: labelTop!.xm_bottom + 5)
        labelTitle?.xm_size = CGSize(width: contentView.xm_width - labelTitle!.xm_x - 10, height: 20)
        contentView.addSubview(labelTitle!)
         
        labelDesc = UILabel()
        labelDesc?.font = UIFont.systemFont(ofSize: 12)
        labelDesc?.textColor = UIColor.xm.dynamicRGB((130, 130, 130), (120, 120, 120))
        labelDesc?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: labelTitle!.xm_bottom + 3)
        labelDesc?.xm_size = CGSize(width: labelTitle!.xm_width, height: 14)
        contentView.addSubview(labelDesc!)
         
        labelBottom = UILabel()
        labelBottom?.xm_origin = CGPoint(x: labelDesc!.xm_x, y: labelDesc!.xm_bottom + 5)
        labelBottom?.xm_size = CGSize(width: labelDesc!.xm_width, height: 14)
        contentView.addSubview(labelBottom!)
     }
     
}
