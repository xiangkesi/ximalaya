//
//  XMVipCardCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMVipCardCell: UICollectionViewCell {
    
    
    private var mainView: UIView?
    private var imageHeadView: UIImageView?
    private var btnRenewal: UIButton?
    private var labelTitle: UILabel?
    private var labelDetail: UILabel?
    
    
    private var imageViews = [UIImageView]()
    
    
    private var labelDesc: UILabel?
    
    
    var layout: XMVipLayout? {
        didSet {
            labelTitle?.text = layout?.module?.propertieModel?.greetText
            labelDetail?.text = layout?.module?.propertieModel?.guideText
            btnRenewal?.setTitle(layout?.module?.propertieModel?.buttonText, for: UIControl.State.normal)
            labelDesc?.text = layout?.module?.propertieModel?.rightDetailsText
            
            if let models = layout?.module?.propertieModel?.entrances {
                for index in 0..<imageViews.count {
                    let imageView = imageViews[index]
                    if index < models.count {
                        imageView.isHidden = false
                        let model = models[index]
                        imageView.setImage(urlString: model.icon, placeHolderName: nil)
                    }else {
                        imageView.isHidden = true
                    }
                }
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainView = UIView()
//        mainView?.isUserInteractionEnabled = true
        mainView?.xm_origin = CGPoint(x: xm_padding, y: 0)
        mainView?.xm_size = CGSize(width: content_view_width, height: 130)
        let imageBg = UIImageView()
        imageBg.frame = mainView!.bounds
        imageBg.backgroundColor = UIColor.colorWidthHexString(hex: "D7D4CF")
        imageBg.layer.cornerRadius = 5
        mainView?.addSubview(imageBg)
        addSubview(mainView!)
        
        let imageViewBg = UIImageView()
        imageViewBg.xm_size = CGSize(width: 40, height: ceil(40 * 1.375))
        imageViewBg.xm_origin = CGPoint(x: xm_padding, y: xm_padding + 20)
        imageViewBg.image = UIImage(named: "find_not_vip_flag")
        mainView?.addSubview(imageViewBg)
        imageHeadView = UIImageView()
        imageHeadView?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        imageHeadView?.xm_size = CGSize(width: 40, height: 40)
        imageHeadView?.image = UIImage(named: "find_vip_default_icon")
        mainView?.addSubview(imageHeadView!)
        
        
        btnRenewal = UIButton(type: UIButton.ButtonType.custom)
        btnRenewal?.xm_size = CGSize(width: 60, height: 24)
        btnRenewal?.xm_origin = CGPoint(x: mainView!.xm_width - btnRenewal!.xm_width - xm_padding, y: xm_padding)
        btnRenewal?.layer.cornerRadius = 12
        btnRenewal?.backgroundColor = UIColor.colorWidthHexString(hex: "464958")
        btnRenewal?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btnRenewal?.setTitleColor(UIColor.colorWidthHexString(hex: "F5DCBA"), for: UIControl.State.normal)
        mainView?.addSubview(btnRenewal!)
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTitle?.textColor = UIColor.colorWidthHexString(hex: "747D82")
        labelTitle?.xm_origin = CGPoint(x: imageHeadView!.xm_right + 10, y: imageHeadView!.xm_y + 5)
        labelTitle?.xm_size = CGSize(width: btnRenewal!.xm_x - labelTitle!.xm_x, height: 18)
        mainView?.addSubview(labelTitle!)
        
        labelDetail = UILabel()
        labelDetail?.xm_size = CGSize(width: mainView!.xm_width - labelTitle!.xm_x, height: 14)
        labelDetail?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: imageHeadView!.xm_bottom)
        labelDetail?.font = UIFont.systemFont(ofSize: 13)
        labelDetail?.textColor = UIColor.colorWidthHexString(hex: "999999")
        mainView?.addSubview(labelDetail!)
        
        
        var lastImageView: UIImageView?
        
        for index in 0..<3 {
            let imageView = UIImageView()
            imageView.isHidden = true
            imageView.xm_size = CGSize(width: 30, height: 30)
            imageView.xm_y = mainView!.xm_bottom - imageView.xm_height - 10
            imageView.xm_x = xm_padding + CGFloat(index) * (6 + imageView.xm_width)
            mainView?.addSubview(imageView)
            imageViews.append(imageView)
            lastImageView = imageView
        }
        
        labelDesc = UILabel()
        labelDesc?.xm_size = CGSize(width: mainView!.xm_width - lastImageView!.xm_right - xm_padding - 10, height: 30)
        labelDesc?.xm_origin = CGPoint(x: mainView!.xm_width - labelDesc!.xm_width - xm_padding, y: lastImageView!.xm_y)
        labelDesc?.font = UIFont.systemFont(ofSize: 13)
        labelDesc?.textColor = UIColor.colorWidthHexString(hex: "999999")
        labelDesc?.textAlignment = .center
        mainView?.addSubview(labelDesc!)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMVipFuncCell: UICollectionViewCell {
    
    var imageView: UIImageView?
    var labelTitle: UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        contentView.addSubview(imageView!)
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.systemFont(ofSize: 13)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((30, 30, 30), (200, 200, 200))
        labelTitle?.textAlignment = .center
        contentView.addSubview(labelTitle!)
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageViewWH: CGFloat = ceil(xm_width - xm_width * 0.36)
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

class XMVipSquarePictureCell: UICollectionViewCell {
    
    private var imageLeftView: UIImageView?
    private var imageRightView: UIImageView?
    
    var layout: XMVipLayout? {
        didSet {
            if let lists = layout?.module?.lists {
                if let firstList = lists.first {
                    imageLeftView?.setWebpImage(urlString: firstList.icon, placeHolderName: "find_albumcell_cover_bg")
                }
                if let lastList = lists.last {
                    imageRightView?.setWebpImage(urlString: lastList.icon, placeHolderName: "find_albumcell_cover_bg")
                }
            }
        }
    }
    
//    0.436
    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageViewW = ceil((content_view_width - 20) * 0.5)
        let imageViewH = floor(imageViewW * 0.436)
        
        imageLeftView = UIImageView()
        imageLeftView?.xm_size = CGSize(width: imageViewW, height: imageViewH)
        imageLeftView?.xm_origin = CGPoint(x: xm_padding, y: 0)
        contentView.addSubview(imageLeftView!)
        
        imageRightView = UIImageView()
        imageRightView?.xm_size = imageLeftView!.xm_size
        imageRightView?.xm_origin = CGPoint(x: imageLeftView!.xm_right + 20, y: 0)
        contentView.addSubview(imageRightView!)
        
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//HISTORY

class XMVipHistoryTitleCell: UICollectionViewCell {
    
    var labelTitle: UILabel?
    private var buttonMore: UIButton?
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((10, 10, 10), (210, 210, 210))
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: 0)
        labelTitle?.xm_size = CGSize(width: 150, height: 40)
        contentView.addSubview(labelTitle!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XMVipHistoryListenCell: UICollectionViewCell {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = true
        view.showsHorizontalScrollIndicator = false
        self.contentView.addSubview(view)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
}

class XMVipHistoryListenDetailCell: UICollectionViewCell {
    
    private var imageView: UIImageView?
    private var labelTitle: UILabel?
    private var labelDetail: UILabel?
    
    private var labelLeft: UILabel?
    private var imageListen: UIImageView?
    
    
    var record: XMVipRecordListModel? {
        didSet {
            imageView?.setWebpImage(urlString: record?.albumCoverPath, placeHolderName: "find_albumcell_cover_bg")
            labelTitle?.text = record?.albumTitle
            labelDetail?.text = record?.trackTitle
            labelLeft?.text = "已收听\(record?.finished ?? 0)"
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.layer.cornerRadius = 5
        imageView = UIImageView()
        imageView?.xm_size = CGSize(width: 40, height: 40)
        imageView?.xm_origin = CGPoint(x: 10, y: xm_padding)
        contentView.addSubview(imageView!)
        
        let cellWidth = UIDevice.isPad ? 300 : ceil(content_view_width * 0.8)
        let cellHeight: CGFloat = 110
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: imageView!.xm_right + 10, y: imageView!.xm_y)
        labelTitle?.xm_size = CGSize(width: cellWidth - labelTitle!.xm_x - xm_padding, height: 20)
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (210, 210, 210))
        contentView.addSubview(labelTitle!)
        
        labelDetail = UILabel()
        labelDetail?.xm_size = CGSize(width: labelTitle!.xm_width, height: 20)
        labelDetail?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: imageView!.xm_bottom - labelDetail!.xm_height)
        labelDetail?.font = UIFont.systemFont(ofSize: 13)
        labelDetail?.textColor = UIColor.xm.dynamicRGB((100, 100, 100), (130, 130, 130))
        contentView.addSubview(labelDetail!)
//        100
        
        labelLeft = UILabel()
        labelLeft?.xm_size = CGSize(width: ceil(cellWidth * 0.5), height: 14)
        labelLeft?.xm_origin = CGPoint(x: 10, y: cellHeight - labelLeft!.xm_height - 10)
        labelLeft?.font = UIFont.systemFont(ofSize: 12)
        labelLeft?.textColor = UIColor.xm.dynamicRGB((100, 100, 100), (130, 130, 130))
        contentView.addSubview(labelLeft!)
        
        imageListen = UIImageView()
        imageListen?.xm_size = CGSize(width: 26, height: 26)
        imageListen?.xm_origin = CGPoint(x: cellWidth - imageListen!.xm_width - 10, y: cellHeight - imageListen!.xm_height - 10)
        imageListen?.image = UIImage(named: "newer_rec_video_play")
        contentView.addSubview(imageListen!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class XMVipInsterestMabyLikeView: UIView {
    
    fileprivate var labelTitle: UILabel?
    fileprivate var btnBottom: UIButton?
    fileprivate var btns = [UIButton]()
    
    override init(frame: CGRect) {
        var selfFrame = CGRect.zero
        if selfFrame.size == CGSize(width: 0, height: 0) {
            let selfWidth: CGFloat = ceil((content_view_width - 10) * 0.5)
            let selfHeight: CGFloat = ceil(selfWidth * 1.2)
            
            selfFrame.size = CGSize(width: selfWidth, height: selfHeight)
        }
        super.init(frame: selfFrame)
        backgroundColor = UIColor.xm.xm_255_30_color
        layer.cornerRadius = 5
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 17)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (220, 220, 220))
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        labelTitle?.xm_size = CGSize(width: xm_width - 30, height: 26)
        addSubview(labelTitle!)
        let imageView = UIImageView()
        imageView.xm_size = CGSize(width: 40, height: 40)
        imageView.xm_origin = CGPoint(x: xm_width - imageView.xm_width - xm_padding, y: labelTitle!.xm_y)
        imageView.image = UIImage(named: "icon-vip-like")
        addSubview(imageView)
        
        let btnW: CGFloat = ceil((xm_width - 40) * 0.5)
        let btnH: CGFloat = 26
        let btnTop = (xm_height - (btnH * 3 + 20)) * 0.5 + 10
        let margen: CGFloat = 10
        
        for index in 0..<6 {
            let btn = UIButton(type: UIButton.ButtonType.custom)
            btns.append(btn)
            btn.layer.cornerRadius = 13
            btn.layer.borderWidth = 1
            btn.layer.borderColor = UIColor.colorWidthHexString(hex: mainColorString).cgColor
            let row = index / 2
            let col = index % 2
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
            btn.setTitleColor(UIColor.colorWidthHexString(hex: mainColorString), for: UIControl.State.normal)
            btn.xm_size = CGSize(width: btnW, height: btnH)
            btn.xm_x = xm_padding + ceil((btnW + margen) * CGFloat(col))
            btn.xm_y = btnTop + ceil((btnH + margen) * CGFloat(row))
            addSubview(btn)
        }
        
        btnBottom = UIButton(type: UIButton.ButtonType.custom)
        
        btnBottom?.xm_size = CGSize(width: xm_width - 30, height: 30)
        let btnsBottom = (btnH * 3 + 20) + btnTop
        let btnY = ceil((xm_height - btnsBottom - 30) * 0.5 + btnsBottom)
        btnBottom?.xm_origin = CGPoint(x: xm_padding, y: btnY)
        btnBottom?.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        btnBottom?.setTitleColor(UIColor.colorWidthHexString(hex: "333333"), for: UIControl.State.normal)
        btnBottom?.setTitle("选择感兴趣的主题>", for: UIControl.State.normal)
        btnBottom?.contentHorizontalAlignment = .left
        addSubview(btnBottom!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMViphotWordModuleView: UIView {
    
    fileprivate var labelTitle: UILabel?
    fileprivate var btns = [UIButton]()
    override init(frame: CGRect) {
        var selfFrame = CGRect.zero
        if selfFrame.size == CGSize(width: 0, height: 0) {
            let selfWidth: CGFloat = ceil((content_view_width - 10) * 0.5)
            let selfHeight: CGFloat = ceil(selfWidth * 1.2)
            selfFrame.size = CGSize(width: selfWidth, height: selfHeight)
        }
        super.init(frame: selfFrame)
        
//        backgroundColor = UIColor.white
//        layer.cornerRadius = 5
        let imageBg = UIImageView()
        imageBg.frame = CGRect(origin: .zero, size: xm_size)
        imageBg.layer.cornerRadius = 5
        imageBg.layer.masksToBounds = true
        if let image = UIImage(named: "album_tag_vip_forstall_bg_iphone") {
            let finalImage = image.resizableImage(withCapInsets: UIEdgeInsets(top: 1, left: 1, bottom: 2, right: 2), resizingMode: UIImage.ResizingMode.stretch)
            imageBg.image = finalImage
        }
        addSubview(imageBg)
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 17)
        labelTitle?.textColor = UIColor.white
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        labelTitle?.xm_size = CGSize(width: xm_width - 30, height: 26)
        addSubview(labelTitle!)
        
        let btnWidth: CGFloat = (xm_width - 30)
        let btnHeight: CGFloat = 28
        let btnTop: CGFloat = ceil(xm_height - btnHeight * 5 - 25)
        let imageDouhao = UIImageView()
        imageDouhao.xm_size = CGSize(width: 16, height: 10)
        imageDouhao.xm_origin = CGPoint(x: labelTitle!.xm_x, y: btnTop - imageDouhao.xm_height)
        imageDouhao.image = UIImage(named: "icon-vip-dt")
        addSubview(imageDouhao)
        
        for index in 0..<5 {
            let btn = UIButton(type: UIButton.ButtonType.custom)
            btns.append(btn)
            btn.xm_size = CGSize(width: btnWidth, height: btnHeight)
            btn.xm_x = xm_padding
            btn.xm_y = btnTop + btnHeight * CGFloat(index)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
            btn.contentHorizontalAlignment = .left
            addSubview(btn)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMVipInsterestCell: UICollectionViewCell {
//    XMViphotWordModuleView
    private var mabyLikeView: XMVipInsterestMabyLikeView?
    private var wordMouleView: XMViphotWordModuleView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        mabyLikeView = XMVipInsterestMabyLikeView()
        mabyLikeView?.xm_origin = CGPoint(x: xm_padding, y: 0)
        contentView.addSubview(mabyLikeView!)
        
        wordMouleView = XMViphotWordModuleView()
        wordMouleView?.xm_origin = CGPoint(x: mabyLikeView!.xm_right + 10, y: 0)
        contentView.addSubview(wordMouleView!)
    }
    
    
    var album: XMVipBodyAlbumListAdModel? {
        didSet {
            mabyLikeView?.labelTitle?.text = album?.interestModuleModel?.moduleTitle
            if let models = album?.interestModuleModel?.interestModuleDetailModel {
                for (index, btn) in mabyLikeView!.btns.enumerated(){
                    if index < models.count {
                        let model = models[index]
                        btn.setTitle(model.name, for: UIControl.State.normal)
                    }
                }
            }
            
            wordMouleView?.labelTitle?.text = album?.hotWordModuleModel?.moduleTitle
            if let words = album?.hotWordModuleModel?.hotWordModuleModels {
                           for (index, btn) in wordMouleView!.btns.enumerated() {
                               if index < wordMouleView!.btns.count {
                                   let word = words[index]
                                btn.setTitle("\(index)." + (word.name ?? ""), for: UIControl.State.normal)
                                   
                               }
                           }
            }
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
