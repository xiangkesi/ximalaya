//
//  XMMeTingHeadView.swift
//  himalaya
//
//  Created by Farben on 2020/9/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift


class XMMeTingHeadBottomView: XMCommonView {
    private let disposeBag = DisposeBag()
    
    private var currentLabel: UILabel?
    private var lastLabel: UILabel?
    private var currentIndex: Int = 0
    
    override func initWithSubViews() {
        super.initWithSubViews()
        
        layer.addSublayer(lineBottom)
        addSubview(bottomLongView)
//        addSubview(btnUp)
//        addSubview(btnExchange)
        let titles = ["订阅", "听更新"]
        var lastLabel: UILabel?
        for (index, title) in titles.enumerated() {
            let labelTitle = UILabel()
            labelTitle.font = UIFont.boldSystemFont(ofSize: 16)
            labelTitle.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (210, 210, 210))
            labelTitle.text = title
            labelTitle.sizeToFit()
            labelTitle.xm_size = CGSize(width: labelTitle.xm_width, height: 30)
            labelTitle.xm_origin = CGPoint(x: lastLabel == nil ? xm_padding : lastLabel!.xm_right + xm_padding, y: 10)
            labelTitle.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer()
            tap.rx.event.subscribe {[weak self] (tap) in
                if self?.currentIndex == index {return}
                self?.currentIndex = index
                let tempLabel = self?.currentLabel
                self?.currentLabel = labelTitle
                self?.lastLabel = tempLabel
                
                UIView.animate(withDuration: 0.25) {
                    self?.currentLabel?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    self?.lastLabel?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    self?.lineBottom.xm_width = (self?.currentLabel?.xm_width)!
                    self?.lineBottom.xm_x = (self?.currentLabel?.xm_x)!
                } completion: { (finish) in
                    
                }
            }.disposed(by: disposeBag)
            labelTitle.addGestureRecognizer(tap)
            addSubview(labelTitle)
            if index == 0 {
                currentLabel = labelTitle
                currentLabel?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                lineBottom.xm_width = currentLabel!.xm_width
                lineBottom.xm_x = currentLabel!.xm_x
            }
            lastLabel = labelTitle
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        bottomLongView.frame = CGRect(x: 0, y: xm_height - 1, width: xm_width, height: 1)
        btnUp.xm_origin = CGPoint(x: xm_width - xm_padding - btnUp.xm_width, y: 5)
        btnExchange.xm_origin = CGPoint(x: btnUp.xm_x - btnExchange.xm_width - 10, y: 5)
    }
    
    fileprivate lazy var btnUp: UIButton = {
        let b_btn = UIButton(type: UIButton.ButtonType.custom)
        b_btn.xm_size = CGSize(width: 50, height: 40)
        b_btn.backgroundColor = UIColor.red
        return b_btn
    }()
    
    fileprivate lazy var btnExchange: UIButton = {
        let b_exchange = UIButton(type: UIButton.ButtonType.custom)
        b_exchange.xm_size = CGSize(width: 40, height: 40)
        b_exchange.backgroundColor = UIColor.yellow
        return b_exchange
    }()
    
    private lazy var lineBottom: CALayer = {
        let line_bottom = CALayer()
        line_bottom.xm_size = CGSize(width: 0, height: 2)
        line_bottom.xm_origin = CGPoint(x: xm_padding, y: 48)
        line_bottom.backgroundColor = UIColor.colorWidthHexString(hex: mainColorString).cgColor
        return line_bottom
    }()
    
    private lazy var bottomLongView: UIView = {
        let l_view = UIView()
        l_view.backgroundColor = UIColor.xm.dynamicRGB((230, 230, 230), (35, 35, 35))
        return l_view
    }()
}
class XMMeTingHeadView: UICollectionReusableView {

    
    let disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
        addSubview(bottomView)
       

    }
    
    var layout: XMItingLayout? {
        didSet {
            guard let models = layout?.resultTitles, models.count > 0 else {
                return
            }
            collectionView.reloadData()
        }
    }
    
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 90, height: 120)
        flowLayout.scrollDirection = .horizontal
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        c_view.register(XMMeTingHeadViewCell.self, forCellWithReuseIdentifier: "XMMeTingHeadViewCell_identify")
        c_view.delegate = self
        c_view.dataSource = self
        c_view.backgroundColor = .clear
        c_view.contentInset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
        c_view.showsHorizontalScrollIndicator = false
        return c_view
    }()
    
    var bottomView: XMMeTingHeadBottomView = {
        let b_view = XMMeTingHeadBottomView()
        return b_view
    }()
   
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.xm_origin = CGPoint(x: 0, y: 0)
        collectionView.xm_size = CGSize(width: xm_width, height: 140)
        
        bottomView.xm_origin = CGPoint(x: 0, y: xm_height - 50)
        bottomView.xm_size = CGSize(width: xm_width, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XMMeTingHeadView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return layout?.resultTitles?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XMMeTingHeadViewCell_identify", for: indexPath) as! XMMeTingHeadViewCell
        if let models = layout?.resultTitles {
            let model = models[indexPath.row]
            cell.titleModel = model
        }
        
        return cell
    }
    
    
}

