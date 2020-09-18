//
//  XMHighQualityGoodsCell.swift
//  himalaya
//
//  Created by Farben on 2020/9/16.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift

class XMHighQualityGoodsTopCell: XMCommonCollectionViewCell {
    
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
//        c_view.contentInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: xm_padding)
        return c_view
    }()
}

class XMHighQualityGoodsTopDetailCell: XMCommonCollectionViewCell {
    
    
    var imageView: UIImageView?
    var labelTitle: UILabel?
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        imageView = UIImageView()
        contentView.addSubview(imageView!)
        
        labelTitle = UILabel()
        labelTitle?.textAlignment = .center
        labelTitle?.font = UIFont.systemFont(ofSize: 14)
        labelTitle?.textColor = UIColor.white
        contentView.addSubview(labelTitle!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView?.xm_size = CGSize(width: 40, height: 40)
        imageView?.xm_centerX = contentView.xm_centerX
        imageView?.xm_y = ceil((contentView.xm_height - imageView!.xm_height - 20) / 2)
        
        labelTitle?.xm_size = CGSize(width: contentView.xm_width, height: 20)
        labelTitle?.xm_origin = CGPoint(x: 0, y: imageView!.xm_bottom + 5)
    }
}

class XMHQGTitleHeadView: UICollectionReusableView {
    
    var scrollerView: UIScrollView?
    
    var callBack: ((_ titleModel: XMHQGTitleModel) -> ())?
    
    
    private var currentIndex: Int = 0
    private var lastLabel: UILabel?
    private var currentLabel: UILabel?
    private var linBottom: CALayer?
    private let disposeBag = DisposeBag()
    
    
    
