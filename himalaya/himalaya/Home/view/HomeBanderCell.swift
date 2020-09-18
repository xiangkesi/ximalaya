//
//  HomeBanderCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/6.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol HomeBanderCellDelegate: NSObjectProtocol {
   func clickCell(cell: HomeBanderCell, atIndex index: Int)
}

class HomeBanderCell: UICollectionViewCell {
    
    private var banderView: FSPagerView?
    private var pageControl: FSPageControl?
    
     weak var delegate: HomeBanderCellDelegate?
    
    var imageUrls: [String]? {
        didSet {
            if let urls = imageUrls, urls.count > 0 {
                if urls.count == 1 {
                    banderView?.automaticSlidingInterval = 0
                    pageControl?.isHidden = true
                    banderView?.isInfinite = false
                }else {
                    pageControl?.xm_width = CGFloat(urls.count * 14)
                    pageControl?.xm_centerX = banderView!.xm_centerX
                    pageControl?.numberOfPages = urls.count
                }
                banderView?.reloadData()
            }
        }
    }
    
    var isShowOnScreen: Bool = true {
        didSet {
            guard let urls = imageUrls else {
                return
            }
            if urls.count == 1 {
                return
            }

            if isShowOnScreen == true {
                banderView?.automaticSlidingInterval = 6
            }else {
                banderView?.automaticSlidingInterval = 0
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeBanderCell: FSPagerViewDelegate, FSPagerViewDataSource {
    private func initWithSubviews() {
        banderView = FSPagerView()
        banderView?.register(XMPagerViewCell.self, forCellWithReuseIdentifier: "XMPagerViewCell")
        
        
        banderView?.itemSize = CGSize(width: content_view_width, height: ceil(content_view_width * 0.4))
        banderView?.delegate = self
        banderView?.dataSource = self
        banderView?.automaticSlidingInterval = 6
        banderView?.isInfinite = true
        banderView?.xm_origin = CGPoint(x: 0, y: 0)
        banderView?.xm_width = xm_screen_width
        banderView?.xm_height = ceil(content_view_width * 0.4)
        banderView?.backgroundColor = UIColor.xm.dynamicRGB((230, 230, 230), (20, 20, 20))
        banderView?.interitemSpacing = xm_padding
        contentView.addSubview(banderView!)
        
        pageControl = FSPageControl()
        pageControl?.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
//        pageControl?.xm_size = CGSize(width: 120, height: 16)
        pageControl?.xm_height = 16
//        pageControl?.strokeColors = UIColor.red
//        pageControl?.fillColors = UIColor.purple
        pageControl?.layer.cornerRadius = 8
        
        pageControl?.contentHorizontalAlignment = .center
        pageControl?.contentInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        pageControl?.hidesForSinglePage = true
        pageControl?.xm_origin = CGPoint(x: ceil((banderView!.xm_width - pageControl!.xm_width) * 0.5), y: ceil(banderView!.xm_height - pageControl!.xm_height - 10))
        banderView?.addSubview(pageControl!)
    }
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return  imageUrls?.count ?? 0
    }
       
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "XMPagerViewCell", at: index)
        if let urlStr = imageUrls?[index] {
            cell.imageView?.setImage(urlString: urlStr, placeHolderName: "new_playpage_default_wide")
        }
        return cell
    }
       
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
       if let delegate = delegate {
            delegate.clickCell(cell: self, atIndex: index)
        }
    }
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl?.currentPage = targetIndex
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageControl?.currentPage = pagerView.currentIndex
    }
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        
    }
}

class XMPagerViewCell: FSPagerViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.layer.cornerRadius = 5
        self.imageView?.layer.masksToBounds = true
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


protocol HomeFunctionContentCellDelegate: NSObjectProtocol {
    func clickCell(cell: HomeFunctionContentCell, item: HomeHeaderItemData, index: Int)
}
class HomeFunctionContentCell: UICollectionViewCell {
    
    weak var delegate: HomeFunctionContentCellDelegate?
    
