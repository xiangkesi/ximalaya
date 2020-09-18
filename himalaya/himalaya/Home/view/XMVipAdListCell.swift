//
//  XMVipAdListCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/21.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMVipAdListCell: UICollectionViewCell {
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        contentView.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.xm_origin = CGPoint(x: xm_padding, y: 0)
        imageView.xm_size = CGSize(width: contentView.xm_width - 30, height: contentView.xm_height)
    }
}

class XMVipFilmTelevisionCell: UICollectionViewCell {
    
    
    private var imageViewBg: UIImageView?
    private var imageRightView: UIImageView?
    
    private var labelTop: UILabel?
    private var views = [XMCommonGuessLikeView]()
    
    var layout: XMVipAlbumLayout? {
        didSet {
            labelTop?.attributedText = layout?.albumTitleAttr
            if let albums = layout?.album.adModel?.albums, albums.count > 0 {
                for (index, view) in views.enumerated() {
                    if index < albums.count {
                        view.isHidden = false
                        let album = albums[index]
                        view.mainView?.imageView.setWebpImage(urlString: album.coverPath, placeHolderName: "find_albumcell_cover_bg")
                        view.labelTitle?.xm_height = album.titleAttrHeight
                        view.labelTitle?.attributedText = album.titleAttr
                    }else {
                        view.isHidden = true
                    }
                }
            }
        }
    }
   
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cell_width = ceil((content_view_width - 40) / 3)
        let cell_height = cell_width + 160
        imageViewBg = UIImageView()
        imageViewBg?.layer.cornerRadius = 5
        imageViewBg?.layer.masksToBounds = true
        imageViewBg?.image = UIImage(named: "plu_header")
        imageViewBg?.frame = CGRect(origin: CGPoint(x: xm_padding, y: 0), size: CGSize(width: content_view_width, height: cell_height))
        contentView.addSubview(imageViewBg!)
        
        imageRightView = UIImageView()
        imageRightView?.xm_size = CGSize(width: 70, height: 31)
        imageRightView?.xm_origin = CGPoint(x: imageViewBg!.xm_right - imageRightView!.xm_width, y: 0)
        imageRightView?.image = UIImage(named: "find_vip_aggregate_icon")
        contentView.addSubview(imageRightView!)
        
        labelTop = UILabel()
        labelTop?.xm_size = CGSize(width: content_view_width - 30, height: 40)
        labelTop?.xm_origin = CGPoint(x: xm_padding * 2, y: 20)
        labelTop?.numberOfLines = 2
        contentView.addSubview(labelTop!)
        
        
        
        let cell_detailheight = cell_width + 60
        
