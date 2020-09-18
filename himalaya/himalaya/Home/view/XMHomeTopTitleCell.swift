//
//  XMHomeTopTitleCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class XMHomeTopTitleCell: UICollectionViewCell {
    
    private var labelTitle: UILabel?
    
    
    var title: String? {
        didSet {
            labelTitle?.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_230_20_color
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 17)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((5, 5, 5), (210, 210, 210))
        labelTitle?.xm_origin = CGPoint(x: 0, y: 0)
        labelTitle?.xm_size = CGSize(width: content_view_width, height: 40)
        labelTitle?.backgroundColor = contentView.backgroundColor
        labelTitle?.layer.masksToBounds = true
        
        contentView.addSubview(labelTitle!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//class XMHomeModuleDetailCell: UICollectionViewCell {
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        contentView.addSubview(collectionLayer)
//        contentView.addSubview(collectionView)
//        
//    }
//    
//    var isHiddenLayer: Bool = false {
//        didSet {
//            
//            collectionLayer.isHidden = isHiddenLayer
//        }
//    }
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        view.backgroundColor = .clear
//        view.alwaysBounceVertical = false
//        view.alwaysBounceHorizontal = true
//        view.showsHorizontalScrollIndicator = false
//        return view
//    }()
//    
//    
//    lazy var collectionLayer: UIView = {
//        let bg = UIView()
//        bg.backgroundColor = UIColor.xm.xm_255_30_color
//        bg.layer.cornerRadius = 5
//        bg.isHidden = true
//        return bg
//    }()
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        collectionView.frame = contentView.bounds
//        collectionLayer.frame = collectionView.bounds
//    }
//}

class XMHomeCatrgoryKeyWordCell: XMCommonCollectionViewCell {
    
    private var labelTitle: UILabel?
    private var btnWords = [UIButton]()
    private var lineView: UIView?
    private var scrollerView: UIScrollView?
    private let disposeBag = DisposeBag()
    
    var clickBtn: ((_ item: HomeHeaderItemData) -> ())?
    
    
    var layout: HomeLayout? {
        didSet {
            guard let items = layout?.heder.headerItem?.lists else {
                return
            }
            labelTitle?.text = layout?.heder.headerItem?.title
            var maxTopRight: CGFloat = 15
            var maxBottomRight: CGFloat = 15
            for (index, btn) in btnWords.enumerated() {
                if index < items.count {
                    btn.isHidden = false
                    let item = items[index]
                    btn.setAttributedTitle(item.attrTitle, for: UIControl.State.normal)
                    btn.xm_width = item.itemWidth
                    if maxTopRight > maxBottomRight {
                        btn.xm_x = maxBottomRight
                        btn.xm_y = 40
                        maxBottomRight = btn.xm_right + 10
                    }else if maxTopRight <= maxBottomRight {
                        btn.xm_x = maxTopRight
                        btn.xm_y = 0
                        maxTopRight = btn.xm_right + 10
                    }
                }else {
                    btn.isHidden = true
                }
            }
            let maxRight = max(maxTopRight, maxBottomRight)
            scrollerView?.contentSize = CGSize(width: maxRight > content_view_width ? maxRight + 5: 0, height: 0)
        }
    }
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        labelTitle = UILabel()
        labelTitle?.xm_size = CGSize(width: 80, height: 40)
        labelTitle?.font = UIFont.systemFont(ofSize: 13)
        labelTitle?.textAlignment = .center
        labelTitle?.xm_origin = CGPoint(x: ceil((contentView.xm_width - labelTitle!.xm_width) * 0.5), y: 0)
        labelTitle?.backgroundColor = UIColor.xm.xm_230_20_color
        labelTitle?.textColor = UIColor.xm.dynamicRGB((120, 120, 120), (160, 160, 160))

        lineView = UIView()
        lineView?.backgroundColor = UIColor.xm.dynamicRGB((230, 230, 230), (30, 30, 30))
        lineView?.xm_width = content_view_width
        lineView?.xm_height = 1
        lineView?.xm_x = xm_padding
        lineView?.xm_y = 20
        contentView.addSubview(lineView!)
        contentView.addSubview(labelTitle!)

        scrollerView = UIScrollView()
        scrollerView?.showsHorizontalScrollIndicator = false
        scrollerView?.xm_origin = CGPoint(x: 0, y: labelTitle!.xm_bottom)
        scrollerView?.xm_size = CGSize(width: contentView.xm_width, height: 70)
        contentView.addSubview(scrollerView!)

        for index in 0..<8 {
            let btn = UIButton(type: UIButton.ButtonType.custom)
            btn.backgroundColor = UIColor.xm.xm_255_30_color
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
            btn.setTitleColor(UIColor.black, for: UIControl.State.normal)
            btn.layer.cornerRadius = 3
            btn.layer.masksToBounds = true
            btn.layer.borderColor = UIColor.xm.dynamicRGB((230, 230, 230), (30, 30, 30)).cgColor
            btn.layer.borderWidth = 1
            btn.xm_y = index < 4 ? 0 : 40
            btn.xm_height = 30
            scrollerView?.addSubview(btn)
            btn.isHidden = true
//            btn.addTarget(self, action: #selector(action), for: T##UIControl.Event)
            btn.rx.tap.subscribe(onNext: {[weak self] (event) in
                if self?.clickBtn != nil {
                    guard let items = self?.layout?.heder.headerItem?.lists else {
                        return
                    }
                    self?.clickBtn!(items[index])
                }
            }).disposed(by: disposeBag)
            btnWords.append(btn)
        }
    }
}

class XMHomePersonFmCell: UICollectionViewCell {
    
    private var imageView: UIImageView?
    private var labelTitle: UILabel?
    private var labelDetail: UILabel?
    
    
    private var topView: UIImageView?
    private var labelTop: UILabel?
    
//    "greeting": "周一 今日热点",
//    "iting": "iting://open?msg_type=74&scene=29",
//    "pic": "http://fdfs.xmcdn.com/group53/M05/9F/B5/wKgLfFwIyO-TzgPtAAY0TXM3xf0699.png",
//    "title": "私人FM"
    //        var speciallabelDetailAttr: NSAttributedString?
    //           var pecialBottomAttr: NSAttributedString?
    var layout: HomeLayout? {
        didSet {
            guard let layout = layout else {
                return
            }
            topView?.isHidden = layout.topViewHidden
            labelTop?.text = layout.heder.headerItem?.title
            imageView?.frame = layout.imageViewFrame
            labelTitle?.frame = layout.labelTitleFrame
            labelDetail?.frame = layout.labelDetailFrame
            imageView?.setImage(urlString: layout.imageUrl, placeHolderName: "one_key_listen_scene")
            labelTitle?.attributedText = layout.speciallabelDetailAttr
            labelDetail?.attributedText = layout.pecialBottomAttr
        }
    }
    
//    160
    var guessItem: HomeHeaderItem? {
        didSet {
            imageView?.xm_size = CGSize(width: 100, height: 100)
            imageView?.xm_origin = CGPoint(x: content_view_width - imageView!.xm_width - xm_padding, y: 45)
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        topView = UIImageView()
        topView?.xm_origin = CGPoint(x: 0, y: 0)
        topView?.xm_size = CGSize(width: content_view_width, height: 40)
        topView?.isHidden = true
        topView?.backgroundColor = UIColor.xm.dynamicRGB((240, 240, 240), (40, 40, 40))
        contentView.addSubview(topView!)
        labelTop = UILabel()
        labelTop?.textColor = UIColor.colorWithrgba(142, 100, 59)
        labelTop?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTop?.xm_size = CGSize(width: topView!.xm_width - 30, height: 30)
        labelTop?.xm_origin = CGPoint(x: xm_padding, y: 10)
        topView?.addSubview(labelTop!)
        
        imageView = UIImageView()
        
        contentView.addSubview(imageView!)
        
        labelTitle = UILabel()
        contentView.addSubview(labelTitle!)
        
        labelDetail = UILabel()
        contentView.addSubview(labelDetail!)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