    private var cellArray = [HomeFunctionCell]()
    private let disposeBag = DisposeBag()
    var lists: [HomeHeaderItemData]? {
        didSet {
            if let list = lists, list.count > 0 {
                for index in 0..<cellArray.count {
                    let cell = cellArray[index]
                    if index < list.count {
                        let item = list[index]
                        cell.item = item
//                        if index == 2 {
//                            cell.imageView?.image = UIImage(named: "siri_suggest_sleep")
//                        }else {
//                            
//                        }
                        cell.imageView?.setImage(urlString: item.coverPath, placeHolderName: "find_vip_default_icon")
                        cell.labelTitle?.text = item.title
                        cell.isHidden = false
                    }else {
                        cell.isHidden = true
                    }
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        let itemWH = floor(content_view_width * 0.2)
        for index in 0..<5 {
            let cell = HomeFunctionCell()
            let tap = UITapGestureRecognizer()
            cell.addGestureRecognizer(tap)
            tap.rx.event.subscribe(onNext: {[weak self] (event) in
                if let delegate = self?.delegate {
                    delegate.clickCell(cell: self!, item: cell.item!, index: index)
                }
            }).disposed(by: disposeBag)
            cell.xm_size = CGSize(width: itemWH, height: itemWH)
            cell.xm_origin = CGPoint(x: CGFloat(index) * itemWH + xm_padding, y: 0)
            cell.isHidden = true
            contentView.addSubview(cell)
            cellArray.append(cell)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeFunctionCell: UIView {
        
    
    var item: HomeHeaderItemData?
    
    var imageView: UIImageView?
    var labelTitle: UILabel?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        addSubview(imageView!)
        labelTitle = UILabel()
        labelTitle?.font = UIFont.systemFont(ofSize: 12)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((30, 30, 30), (150, 150, 150))
        labelTitle?.textAlignment = .center
        labelTitle?.backgroundColor = UIColor.xm.xm_230_20_color
        labelTitle?.layer.masksToBounds = true
        addSubview(labelTitle!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageViewWH: CGFloat = ceil(xm_width - xm_width * 0.3)
        let labelTitleH: CGFloat = 20
        let spading: CGFloat = 0
        
        
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

class HomeHotCell: UICollectionViewCell {
    
    private var mainView: UIView?
    
    private var imageLeftView: UIImageView?
    private var labelTitle: UILabel?
    private var imageGifView: UIImageView?
    
    private var labelDetail: XMPageTextView?
    
    
    var layout: HomeLayout? {
        didSet {
            if let _ = layout {
                labelTitle?.xm_width = layout!.greetingsWidth
                labelTitle?.attributedText = layout?.greetingsAttr
                imageGifView?.xm_x = labelTitle!.xm_right
                
                if let array = layout?.heder.headerItem?.titles {
                    labelDetail?.titles = array
                }
            }
            
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainView = UIView()
        mainView?.backgroundColor = UIColor.xm.dynamicRGB((255, 255, 255), (30, 30, 30))
        mainView?.layer.cornerRadius = 5
        mainView?.layer.masksToBounds = false
        mainView?.xm_origin = CGPoint(x: xm_padding, y: 0)
        let mainViewH: CGFloat = contentView.xm_height
        mainView?.xm_size = CGSize(width: content_view_width, height: mainViewH)
        contentView.addSubview(mainView!)
        
        imageLeftView = UIImageView()
        imageLeftView?.image = UIImage(named: "new_ttt_play")
        imageLeftView?.xm_origin = CGPoint(x: 10, y: 15)
        imageLeftView?.xm_size = CGSize(width: mainViewH - 30, height: mainViewH - 30)
        mainView?.addSubview(imageLeftView!)
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 6, height: 6)
        layer.cornerRadius = 3
        layer.backgroundColor = UIColor.colorWidthHexString(hex: mainColorString).cgColor
        imageLeftView?.layer.addSublayer(layer)
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: imageLeftView!.xm_right + 10, y: 13)
        labelTitle?.xm_size = CGSize(width: 0, height: 16)
        mainView?.addSubview(labelTitle!)
        
        imageGifView = UIImageView()
        imageGifView?.xm_size = CGSize(width: 14, height: 14)
        imageGifView?.xm_origin = CGPoint(x: labelTitle!.xm_right, y: labelTitle!.xm_y)
        mainView?.addSubview(imageGifView!)
        let urlPath = Bundle.main.url(forResource: "sound_playingbtn", withExtension: "gif")
        imageGifView?.kf.setImage(with: urlPath)
        
        
        let imageArrowView = UIImageView()
        imageArrowView.image = UIImage(named: "ad_arrow_right")
        imageArrowView.xm_size = CGSize(width: 6, height: 10)
        imageArrowView.xm_origin = CGPoint(x: mainView!.xm_width - 20, y: ceil((mainViewH - 10) * 0.5))
        mainView?.addSubview(imageArrowView)
        
        let labelContent = UILabel()
        labelContent.font = UIFont.boldSystemFont(ofSize: 13)
        labelContent.textColor = UIColor.colorWidthHexString(hex: mainColorString)
        labelContent.text = "私人FM"
        labelContent.sizeToFit()
        labelContent.xm_size = CGSize(width: ceil(labelContent.xm_width), height: ceil(labelContent.xm_height))
        labelContent.xm_y = ceil((mainViewH - labelContent.xm_height) * 0.5)
        labelContent.xm_x = imageArrowView.xm_x - labelContent.xm_width - 10
        mainView?.addSubview(labelContent)
        
        let imageViewRight = UIImageView()
        imageViewRight.image = UIImage(named: "fmChannel")
        imageViewRight.xm_size = CGSize(width: ceil(mainViewH * 0.375), height: mainViewH)
        imageViewRight.xm_origin = CGPoint(x: labelContent.xm_x - imageViewRight.xm_width - 10, y: 0)
        mainView?.addSubview(imageViewRight)
        
        labelDetail = XMPageTextView(frame: CGRect(x: labelTitle!.xm_x, y: labelTitle!.xm_bottom + 4, width: imageViewRight.xm_x - labelTitle!.xm_x, height: 14))
        labelDetail?.delegate = self
        mainView?.addSubview(labelDetail!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeHotCell: XMPageTextViewDelegate {
    func scollerTextView(textView: XMPageTextView, index: Int) {
        if let items = layout?.heder.headerItem?.lists {
            let track = items[index]
            layout?.track = track.track
        }
    }    
}


class HomeGuessLikeContentTopView: UIView {
    
    
    private let disposeBag = DisposeBag()
    
    private var labelTitle: UILabel?
    private var btnChooseInterest: UIButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        labelTitle = UILabel()
        addSubview(labelTitle!)
        
        btnChooseInterest = UIButton(type: UIButton.ButtonType.custom)
        btnChooseInterest?.setTitle("更多》", for: UIControl.State.normal)
        btnChooseInterest?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btnChooseInterest?.setTitleColor(UIColor.xm.dynamicRGB((100, 100, 100), (100, 100, 100)), for: UIControl.State.normal)
        btnChooseInterest?.contentHorizontalAlignment = .right
        btnChooseInterest?.rx.tap.subscribe(onNext: {
            
        }).disposed(by: disposeBag)
        addSubview(btnChooseInterest!)
    }
    
    var attrStr: NSAttributedString? {
        didSet {
            labelTitle?.attributedText = attrStr
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelTitle?.frame = CGRect(x: 10, y: 0, width: 100, height: xm_height)
        btnChooseInterest?.frame = CGRect(x: xm_width - 70, y: 0, width: 60, height: xm_height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol HomeGuessLikeContentCellDelegate: NSObjectProtocol {
    func clickCell(cell: HomeGuessLikeContentCell, item: HomeHeaderItemData)
    
    func clickHeadMore(cell: HomeGuessLikeContentCell)
}
class HomeGuessLikeContentCell: UICollectionViewCell {
    
    private let disposeBag = DisposeBag()
    weak var delegate: HomeGuessLikeContentCellDelegate?
    private var cellArray = [XMCommonGuessLikeView]()
    private var topView: HomeGuessLikeContentTopView?
    private var exchangeBtn: UIButton?
    
    
    var layout: HomeLayout? {
        didSet {
            topView?.attrStr = layout?.titleGuessAttr
            if let lists = layout?.heder.headerItem?.lists, lists.count > 0 {
                for index in 0..<cellArray.count {
                    let cell = cellArray[index]
                    if index < lists.count {
                        let item = lists[index]
                        cell.mainView?.imageView.setWebpImage(urlString: item.pic, placeHolderName: "find_albumcell_cover_bg")
                        cell.labelTitle?.xm_height = item.attrTitleHeight
                        cell.labelTitle?.attributedText = item.attrTitle
                        cell.isHidden = false
                    }else {
                        cell.isHidden = true
                    }
                }
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        let mainView = UIView()
        mainView.backgroundColor = UIColor.xm.dynamicRGB((255, 255, 255), (30, 30, 30))
        mainView.layer.cornerRadius = 5
        mainView.layer.masksToBounds = false
        mainView.xm_origin = CGPoint(x: xm_padding, y: 0)
        mainView.xm_size = CGSize(width: content_view_width, height: contentView.xm_height)
        contentView.addSubview(mainView)
        topView = HomeGuessLikeContentTopView()
        topView?.xm_origin = CGPoint(x: 0, y: 0)
        topView?.xm_size = CGSize(width: mainView.xm_width, height: 40)
        mainView.addSubview(topView!)
        
        let cellWidth = UIDevice.isPad ? floor((mainView.xm_width - 70) / 6) : floor((mainView.xm_width - 40) / 3)
        let cellHeight = cellWidth + 60
        
        var lastCell: XMCommonGuessLikeView?
        for index in 0..<6 {
            let cell = XMCommonGuessLikeView()
            let tap = UITapGestureRecognizer()
            tap.rx.event.subscribe(onNext: {[weak self] (event) in
                if let lists = self?.layout?.heder.headerItem?.lists, lists.count > 0 {
                    if let delegate = self?.delegate {
                        delegate.clickCell(cell: self!, item: lists[index])
                    }
                }
            }).disposed(by: disposeBag)
            cell.addGestureRecognizer(tap)
            cell.isHidden = true
            cell.xm_size = CGSize(width: cellWidth, height: cellHeight)
            let margin: CGFloat = 10
            var cellX: CGFloat = 0
            var cellY: CGFloat = 0
            if UIDevice.isPad {
                cellY = topView!.xm_bottom
                cellX = margin + floor((cellWidth + margin) * CGFloat(index))
            }else{
                let row = index / 3
                let col = index % 3
                cellX = margin + floor((cellWidth + margin) * CGFloat(col))
                cellY = topView!.xm_bottom + ceil(cellHeight * CGFloat(row))
            }
            cell.xm_origin = CGPoint(x: cellX, y: cellY)
            mainView.addSubview(cell)
            cellArray.append(cell)
            lastCell = cell
        }
        
        exchangeBtn = UIButton(type: UIButton.ButtonType.custom)
        exchangeBtn?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        exchangeBtn?.setTitleColor(UIColor.colorWidthHexString(hex: "888888"), for: UIControl.State.normal)
        exchangeBtn?.setImage(UIImage(named: "find_change_batch_new"), for: UIControl.State.normal)
        exchangeBtn?.setTitle("   换一批", for: UIControl.State.normal)
        exchangeBtn?.xm_size = CGSize(width: mainView.xm_width, height: 36)
        exchangeBtn?.xm_origin = CGPoint(x: 0, y: lastCell!.xm_bottom)
        mainView.addSubview(exchangeBtn!)
        
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeCommentImageBgView: UIView {
    
    
    fileprivate var imageView: UIImageView?
    fileprivate var labelLeftBottom: UILabel?
    fileprivate var labelRightBottom: UILabel?
    fileprivate var imageTopView: UIImageView?
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        addSubview(imageView!)
        
        imageTopView = UIImageView()
        imageTopView?.contentMode = .scaleAspectFit
        addSubview(imageTopView!)
        imageTopView?.snp.makeConstraints({ (make) in
            make.left.top.equalToSuperview()
        })
        
        labelLeftBottom = UILabel()
        addSubview(labelLeftBottom!)
        
        labelRightBottom = UILabel()
        labelRightBottom?.xm_size = CGSize(width: 22, height: 12)
        labelRightBottom?.backgroundColor = UIColor.colorWithrgba(234, 130, 127)
        labelRightBottom?.font = UIFont.systemFont(ofSize: 8)
        labelRightBottom?.textColor = UIColor.white
        labelRightBottom?.isHidden = true
        labelRightBottom?.textAlignment = .center
        labelRightBottom?.layer.cornerRadius = 3
        labelRightBottom?.layer.masksToBounds = true
        addSubview(labelRightBottom!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = bounds
        labelLeftBottom?.frame = CGRect(x: 0, y: xm_height - 20, width: xm_width, height: 20)
        labelRightBottom?.xm_origin = CGPoint(x: xm_width - 25, y: xm_height - 15)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeGuessLikeCell: UICollectionViewCell {
    
    private var topView: HomeCommentImageBgView?
    
    private var labelPlayCount: UILabel?
    private var labelTitle: UILabel?
    
    private var layerBg: UIView?
        
    var itemData: HomeHeaderItemData? {
        didSet {
            if let item = itemData {
                if item.colorTule != nil {
                    layerBg?.backgroundColor = UIColor.colorWithrgba(item.colorTule!.0, item.colorTule!.1, item.colorTule!.2)
                }else{
                    layerBg?.backgroundColor = UIColor.xm.xm_255_30_color
                }
                topView?.xm_size = CGSize(width: xm_width, height: item.imageViewHeight)
                topView?.imageView?.setWebpRoundImage(urlString: item.pic, placeHolderName: "new_playpage_default_small", corner: 10, rectCorner: [.topLeft, .topRight])
                topView?.imageTopView?.isHidden = true
                if item.topImageName != nil {
                    topView?.imageTopView?.isHidden = false
                    topView?.imageTopView?.image = UIImage(named: item.topImageName!)
                }
                topView?.labelRightBottom?.isHidden = true
                if item.categoryName != nil {
                    topView?.labelRightBottom?.isHidden = false
                    topView?.labelRightBottom?.text = item.categoryName
                }
                topView?.labelLeftBottom?.attributedText = item.attrPlayerCount
                labelTitle?.xm_y = topView!.xm_bottom + item.attrTitleTop
                labelTitle?.xm_width = item.attrTitleWidth
                labelTitle?.xm_x = (xm_width - item.attrTitleWidth) * 0.5
                labelTitle?.xm_height = item.attrTitleHeight
                labelTitle?.attributedText = item.attrTitle
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        layerBg = UIView()
        layerBg?.layer.cornerRadius = 5
        
        contentView.addSubview(layerBg!)
        topView = HomeCommentImageBgView()
        contentView.addSubview(topView!)
        
        labelTitle = UILabel()
        labelTitle?.numberOfLines = 2
        labelTitle?.xm_origin = CGPoint(x: 0, y: 0)
        labelTitle?.xm_size = CGSize(width: 0, height: 0)
        contentView.addSubview(labelTitle!)
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layerBg?.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HomeBodyAlbumDescView: UIView {
    
    fileprivate var labelDesc: UILabel?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.xm.dynamicRGB((245, 245, 245), (42, 42, 42))
        layer.cornerRadius = 5
        layer.masksToBounds = false
        labelDesc = UILabel()
        labelDesc?.backgroundColor = backgroundColor
        labelDesc?.layer.masksToBounds = true
        labelDesc?.numberOfLines = 2
        addSubview(labelDesc!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        labelDesc?.xm_origin = CGPoint(x: 10, y: 5)
        labelDesc?.xm_size = CGSize(width: xm_width - 20, height: xm_height - 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class HomeBodyAlbumCell: UICollectionViewCell {
    
    
//    static let HomeBodyAlbumCell_identify = "HomeBodyAlbumCell_identify"
    private var mainView: UIView?
    private var imageLogoView: UIImageView?
    private var badge: UIImageView?
    private var labelTitle: UILabel?
    private var rankImageView: HomeLabelRankImageView?
    private var descView: HomeBodyAlbumDescView?
    private var labelTingCount: UILabel?
    
    
    private var imagePlayView: UIImageView?
    
//    "item": {
//        "actualStartAt": 1597900102506,
//        "bizType": 1,
//        "categoryId": 48,
//        "categoryName": "翻唱",
//        "chatId": 2008109,
//        "coverLarge": "http://imagev2.xmcdn.com/group82/M09/5F/CC/wKg5Il8u6pODjYklAAVcubxgM6U795.jpg!op_type=3&columns=290&rows=290&magick=png",
//        "coverMiddle": "http://imagev2.xmcdn.com/group82/M09/5F/CC/wKg5Il8u6pODjYklAAVcubxgM6U795.jpg!op_type=3&columns=140&rows=140&magick=png",
//        "coverSmall": "http://imagev2.xmcdn.com/group82/M09/5F/CC/wKg5Il8u6pODjYklAAVcubxgM6U795.jpg!op_type=3&columns=86&rows=86&magick=png",
//        "description": "今天不限话题，敞开聊^_^",
//        "dislikeReasonNew": {
//            "default": [{
//                "codeType": "DEFAULT",
//                "name": "不感兴趣"
//            }, {
//                "codeType": "DEFAULT",
//                "name": "听过了"
//            }, {
//                "codeType": "DEFAULT",
//                "name": "内容质量差"
//            }, {
//                "codeType": "DEFAULT",
//                "name": "不喜欢主播"
//            }],
//            "traits": []
//        },
//        "dislikeReasons": [{
//            "name": "不感兴趣",
//            "value": "DEFAULT"
//        }, {
//            "name": "听过了",
//            "value": "DEFAULT"
//        }, {
//            "name": "内容质量差",
//            "value": "DEFAULT"
//        }, {
//            "name": "不喜欢主播",
//            "value": "DEFAULT"
//        }],
//        "endAt": 1597914000000,
//        "id": 8158299,
//        "materialType": "live",
//        "name": "你有多久没来过",
//        "nickname": "大只_轻语",
//        "playCount": 230,
//        "recInfo": {
//            "recReason": "贩卖快乐的小酒馆",
//            "recReasonType": "RECSYS",
//            "recSrc": "recommendGradeAAnchorPool.165V11~233V3.CV",
//            "recTrack": "FD.LIVEC.1408.itfreq"
//        },
//        "recSrc": "recommendGradeAAnchorPool.165V11~233V3.CV",
//        "recTrack": "FD.LIVEC.1408.itfreq",
//        "roomId": 1503824,
//        "startAt": 1597899600000,
//        "status": 9,
//        "uid": 119487075
//    },
//    "itemType": "LIVE"
    
//    var vipAlbum: XMVipBodyAlbumListModel? {
//        didSet {
//            imageLogoView?.setWebpImage(urlString: <#T##String?#>, placeHolderName: <#T##String?#>)
//        }
//    }
    
    var hqgLayout: XMHQGAlbumLayout? {
         didSet {
            mainView?.xm_height = hqgLayout!.cellHeight
            
            imageLogoView?.setWebpImage(urlString: hqgLayout?.resultAlbum.coverPath, placeHolderName: "find_albumcell_cover_bg")
            labelTitle?.xm_height = hqgLayout!.albumTitleAttrHeight
            labelTitle?.attributedText = hqgLayout?.albumTitleAttr
            descView?.xm_y = labelTitle!.xm_bottom + 5
            descView?.xm_height = hqgLayout!.albumIntroHeight
            descView?.labelDesc?.attributedText = hqgLayout?.albunIntroAttr
            descView?.labelDesc?.lineBreakMode = .byTruncatingTail
            descView?.isHidden = hqgLayout?.albunIntroAttr == nil ? true : false
            rankImageView?.isHidden = true
            labelTingCount?.xm_y = hqgLayout!.labelTingCountTop
            labelTingCount?.xm_width = hqgLayout!.labelTingCountWidth
            labelTingCount?.attributedText = hqgLayout?.labelTingAttr
         }
     }
    
    var vipLayoput: XMVipAlbumLayout? {
        didSet {
            mainView?.xm_height = vipLayoput!.cellHeight
            imageLogoView?.setWebpImage(urlString: vipLayoput?.album.coverPath, placeHolderName: "find_albumcell_cover_bg")
            labelTitle?.xm_height = vipLayoput!.albumTitleAttrHeight
            labelTitle?.attributedText = vipLayoput?.albumTitleAttr
            descView?.xm_y = labelTitle!.xm_bottom + 5
            descView?.xm_height = vipLayoput!.albumIntroHeight
            descView?.labelDesc?.attributedText = vipLayoput?.albunIntroAttr
            descView?.labelDesc?.lineBreakMode = .byTruncatingTail
            descView?.isHidden = vipLayoput?.albunIntroAttr == nil ? true : false
            rankImageView?.isHidden = true
            labelTingCount?.xm_y = vipLayoput!.labelTingCountTop
            labelTingCount?.xm_width = vipLayoput!.labelTingCountWidth
            labelTingCount?.attributedText = vipLayoput?.labelTingAttr
        }
    }
    
    var noveLayout: XMNoveLayout? {
        didSet {
            mainView?.xm_height = noveLayout?.cellHeight ?? 100
            imageLogoView?.setWebpImage(urlString: noveLayout?.albumModel?.album?.coverPath, placeHolderName: "find_albumcell_cover_bg")
            labelTitle?.xm_height = noveLayout!.albumTitleAttrHeight
            labelTitle?.attributedText = noveLayout?.albumTitleAttr
            descView?.xm_y = labelTitle!.xm_bottom + 5
            descView?.xm_height = noveLayout!.albumIntroHeight
            descView?.labelDesc?.attributedText = noveLayout?.albunIntroAttr
            descView?.labelDesc?.lineBreakMode = .byTruncatingTail
            descView?.isHidden = noveLayout?.albunIntroAttr == nil ? true : false
            rankImageView?.isHidden = true
            labelTingCount?.xm_y = noveLayout!.labelTingCountTop
            labelTingCount?.xm_width = noveLayout!.labelTingCountWidth
            labelTingCount?.attributedText = noveLayout?.labelTingAttr
        }
    }
    
    
    /// 首页的
    var layout: HomeLayout? {
        didSet {
            mainView?.xm_height = layout!.cellSize.height
            imageLogoView?.setWebpImage(urlString: layout?.heder.headerItem?.coverPath, placeHolderName: "find_albumcell_cover_bg")
            badge?.isHidden = true
            if layout?.albumImageName != nil {
                badge?.image = UIImage(named: (layout?.albumImageName)!)
                badge?.isHidden = false
            }
            imagePlayView?.isHidden = layout?.heder.headerItem?.paidType == 0 ? false : true
            labelTitle?.xm_height = layout!.attrAlbumTitleHeight
            labelTitle?.attributedText = layout?.attrAlbumTitle
            labelTitle?.lineBreakMode = .byTruncatingTail
            descView?.xm_y = labelTitle!.xm_bottom + 5
            descView?.xm_height = layout!.albumIntroHeight
            descView?.labelDesc?.attributedText = layout?.albumIntroAttr
            descView?.labelDesc?.lineBreakMode = .byTruncatingTail
            
            labelTingCount?.xm_y = descView!.xm_bottom + 15
            rankImageView?.isHidden = true
            if layout?.albumRankAttr != nil {
                rankImageView?.isHidden = false
                rankImageView?.xm_y = descView!.xm_bottom + 15
                rankImageView?.xm_width = layout!.albumRankAttrWidth
                rankImageView?.labelRank?.attributedText = layout?.albumRankAttr
            }
            labelTingCount?.xm_y = layout!.albumBottomTop
            labelTingCount?.xm_width = layout!.albumBottomWidth
            labelTingCount?.attributedText = layout?.albumPlayCountStr
        }
    }
    
 
    
    
//    只要把方法三的一些参数改变一下，就可以实现了，在方法三中，有个方法 UIGraphicsBeginImageContextWithOptions(imageview.bounds.size, false, 0); 其中第二个参数 true表示透明 false表示不透明，只要把参数改成true，那么无论是Blended还是Misaligned都可以实现我们所预期的样子，但是这样切圆角的时候图片四周有黑黑的一层，这是我们介意使用 背景填充 setFill这个方法根据图片背景色进行填充，这样就大功告成了。
//    UIColor.white.setFill()
//    UIRectFill(imageview.bounds)
//      let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
//         imageview.center = view.center
//         imageview.image = UIImage(named: "meinv")
//     // 开始对imageView进行画图
//         UIGraphicsBeginImageContextWithOptions(imageview.bounds.size, true, 0);
//     // 实例化一个圆形的路径
//         let path = UIBezierPath(ovalIn: imageview.bounds)
//     //  进行路劲裁切   后续的绘图都会出现在圆形内  外部的都被干掉
//         path.addClip()
//         imageview.draw(imageview.bounds)
//     //  取到结果
//        imageview.image = UIGraphicsGetImageFromCurrentImageContext()
//    // 关闭上下文
//        UIGraphicsEndImageContext()
//        view.addSubview(imageview)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        contentView.backgroundColor = UIColor.xm.xm_255_30_color
//        contentView.layer.cornerRadius = 5
//        contentView.layer.masksToBounds = false
        
        mainView = UIView()
        mainView?.backgroundColor = UIColor.xm.xm_255_30_color
        mainView?.layer.cornerRadius = 5
        mainView?.layer.masksToBounds = false
        mainView?.xm_x = xm_padding
        mainView?.xm_y = 0
        mainView?.xm_width = content_view_width
        mainView?.xm_height = 100
        contentView.addSubview(mainView!)
        
        
        let logoViewBg = UIView()
        let imageWH: CGFloat = UIDevice.isPad ? 140 : ceil(content_view_width * 0.3)
        logoViewBg.xm_origin = CGPoint(x: 10, y: 10)
        logoViewBg.xm_size = CGSize(width: imageWH, height: imageWH)
        mainView?.addSubview(logoViewBg)
        
        imageLogoView = UIImageView()
        imageLogoView?.layer.cornerRadius = 5
        imageLogoView?.layer.masksToBounds = true
        imageLogoView?.frame = logoViewBg.bounds
        logoViewBg.addSubview(imageLogoView!)
        
        badge = UIImageView()
        badge?.contentMode = .scaleAspectFit
        badge?.isHidden = true
        logoViewBg.addSubview(badge!)
        badge?.snp.makeConstraints({ (make) in
            make.left.top.equalToSuperview()
        })
        imagePlayView = UIImageView()
        imagePlayView?.xm_size = CGSize(width: 28, height: 28)
        imagePlayView?.xm_origin = CGPoint(x: logoViewBg.xm_width - 35, y: logoViewBg.xm_height - 35)
        imagePlayView?.isHidden = true
        imagePlayView?.image = UIImage(named: "newer_rec_video_play")
        logoViewBg.addSubview(imagePlayView!)
        
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: logoViewBg.xm_right + 10, y: logoViewBg.xm_y)
        labelTitle?.xm_size = CGSize(width: content_view_width - 10 - labelTitle!.xm_x, height: 0)
        labelTitle?.numberOfLines = 2
        labelTitle?.lineBreakMode = .byTruncatingTail
        labelTitle?.backgroundColor = mainView?.backgroundColor
        labelTitle?.layer.masksToBounds = true
        mainView?.addSubview(labelTitle!)
        
        descView = HomeBodyAlbumDescView()
        descView?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: labelTitle!.xm_bottom)
        descView?.xm_size = CGSize(width: labelTitle!.xm_width, height: 0)
        mainView?.addSubview(descView!)
        
        rankImageView = HomeLabelRankImageView()
        rankImageView?.frame = CGRect(x: descView!.xm_x, y: descView!.xm_bottom, width: 0, height: 14)
        mainView?.addSubview(rankImageView!)
        
        labelTingCount = UILabel()
        labelTingCount?.xm_height = 14
        labelTingCount?.xm_width = 0
        labelTingCount?.xm_x = descView!.xm_x
        labelTingCount?.xm_y = rankImageView!.xm_bottom
        labelTingCount?.backgroundColor = mainView?.backgroundColor
        labelTingCount?.layer.masksToBounds = true
        mainView?.addSubview(labelTingCount!)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeLabelRankImageView: UIImageView {
    
    var labelRank: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    init() {
        super.init(frame: .zero)
        if let showImage = UIImage(named: "find_flow_reason") {
            let imageW = showImage.size.width * 0.5
            let imageH = showImage.size.height * 0.5
            let finalImage = showImage.resizableImage(withCapInsets: UIEdgeInsets(top: imageH, left: imageW, bottom: imageH - 1, right: imageW - 1), resizingMode: .stretch)
            image = finalImage
        }
        
        labelRank = UILabel()
        labelRank?.font = UIFont.systemFont(ofSize: 11)
        labelRank?.textColor = UIColor.colorWithrgba(102, 53, 40)
        addSubview(labelRank!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelRank?.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class HomeCommonPlayerView: UIView {
    
    
    private var imageView: UIImageView?
    private var btnPlay: UIButton?
    
    
    var coverImage: String? {
        didSet {
            imageView?.setImage(urlString: coverImage, placeHolderName: nil)
        }
    }
    
    var isVideo: Bool? {
        didSet {
            btnPlay?.isHidden = isVideo == true ? false : true
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView()
        addSubview(imageView!)
        
        btnPlay = UIButton(type: UIButton.ButtonType.custom)
        btnPlay?.xm_size = CGSize(width: 60, height: 60)
        btnPlay?.setImage(UIImage(named: "newer_rec_video_play"), for: UIControl.State.normal)
        btnPlay?.isHidden = true
        addSubview(btnPlay!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = bounds
        btnPlay?.center = center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HomeCommonCell: UICollectionViewCell {
    
    var layout: HomeLayout? {
        didSet {
            guard let new_layout = layout else {
                return
            }
            xm_height = new_layout.cellSize.height
            contentView.xm_height = new_layout.cellSize.height
            if new_layout.cellType == .special {
                setValueSpecial(newLayout: new_layout)
            }else if new_layout.cellType == .module(.ad) {
                setValueAds(newLayout: new_layout)
            }else if new_layout.cellType == .video {
                setValueVideo(newLayout: new_layout)
            }
            
        }
    }
    
    private func setValueVideo(newLayout: HomeLayout) {
        viewBottom?.isHidden = true
        imageViewRightTop?.isHidden = true
        topView?.isVideo = true
        topView?.xm_height = newLayout.specialImageViewHeight
        topView?.coverImage = newLayout.heder.headerItem?.videoCover
        labelTitle?.xm_y = topView!.xm_bottom
        labelTitle?.text = layout?.heder.headerItem?.title
        labelDetail?.xm_y = labelTitle!.xm_bottom
        labelDetail?.xm_height = newLayout.speciallabelDetailHeight
        labelDetail?.attributedText = newLayout.speciallabelDetailAttr
    }
    
    private func setValueSpecial(newLayout: HomeLayout) {
        topView?.isVideo = false
        imageViewRightTop?.isHidden = false
        topView?.xm_height = newLayout.specialImageViewHeight
        topView?.coverImage = newLayout.heder.headerItem?.coverPathBig
        labelTitle?.xm_y = topView!.xm_bottom
        labelTitle?.text = layout?.heder.headerItem?.title
        labelDetail?.xm_y = labelTitle!.xm_bottom
        labelDetail?.xm_height = newLayout.speciallabelDetailHeight
        labelDetail?.attributedText = newLayout.speciallabelDetailAttr
        viewBottom?.isHidden = false
        viewBottom?.xm_y = newLayout.cellSize.height - viewBottom!.xm_height
        viewBottomLabel?.attributedText = layout?.pecialBottomAttr
        
    }
    
    private func setValueAds(newLayout: HomeLayout) {
        viewBottom?.isHidden = true
        imageViewRightTop?.isHidden = true
        topView?.isVideo = false
        topView?.xm_height = newLayout.specialImageViewHeight
        labelTitle?.xm_y = topView!.xm_bottom
        labelDetail?.xm_y = labelTitle!.xm_bottom
        labelDetail?.xm_height = newLayout.speciallabelDetailHeight
        if let ad = newLayout.currentAd {
            topView?.coverImage = ad.cover
            labelTitle?.text = ad.name
            labelDetail?.text = ad.description
        }
        
        
    }
    
    
    private var topView: HomeCommonPlayerView?
    private var labelTitle: UILabel?
    private var labelDetail: UILabel?
    
    private var viewBottom: UIView?
    private var viewBottomLabel: UILabel?
    
    private var imageViewRightTop: UIImageView?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        topView = HomeCommonPlayerView()
        topView?.xm_origin = CGPoint(x: 0, y: 0)
        topView?.xm_size = CGSize(width: content_view_width, height: 0)
        contentView.addSubview(topView!)
        
        imageViewRightTop = UIImageView()
        let imageWidth: CGFloat = 70
        let imageHeight = ceil(imageWidth * 0.444)
        imageViewRightTop?.xm_size = CGSize(width: imageWidth, height: imageHeight)
        imageViewRightTop?.xm_origin = CGPoint(x: topView!.xm_width - imageViewRightTop!.xm_width, y: 0)
        imageViewRightTop?.isHidden = true
        imageViewRightTop?.image = UIImage(named: "find_vip_aggregate_icon")
        topView?.addSubview(imageViewRightTop!)
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.systemFont(ofSize: 16)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((25, 25, 25), (190, 190, 190))
        labelTitle?.xm_origin = CGPoint(x: 10, y: topView!.xm_bottom)
        labelTitle?.xm_size = CGSize(width: content_view_width - 20, height: 35)
        labelTitle?.backgroundColor = contentView.backgroundColor
        labelTitle?.layer.masksToBounds = true
        contentView.addSubview(labelTitle!)
        
        labelDetail = UILabel()
        labelDetail?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: labelTitle!.xm_bottom)
        labelDetail?.xm_size = CGSize(width: labelTitle!.xm_width, height: 0)
        labelDetail?.numberOfLines = 0
        labelDetail?.font = UIFont.systemFont(ofSize: 13)
        labelDetail?.textColor = UIColor.xm.dynamicRGB((150, 150, 150), (135, 135, 135))
        labelDetail?.backgroundColor = contentView.backgroundColor
        labelDetail?.layer.masksToBounds = true
        contentView.addSubview(labelDetail!)
        
        viewBottom = UIView()
        viewBottom?.xm_size = CGSize(width: content_view_width, height: 35)
        viewBottom?.xm_x = 0
        viewBottom?.xm_y = labelDetail!.xm_bottom
        contentView.addSubview(viewBottom!)
        viewBottom?.drawDashLine(strokeColor: UIColor.xm.dynamicRGB((230, 230, 230), (40, 40, 40)), lineWidth: 1, lineLength: 5, lineSpacing: 5, isBottom: false)
        
        viewBottomLabel = UILabel()
        viewBottomLabel?.xm_size = CGSize(width: content_view_width - 100, height: 14)
        viewBottomLabel?.xm_origin = CGPoint(x: 10, y: ceil((viewBottom!.xm_height - 14) * 0.5))
        viewBottomLabel?.backgroundColor = contentView.backgroundColor
        viewBottomLabel?.layer.masksToBounds = true
        viewBottom?.addSubview(viewBottomLabel!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//class HomeHotSearchMoreFooterView: UICollectionReusableView {
//    var btnMore: UIButton?
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        btnMore = UIButton(type: UIButton.ButtonType.custom)
//        btnMore?.backgroundColor = UIColor.colorWidthHexString(hex: "F2F2F2")
//        btnMore?.frame = CGRect(x: 0, y: 10, width: 80, height: 190)
//        btnMore?.setTitle("查看更多\n\nMORE", for: UIControl.State.normal)
//        btnMore?.titleLabel?.numberOfLines = 0
//        btnMore?.titleLabel?.textAlignment = .center
//        btnMore?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
//        btnMore?.setTitleColor(UIColor.colorWidthHexString(hex: "666666"), for: UIControl.State.normal)
//        addSubview(btnMore!)
//        
//    }
//    
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
class HomeHotSearchDetailCell: UICollectionViewCell {
    
//    static let HomeHotSearchDetailCell_identify = "HomeHotSearchDetailCell_identify"
    
    var imageView: UILabel?
    var layerBg: CALayer?
    
    private var mainRightView: UIView?
    var labelTitle: UILabel?
    private var imageRightView: UIImageView?
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let itemW: CGFloat = 200
        let itemH: CGFloat = 30
        imageView = UILabel()
        imageView?.xm_size = CGSize(width: itemH - 10, height: itemH - 10)
        imageView?.xm_origin = CGPoint(x: 0, y: 5)

        imageView?.textAlignment = .center
        
        layerBg = CALayer()
        layerBg?.cornerRadius = 5
        layerBg?.frame = imageView!.frame
        layerBg?.backgroundColor = UIColor.colorWidthHexString(hex: "E8D1C0").cgColor
        contentView.layer.addSublayer(layerBg!)
        contentView.addSubview(imageView!)
        
        mainRightView = UIView()//252 249 247
        mainRightView?.xm_origin = CGPoint(x: imageView!.xm_right + 10, y: 0)
        mainRightView?.xm_size = CGSize(width: itemW - mainRightView!.xm_x - 10, height: itemH)
        mainRightView?.layer.cornerRadius = 5
        mainRightView?.layer.masksToBounds = false
        mainRightView?.backgroundColor = UIColor.xm.dynamicRGB((252, 249, 247), (49, 49, 49))
        contentView.addSubview(mainRightView!)
        
        labelTitle = UILabel() //192 154 73
        labelTitle?.xm_origin = CGPoint(x: 10, y: 0)
        labelTitle?.xm_size = CGSize(width: mainRightView!.xm_width - 60, height: mainRightView!.xm_height)
        labelTitle?.textColor = UIColor.colorWithrgba(192, 154, 73)
        labelTitle?.font = UIFont.systemFont(ofSize: 13)
        mainRightView?.addSubview(labelTitle!)
        
        imageRightView = UIImageView()
        mainRightView?.addSubview(imageRightView!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//hotPlayRank
class HomeHotPlayRankDetailCell: UICollectionViewCell {

    private var imageViewLogo: UIImageView?
    private var labelRankView: UILabel?
    private var labelTitle: UILabel?
    private var labelHotCount: UILabel?
    
    var item: HomeHeaderItemData? {
        didSet {
//            imageViewLogo?.setWebpImage(urlString: item?.pic, placeHolderName: nil)
            imageViewLogo?.setWebpRoundImage(urlString: item?.pic, placeHolderName: "find_albumcell_cover_bg", corner: 12, rectCorner: [.topLeft, .bottomLeft])
            labelRankView?.attributedText = item?.workRank
            labelTitle?.attributedText = item?.attrTitle
            labelTitle?.xm_height = item?.attrTitleHeight ?? 0
            labelHotCount?.text = item?.popularity
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        let cellWidth: CGFloat = 260
//        let cellHeight: CGFloat = 80
        
        let mainView = UIView()
        mainView.frame = CGRect(x: 0, y: 0, width: contentView.xm_width, height: contentView.xm_height)
        mainView.layer.cornerRadius = 5
        mainView.layer.masksToBounds = false
        mainView.backgroundColor = UIColor.xm.dynamicRGB((240, 240, 240), (40, 40, 40))
        contentView.addSubview(mainView)
       
        
        
        
        imageViewLogo = UIImageView()
        imageViewLogo?.xm_origin = CGPoint(x: 0, y: 0)
        imageViewLogo?.xm_size = CGSize(width: mainView.xm_height, height: mainView.xm_height)
        contentView.addSubview(imageViewLogo!)

        
        
        labelRankView = UILabel()

        labelRankView?.xm_origin = CGPoint(x: imageViewLogo!.xm_right + 10, y: 5)
        labelRankView?.xm_height = 14
        labelRankView?.xm_width = 100
        contentView.addSubview(labelRankView!)
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: labelRankView!.xm_x, y: labelRankView!.xm_bottom + 5)
        labelTitle?.xm_size = CGSize(width: labelRankView!.xm_width, height: 0)
        labelTitle?.numberOfLines = 2
        contentView.addSubview(labelTitle!)
        
        labelHotCount = UILabel()
        labelHotCount?.xm_size = CGSize(width: labelTitle!.xm_width, height: 14)
        labelHotCount?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: contentView.xm_height - labelHotCount!.xm_height - 5)
        labelHotCount?.textColor = UIColor.xm.dynamicRGB((100, 100, 100), (150, 150, 150))
        labelHotCount?.font = UIFont.systemFont(ofSize: 11)
        contentView.addSubview(labelHotCount!)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//anchor_card
class HomeAnchorCardCell: UICollectionViewCell {
    
    private var imageView: UIImageView?
    private var labelTitle: UILabel?
    
    private var topLayer: CALayer?
    
    var item: HomeHeaderItemData? {
            didSet {
                topLayer?.isHidden = false
                topLayer?.backgroundColor = UIColor.colorWithrgba(item?.colorTule?.0 ?? 0, item?.colorTule?.1 ?? 0, item?.colorTule?.2 ?? 0).cgColor
                imageView?.xm_size = CGSize(width: 50, height: 50)
                imageView?.xm_origin = CGPoint(x: 35, y: 25)
                labelTitle?.xm_origin = CGPoint(x: 10, y: imageView!.xm_bottom)
                labelTitle?.xm_size = CGSize(width: 100, height: 50)
                labelTitle?.attributedText = item?.attrTitle
                imageView?.setWebpRoundImage(urlString: item?.logoPic, placeHolderName: "home_actionsheet_man", corner: 100)
            }
    }
    
    var itemFm: HomeHeaderItemData? {
      
        didSet {
            topLayer?.isHidden = true
            imageView?.xm_origin = CGPoint(x: 0, y: 0)
            imageView?.xm_size = CGSize(width: 100, height: 100)
            labelTitle?.xm_size = CGSize(width: 60, height: 30)
            labelTitle?.xm_origin = CGPoint(x: 5, y: 70)
            imageView?.setImage(urlString: itemFm?.coverPath, placeHolderName: nil)
            labelTitle?.attributedText = itemFm?.attrTitle

        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        topLayer = CALayer()
        topLayer?.xm_origin = CGPoint(x: 0, y: 0)
        topLayer?.xm_size = CGSize(width: 120, height: 50)
        contentView.layer.addSublayer(topLayer!)
        
        imageView = UIImageView()
        imageView?.layer.cornerRadius = 5
        imageView?.layer.masksToBounds = true
        contentView.addSubview(imageView!)
        
        labelTitle = UILabel()
        labelTitle?.textAlignment = .center
        labelTitle?.numberOfLines = 2
        contentView.addSubview(labelTitle!)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