        for index in 0..<3 {
            let c_view = XMCommonGuessLikeView()
            c_view.xm_y = labelTop!.xm_bottom + 20
            c_view.xm_size = CGSize(width: cell_width, height: cell_detailheight)
            c_view.xm_x = xm_padding * 2 + (cell_width + 5) * CGFloat(index)
            contentView.addSubview(c_view)
            views.append(c_view)
        }
        
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMVipClassificationDetailCell: UIView {
    
    var labelRank: UILabel?
    var labeTitle: UILabel?
    override init(frame: CGRect) {
        var selfFrame = frame
        if selfFrame.size == CGSize(width: 0, height: 0) {
            selfFrame.size = CGSize(width: 290, height: 38)
        }
        super.init(frame: selfFrame)
        labelRank = UILabel()
        labelRank?.xm_size = CGSize(width: 20, height: xm_height)
        labelRank?.xm_origin = CGPoint(x: xm_padding, y: 0)
        labelRank?.textAlignment = .center
        labelRank?.font = UIFont(name: "Helvetica-Bold", size: 16)
        addSubview(labelRank!)
        
        labeTitle = UILabel()
        labeTitle?.xm_width = xm_width - labelRank!.xm_bottom - 50
        labeTitle?.textColor = UIColor.white
        labeTitle?.font = UIFont.systemFont(ofSize: 12)
        labeTitle?.xm_x = labelRank!.xm_right + xm_padding
        labeTitle?.xm_y = 0
        labeTitle?.xm_height = xm_height
        addSubview(labeTitle!)
        
        let line = CALayer()
        line.xm_size = CGSize(width: xm_width - 30, height: 1)
        line.xm_origin = CGPoint(x: xm_padding, y: xm_height - line.xm_height)
        line.backgroundColor = UIColor.init(white: 0.6, alpha: 0.2).cgColor
        layer.addSublayer(line)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMVipClassificationCell: UICollectionViewCell {
    
    private var imageView: UIImageView?
    
    private var labelTop: UILabel?
    private var labelTopDesc: UILabel?
    private var labelRight: UILabel?
    private var detailCells = [XMVipClassificationDetailCell]()
    
    
    var rankTable: XMVipModuleRankTableModel? {
        didSet {
            labelTop?.text = rankTable?.name
            labelRight?.text = rankTable?.updateTime
            imageView?.image = UIImage(named: (rankTable?.imageName)!)
            if let items = rankTable?.items, items.count > 0 {
                for (index, view) in detailCells.enumerated() {
                    if index < items.count {
                        let item = items[index]
                        view.labeTitle?.text = item.title
                    }
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        imageView?.xm_size = CGSize(width: 290, height: 290)
        imageView?.xm_origin = CGPoint(x: 0, y: 0)
        imageView?.image = UIImage(named: "find_vip_rank_bg_0")
        contentView.addSubview(imageView!)
        let layerBg = CALayer()
        layerBg.backgroundColor = UIColor.init(white: 0.1, alpha: 0.4).cgColor
        layerBg.frame = imageView!.bounds
        layerBg.cornerRadius = 5
        imageView?.layer.addSublayer(layerBg)
        
        labelTop = UILabel()
        labelTop?.font = UIFont(name: "Helvetica-Bold", size: 18)
        labelTop?.textColor = UIColor.white
        labelTop?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        labelTop?.xm_size = CGSize(width: 260, height: 25)
        contentView.addSubview(labelTop!)
        
        labelTopDesc = UILabel()
        labelTopDesc?.font = UIFont(name: "Helvetica-Bold", size: 18)
        labelTopDesc?.xm_origin = CGPoint(x: xm_padding, y: labelTop!.xm_bottom + 5)
        labelTopDesc?.xm_size = CGSize(width: 100, height: 25)
        labelTopDesc?.textColor = UIColor.white
//        labelTopDesc?.backgroundColor = UIColor.red
        labelTopDesc?.text = "Top 5"
        contentView.addSubview(labelTopDesc!)
        
        labelRight = UILabel()
        labelRight?.font = UIFont.systemFont(ofSize: 12)
        labelRight?.textColor = UIColor.colorWithrgba(200, 200, 200)
        labelRight?.xm_size = CGSize(width: 125, height: 25)
        labelRight?.xm_origin = CGPoint(x: 150, y: labelTopDesc!.xm_y)
        labelRight?.textAlignment = .right
        contentView.addSubview(labelRight!)
        
        let titles:[(String, (CGFloat, CGFloat, CGFloat))] = [("1", (230, 86, 47)),
                                                              ("2", (236, 148, 71)),
                                                              ("3", (245, 203, 70)),
                                                              ("4", (255, 255, 255)),
                                                              ("5", (255, 255, 255))]
        
        for (index, title) in titles.enumerated() {
            let view = XMVipClassificationDetailCell()
            view.labelRank?.text = title.0
            view.labelRank?.textColor = UIColor.colorWithrgba(title.1.0, title.1.1, title.1.2)
            view.xm_x = 0
            view.xm_y = 86 + CGFloat(index) * view.xm_height
            contentView.addSubview(view)
            detailCells.append(view)
        }
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