class XMMeTingHeadViewCell: XMCommonCollectionViewCell {
    
    private var imageView: UIImageView?
    private var labelTitle: UILabel?
    
    var titleModel: XMMeTingTitleModel? {
        didSet {
            imageView?.setImage(urlString: titleModel?.coverPath, placeHolderName: nil)
            labelTitle?.text = titleModel?.title
        }
    }
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        
        imageView = UIImageView()
        contentView.addSubview(imageView!)
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTitle?.textAlignment = .center
        contentView.addSubview(labelTitle!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = contentView.bounds
        labelTitle?.xm_size = CGSize(width: contentView.xm_width, height: 20)
        labelTitle?.xm_origin = CGPoint(x: 0, y: (contentView.xm_height - labelTitle!.xm_height) * 0.5 + 10)
    }
}

class XMItingSubscribeCell: XMCommonCollectionViewCell {
    
    
    private var imageViewIcon: UIImageView?
    private var imagePlayer: UIImageView?
    private var labelTitle: UILabel?
    private var labelDesc: UILabel?
    private var labelTime: UILabel?
    
    private var bottomLine: UIView?
    
    var resultModel: XMItingAlbumResultModel? {
        didSet {
            imageViewIcon?.setImage(urlString: resultModel?.albumCover, placeHolderName: "find_albumcell_cover_bg")
            labelTitle?.text = resultModel?.albumTitle
            labelDesc?.text = resultModel?.trackTitle
            labelTime?.text = resultModel?.timeStr
        }
    }
    
    var isGrid: Bool = false
    
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        imageViewIcon = UIImageView()
        imageViewIcon?.layer.cornerRadius = 5
        imageViewIcon?.layer.masksToBounds = true
        contentView.addSubview(imageViewIcon!)
        
        imagePlayer = UIImageView()
        imagePlayer?.xm_size = CGSize(width: 26, height: 26)
        imagePlayer?.image = UIImage(named: "liveRadioCellPlay")
        contentView.addSubview(imagePlayer!)
        
        labelTitle = UILabel()
        labelTitle?.numberOfLines = 2
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200))
        contentView.addSubview(labelTitle!)
        
        labelDesc = UILabel()
        labelDesc?.font = UIFont.systemFont(ofSize: 14)
        labelDesc?.textColor = UIColor.xm.dynamicRGB((100, 100, 100), (150, 150, 150))
        contentView.addSubview(labelDesc!)
        
        labelTime = UILabel()
        labelTime?.font = UIFont.systemFont(ofSize: 12)
        labelTime?.textColor = UIColor.xm.dynamicRGB((130, 130, 130), (130, 130, 130))
        contentView.addSubview(labelTime!)
        
        bottomLine = UIView()
        bottomLine?.xm_height = 1
        bottomLine?.xm_x = xm_padding
        bottomLine?.backgroundColor = UIColor.xm.dynamicRGB((230, 230, 230), (35, 35, 35))
        contentView.addSubview(bottomLine!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
            imageViewIcon?.xm_origin = CGPoint(x: xm_padding, y: xm_padding)
            let imageViewIconWH: CGFloat = contentView.xm_height - imageViewIcon!.xm_y * 2
            imageViewIcon?.xm_size = CGSize(width: imageViewIconWH, height: imageViewIconWH)
            
            imagePlayer?.xm_origin = CGPoint(x: imageViewIcon!.xm_right - imagePlayer!.xm_width - 5, y: imageViewIcon!.xm_bottom - imagePlayer!.xm_height - 5)
            
            labelTitle?.xm_origin = CGPoint(x: imageViewIcon!.xm_right + 10, y: imageViewIcon!.xm_y)
            labelTitle?.xm_size = CGSize(width: contentView.xm_width - labelTitle!.xm_x - xm_padding, height: 26)
            
            labelDesc?.xm_origin = CGPoint(x: labelTitle!.xm_x, y: labelTitle!.xm_bottom + 5)
            labelDesc?.xm_size = CGSize(width: labelTitle!.xm_width, height: 16)
            
            labelTime?.xm_size = CGSize(width: labelDesc!.xm_width - 30, height: 14)
            labelTime?.xm_origin = CGPoint(x: labelDesc!.xm_x, y: imageViewIcon!.xm_bottom - labelTime!.xm_height)
            
            bottomLine?.xm_y = contentView.xm_height - bottomLine!.xm_height
            bottomLine?.xm_width = contentView.xm_width - 30
        
    }
}