    var titleModels: [XMHQGTitleModel]? {
        didSet {
            guard let words = titleModels, words.count > 0, lastLabel == nil else {
                return
            }
            var finalLabel: UILabel?
            for (index, word) in words.enumerated() {
                let label = UILabel()
                scrollerView?.addSubview(label)
                label.isUserInteractionEnabled = true
                label.xm_y = 0
                label.xm_x = (finalLabel == nil) ? xm_padding : finalLabel!.xm_right + 20
                label.xm_size = CGSize(width: word.titleWidth, height: xm_height - 10)
                label.attributedText = word.titeAttr
                lastLabel = label
                let tap = UITapGestureRecognizer()
                label.addGestureRecognizer(tap)
                
                tap.rx.event.subscribe(onNext: {[weak self] (tap) in
                    if self?.currentIndex == index {return}
                    self?.currentIndex = index
                    let tempLabel = self?.currentLabel
                    self?.currentLabel = label
                    self?.lastLabel = tempLabel
                    UIView.animate(withDuration: 0.25, animations: {
                        self?.currentLabel!.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                        self?.lastLabel?.transform = CGAffineTransform(scaleX: 1, y: 1)
                        self?.linBottom?.xm_x = ceil(label.xm_x + (word.titleWidth - 30) * 0.5)
                    }) { (finish) in
                        self?.refreshContenOffset()
                        if self?.callBack != nil {
                            self?.callBack!(word)
                        }
                    }
                }).disposed(by: disposeBag)
                if index == 0 {
                    currentLabel = label
                    linBottom?.xm_x = ceil(label.xm_x + (word.titleWidth - 30) * 0.5)
                    currentLabel?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                }
                finalLabel = label
            }
            
            if finalLabel!.xm_right > scrollerView!.xm_width {
                scrollerView?.contentSize = CGSize(width: finalLabel!.xm_right, height: 0)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.xm.xm_230_20_color
        scrollerView = UIScrollView()
        scrollerView?.contentInset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
        scrollerView?.showsHorizontalScrollIndicator = false
        addSubview(scrollerView!)
        
        linBottom = CALayer()
        linBottom?.xm_height = 4
        linBottom?.xm_width = 30
        linBottom?.xm_y = 46
        linBottom?.cornerRadius = 2
        linBottom?.backgroundColor = UIColor.colorWidthHexString(hex: mainColorString).cgColor
        scrollerView?.layer.addSublayer(linBottom!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollerView?.frame = bounds
    }
    
    func refreshContenOffset() {
//        if scrollerView!.xm_width > scrollerView!.contentSize.width {
//            return
//        }
//        var offsetX = currentLabel!.center.x - scrollerView!.xm_width * 0.5
//        if offsetX < 0 {
//            offsetX = 0
//        }
//        if offsetX > scrollerView!.contentSize.width - scrollerView!.xm_width {
//            offsetX = scrollerView!.contentSize.width - scrollerView!.xm_width
//        }
//        scrollerView?.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        let frame = self.currentLabel?.frame
        let itemX = frame?.origin.x
        let width = scrollerView?.frame.size.width
        let contentSize = scrollerView?.contentSize
        if itemX! > width! / 2 {
            var targetX: CGFloat = 0
            if (contentSize!.width - itemX!) <= width! / 2 {
                targetX = contentSize!.width - width!
            }else {
                targetX = frame!.origin.x - width! / 2 + frame!.size.width / 2
            }

            if targetX + width! > contentSize!.width {
                targetX = contentSize!.width - width!
            }
            scrollerView?.setContentOffset(CGPoint(x: targetX, y: 0), animated: true)
        }else {
            scrollerView?.setContentOffset(CGPoint.zero, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMHQGTitlePictureCell: XMCommonCollectionViewCell {
    
    var imageView: UIImageView?
    
    override func initWithSubViews() {
        super.initWithSubViews()
        
        imageView = UIImageView()
        imageView?.layer.cornerRadius = 5
        imageView?.layer.masksToBounds = true
        contentView.addSubview(imageView!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.xm_origin = CGPoint(x: xm_padding, y: 0)
        imageView?.xm_size = CGSize(width: contentView.xm_width - 30, height: contentView.xm_height)
    }
}


class XMHQGAlbumCollectionCell: XMCommonCollectionViewCell {
    
    
    private var labelTitle: UILabel?
    
    override func initWithSubViews() {
        super.initWithSubViews()
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: 0)
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 16)
        labelTitle?.textColor = UIColor.white
        contentView.addSubview(labelTitle!)
        contentView.addSubview(collectionView)
    }
    
    var albumData: XMHQGAlbumDataModel? {
        didSet {
            labelTitle?.text = albumData?.title
            guard let rank_tables = albumData?.rankTables, rank_tables.count == 0 else {
                return
            }
            collectionView.reloadData()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelTitle?.xm_size = CGSize(width: contentView.xm_width - 30, height: 50)
        collectionView.frame = CGRect(x: 0, y: labelTitle!.xm_bottom, width: contentView.xm_width, height: contentView.xm_height - labelTitle!.xm_height)
    }
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 300, height: 330)
        flowLayout.scrollDirection = .horizontal
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        c_view.backgroundColor = .clear
        c_view.showsHorizontalScrollIndicator = false
        c_view.register(XMHQGTitleRankTrackCell.self, forCellWithReuseIdentifier: "XMHQGTitleRankTrackCell_identify")
        c_view.delegate = self
        c_view.dataSource = self
        c_view.contentInset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
        return c_view
    }()
}

extension XMHQGAlbumCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return albumData?.rankTables?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XMHQGTitleRankTrackCell_identify", for: indexPath) as! XMHQGTitleRankTrackCell
        cell.rankTable = albumData?.rankTables![indexPath.row]
        return cell
        
    }
    
    
}

class XMHQGTitleRankTrackView: XMCommonView {
    
    fileprivate var labelRank: UILabel?
    fileprivate var imageHeadView: UIImageView?
    fileprivate var labelTitle: UILabel?
    fileprivate var imageRight: UIImageView?
    override func initWithSubViews() {
        super.initWithSubViews()
        
        labelRank = UILabel()
        labelRank?.font = UIFont.boldSystemFont(ofSize: 20)
        labelRank?.textColor = UIColor.white
        labelRank?.xm_size = CGSize(width: 16, height: 20)
        addSubview(labelRank!)
        
        imageHeadView = UIImageView()
        imageHeadView?.layer.cornerRadius = 5
        imageHeadView?.layer.masksToBounds = true
        imageHeadView?.image = UIImage(named: "find_vip_default_icon")
        addSubview(imageHeadView!)
        
        labelTitle = UILabel()
        labelTitle?.textColor = UIColor.white
        labelTitle?.font = UIFont(name: "Helvetica-Bold", size: 14)
        labelTitle?.xm_height = 30
        addSubview(labelTitle!)
        
        imageRight = UIImageView()
        imageRight?.image = UIImage(named: "find_word_search_up")
        imageRight?.xm_size = CGSize(width: 16, height: 16)
        addSubview(imageRight!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelRank?.xm_origin = CGPoint(x: xm_padding, y: ceil((xm_height - labelRank!.xm_height) * 0.5))
        imageHeadView?.xm_origin = CGPoint(x: labelRank!.xm_right + 10, y: 5)
        imageHeadView?.xm_size = CGSize(width: xm_height - 10, height: xm_height - 10)
        
        imageRight?.xm_x = xm_width - imageRight!.xm_width - 10
        imageRight?.xm_y = ceil((xm_height - imageRight!.xm_height) * 0.5)
        
        labelTitle?.xm_x = imageHeadView!.xm_right + 5
        labelTitle?.xm_width = imageRight!.xm_x - labelTitle!.xm_x - xm_padding
        labelTitle?.xm_y = ceil((xm_height - labelTitle!.xm_height) * 0.5)
        
        
    }
}
class XMHQGTitleRankTrackCell: XMCommonCollectionViewCell {
    
    //cell
    
    private var imageView: UIImageView?
    private var labelTitle: UILabel?
    private var buttonMore: UIButton?
    private var labelDesc: UILabel?
    
    private var trackViews = [XMHQGTitleRankTrackView]()
    
    
    var rankTable: XMHQGAlbumDataRankTableModel? {
        didSet {
            
            labelTitle?.text = rankTable?.name
            labelDesc?.text = rankTable?.updateTime
            guard let items = rankTable?.items  else {
                return
            }
            for (index, view) in trackViews.enumerated() {
                if index < items.count {
                    view.isHidden = false
                    let item = items[index]
                    view.labelTitle?.text = item.title
                    view.imageHeadView?.setWebpImage(urlString: item.coverPath, placeHolderName: "find_albumcell_cover_bg")
                }else {
                    view.isHidden = true
                }
            }
        }
    }
    override func initWithSubViews() {
        super.initWithSubViews()
        
        imageView = UIImageView()
        imageView?.image = UIImage(named: "find_vip_aggregate_bkg_iphone")
        imageView?.frame = contentView.bounds
        imageView?.layer.cornerRadius = 5
        imageView?.layer.masksToBounds = true
        contentView.addSubview(imageView!)
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
        labelTitle?.xm_size = CGSize(width: 100, height: 20)
        labelTitle?.font = UIFont(name: "Helvetica-Bold", size: 18)
        labelTitle?.textColor = UIColor.white
        contentView.addSubview(labelTitle!)
        
        buttonMore = UIButton(type: UIButton.ButtonType.custom)
        buttonMore?.xm_size = CGSize(width: 100, height: 30)
        buttonMore?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: labelTitle!.xm_bottom)
        buttonMore?.contentHorizontalAlignment = .left
        buttonMore?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        buttonMore?.setTitleColor(UIColor.white, for: UIControl.State.normal)
        buttonMore?.setTitle("查看更多>", for: UIControl.State.normal)
        contentView.addSubview(buttonMore!)
        
        labelDesc = UILabel()
        labelDesc?.xm_size = CGSize(width: contentView.xm_width - xm_padding - labelTitle!.xm_right, height: 20)
        labelDesc?.xm_origin = CGPoint(x: contentView.xm_width - labelDesc!.xm_width - xm_padding, y: labelTitle!.xm_y + 10)
        labelDesc?.font = UIFont.systemFont(ofSize: 13)
        labelDesc?.textColor = UIColor.white
        labelDesc?.textAlignment = .right
        contentView.addSubview(labelDesc!)
                
        let trackViewY: CGFloat = contentView.xm_height - 260
        for index in 0..<5 {
            let trackView = XMHQGTitleRankTrackView()
            trackView.isHidden = true
            trackView.labelRank?.text = "\(index)."
            trackView.xm_size = CGSize(width: 300, height: 50)
            trackView.xm_x = 0
            trackView.xm_y = trackViewY + trackView.xm_height * CGFloat(index)
            contentView.addSubview(trackView)
            trackViews.append(trackView)
        }
    }
    
}


class XMHQGStarMemberView: XMCommonView {
    
    var imageHead: UIImageView?
    var labelTitle: UILabel?
    var labelDesc: UILabel?
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        imageHead = UIImageView()
        let memberViewW: CGFloat = ceil((content_view_width / 3 - 40) * 0.5)
        imageHead?.layer.cornerRadius = memberViewW
        imageHead?.layer.masksToBounds = true
        addSubview(imageHead!)
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTitle?.textColor = UIColor.white
        labelTitle?.textAlignment = .center
        addSubview(labelTitle!)
        
        labelDesc = UILabel()
        labelDesc?.font = UIFont.boldSystemFont(ofSize: 13)
        labelDesc?.textColor = UIColor.white
        labelDesc?.textAlignment = .center
        addSubview(labelDesc!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageHead?.xm_origin = CGPoint(x: 20, y: 0)
        let imageHeadWidth = xm_width - imageHead!.xm_x * 2
        imageHead?.xm_size = CGSize(width: imageHeadWidth, height: imageHeadWidth)
        
        labelTitle?.xm_origin = CGPoint(x: 10, y: imageHead!.xm_bottom + 10)
        labelTitle?.xm_size = CGSize(width: xm_width - 20, height: 20)
        
        labelDesc?.xm_x = 10
        labelDesc?.xm_size = labelTitle!.xm_size
        labelDesc?.xm_y = labelTitle!.xm_bottom + 3
    }
}

class XMHQGStarMemberCell: XMCommonCollectionViewCell {
    
    var mainView: UIView?
    
    var labelTitle: UILabel?
    var btnMore: UIButton?
    
    private var memberViews = [XMHQGStarMemberView]()
    
    var albumModel: XMHQGAlbumModel? {
        didSet {
            labelTitle?.text = albumModel?.albumData?.title
            guard let starModels = albumModel?.albumData?.starModels else {
                return
            }
            
            for (index, view) in memberViews.enumerated() {
                if index < starModels.count {
                    let starModel = starModels[index]
                    view.imageHead?.setImage(urlString: starModel.logoPic, placeHolderName: "find_albumcell_cover_bg")
                    view.labelTitle?.text = starModel.nickName
                    view.labelDesc?.text = starModel.introduction
                }
            }
        }
    }
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        
        mainView = UIView()
        mainView?.backgroundColor = UIColor.xm.xm_255_30_color
        mainView?.layer.cornerRadius = 5
        mainView?.xm_origin = CGPoint(x: xm_padding, y: 0)
        mainView?.xm_size = CGSize(width: content_view_width, height: contentView.xm_height)
        contentView.addSubview(mainView!)
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: 0)
        labelTitle?.xm_size = CGSize(width: mainView!.xm_width - 30, height: 50)
        labelTitle?.textColor = UIColor.white
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 16)
        mainView?.addSubview(labelTitle!)
        
        let memberViewW: CGFloat = ceil(content_view_width / 3)
        let memberViewH: CGFloat = memberViewW + 30
        
        for index in 0..<6 {
            let memberView = XMHQGStarMemberView()
            let row = index / 3
            let col = index % 3
            let x = memberViewW * CGFloat(col)
            let y = labelTitle!.xm_bottom + memberViewH * CGFloat(row)
            memberView.frame = CGRect(x: x, y: y, width: memberViewW, height: memberViewH)
            mainView?.addSubview(memberView)
            memberViews.append(memberView)
        }
    }
}
