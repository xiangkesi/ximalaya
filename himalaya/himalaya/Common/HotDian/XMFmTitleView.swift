
//
//  XMFmTitleView.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/11.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift

class XMFmTitleView: XMCommonView {

    let dispose = DisposeBag()
    
    let clickSubject = PublishSubject<IndexPath>()
    
    
    private var collectionView: UICollectionView?
    
    var titleModels: [XMFmTitleModel]? {
        didSet {
            guard let models = titleModels, models.count > 0 else {
                return
            }
            setupBtnLayout(models: models)
            
//            collectionView?.reloadData()
        }
    }
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        
        addSubview(scrollViewMain)
        addSubview(bottomLineView)
        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection = .horizontal
//        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
//        collectionView?.register(XMFmTitleViewCell.self, forCellWithReuseIdentifier: "XMFmTitleViewCell_identify")
//        collectionView?.dataSource = self
//        collectionView?.delegate = self
//        collectionView?.backgroundColor = .clear
//        collectionView?.contentInset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
//        collectionView?.showsHorizontalScrollIndicator = false
//        addSubview(collectionView!)
    }
    
    private lazy var scrollViewMain: UIScrollView = {
        let s_view = UIScrollView()
        s_view.showsHorizontalScrollIndicator = false
        s_view.bounces = false
        if #available(iOS 11.0, *) {
            s_view.contentInsetAdjustmentBehavior = .never
        }
        s_view.backgroundColor = UIColor.red
        return s_view
    }()
    
    private lazy var bottomLineView: UIView = {
        let b_view = UIView()
        b_view.backgroundColor = UIColor.blue
        b_view.xm_height = 1
        b_view.xm_width = 40
        b_view.frame = CGRect(x: 0, y: 0, width: 40, height: 1)
        b_view.isHidden = true
        return b_view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollViewMain.frame = bounds
    }
}

extension XMFmTitleView {
    private func setupBtnLayout(models: [XMFmTitleModel]) {
        
    }
}

extension XMFmTitleView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleModels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cCell = collectionView.dequeueReusableCell(withReuseIdentifier: "XMFmTitleViewCell_identify", for: indexPath) as! XMFmTitleViewCell
        if let models = titleModels {
            cCell.labelTitle?.text = models[indexPath.row].channelName
        }
        return cCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index  = IndexPath(item: 0, section: indexPath.row)
        clickSubject.onNext(index)
    }
    
    
}

class XMFmTitleViewCell: XMCommonCollectionViewCell {
    
    fileprivate var labelTitle: UILabel?
    
    override func initWithSubViews() {
        super.initWithSubViews()
        labelTitle = UILabel()
        labelTitle?.textAlignment = .center
        contentView.addSubview(labelTitle!)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        labelTitle?.frame = bounds
    }
}

class XMFmBigTitleView: XMCommonView {
    
    var labelTitle: UILabel?
    var btnSearch: UIButton?
    override func initWithSubViews() {
        super.initWithSubViews()
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 18)
        labelTitle?.numberOfLines = 2
        addSubview(labelTitle!)
        
        btnSearch = UIButton(type: UIButton.ButtonType.custom)
        btnSearch?.xm_height = 30
        btnSearch?.layer.cornerRadius = 15
        btnSearch?.layer.masksToBounds = true
        btnSearch?.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        btnSearch?.setImage(UIImage(named: "fm_input_icon"), for: UIControl.State.normal)
        btnSearch?.contentEdgeInsets = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: 0)
        btnSearch?.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btnSearch?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        btnSearch?.setTitleColor(UIColor.colorWithrgba(200, 200, 200), for: UIControl.State.normal)
        btnSearch?.contentHorizontalAlignment = .left
        btnSearch?.setTitle("说点什么", for: UIControl.State.normal)
        addSubview(btnSearch!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        btnSearch?.xm_origin = CGPoint(x: 30, y: 0)
        btnSearch?.xm_width = xm_width - 60
        
        labelTitle?.xm_x = btnSearch!.xm_x
        labelTitle?.xm_y = btnSearch!.xm_bottom
        labelTitle?.xm_size = CGSize(width: btnSearch!.xm_width, height: xm_height - btnSearch!.xm_height)
    }
}

@objc protocol XMFmBottomPlayerViewDelegate {
    func clickBtn(bottomView: XMFmBottomPlayerView, btn: UIButton, tag: Int8)
}

class XMFmBottomPlayerView: XMCommonView {
    
    private var btnUnLike: UIButton?
    private var btnCollection: UIButton?
    private var btnPlayer: UIButton?
    private var btnNext: UIButton?
    private var btnTimer: UIButton?
    weak var delegate: XMFmBottomPlayerViewDelegate?
    let disposeBag = DisposeBag()
    
    override func initWithSubViews() {
        super.initWithSubViews()
        
        btnUnLike = UIButton(type: UIButton.ButtonType.custom)
//        btnUnLike?.backgroundColor = UIColor.red
        btnUnLike?.setImage(UIImage(named: "fm_pingbi"), for: UIControl.State.normal)
        btnUnLike?.rx.tap.subscribe(onNext: {[weak self] in
            self?.delegate?.clickBtn(bottomView: self!, btn: (self?.btnUnLike)!, tag: 10)
        }).disposed(by: disposeBag)
        addSubview(btnUnLike!)
        
        btnCollection = UIButton(type: UIButton.ButtonType.custom)
        btnCollection?.rx.tap.subscribe(onNext: {[weak self] in
            self?.delegate?.clickBtn(bottomView: self!, btn: (self?.btnCollection)!, tag: 20)
        }).disposed(by: disposeBag)
//        btnCollection?.backgroundColor = UIColor.red
        btnCollection?.setImage(UIImage(named: "fm_un_like"), for: UIControl.State.normal)
        btnCollection?.setImage(UIImage(named: "fm_like"), for: UIControl.State.selected)
        addSubview(btnCollection!)
        
        btnPlayer = UIButton(type: UIButton.ButtonType.custom)
        btnPlayer?.rx.tap.subscribe(onNext: {[weak self] in
            self?.delegate?.clickBtn(bottomView: self!, btn: (self?.btnPlayer)!, tag: 30)
        }).disposed(by: disposeBag)
//        btnPlayer?.backgroundColor = UIColor.red
        btnPlayer?.setImage(UIImage(named: "fm_player"), for: UIControl.State.normal)
        btnPlayer?.setImage(UIImage(named: "fm_pause"), for: UIControl.State.selected)
        addSubview(btnPlayer!)
        
        btnNext = UIButton(type: UIButton.ButtonType.custom)
        btnNext?.rx.tap.subscribe(onNext: {[weak self] in
            self?.delegate?.clickBtn(bottomView: self!, btn: (self?.btnNext)!, tag: 40)
        }).disposed(by: disposeBag)
//        btnNext?.backgroundColor = UIColor.red
        btnNext?.setImage(UIImage(named: "fm_next"), for: UIControl.State.normal)
        addSubview(btnNext!)
        
        btnTimer = UIButton(type: UIButton.ButtonType.custom)
        btnTimer?.rx.tap.subscribe(onNext: {[weak self] in
            self?.delegate?.clickBtn(bottomView: self!, btn: (self?.btnTimer)!, tag: 50)
        }).disposed(by: disposeBag)
//        btnTimer?.backgroundColor = UIColor.red
        btnTimer?.setImage(UIImage(named: "fm_timer"), for: UIControl.State.normal)
        addSubview(btnTimer!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        btnPlayer?.xm_size = CGSize(width: 60, height: 60)
        btnPlayer?.xm_x = ceil((xm_width - btnPlayer!.xm_width) * 0.5)
        btnPlayer?.xm_y = ceil((xm_height - btnPlayer!.xm_height) * 0.5)
        
        
        btnUnLike?.xm_size = CGSize(width: 40, height: 40)
        let space = ceil((btnPlayer!.xm_x - btnUnLike!.xm_width * 2) / 3)
        btnUnLike?.xm_y = ceil((xm_height - btnUnLike!.xm_height) * 0.5)
        btnUnLike?.xm_x = space
        
        btnCollection?.xm_size = btnUnLike!.xm_size
        btnCollection?.xm_y = btnUnLike!.xm_y
        btnCollection?.xm_x = btnUnLike!.xm_right + space
        
        btnNext?.xm_origin = CGPoint(x: btnPlayer!.xm_right + space, y: btnCollection!.xm_y)
        btnNext?.xm_size = btnCollection!.xm_size
        
        btnTimer?.xm_origin = CGPoint(x: btnNext!.xm_right + space, y: btnNext!.xm_y)
        btnTimer?.xm_size = btnNext!.xm_size
    }
}

class XMFmCollectionCell: XMCommonCollectionViewCell {
    
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
//        backgroundColor = UIColor.blue
    
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}


class XMFmBottomListView: XMCommonView {
    
    var topView: UIView?
    var imageView: UIImageView?
    var labelTitle: UILabel?
    var imageArrow: UIImageView?
    override func initWithSubViews() {
        super.initWithSubViews()
        backgroundColor = UIColor.colorWithrgba(50, 50, 50)
        topView = UIView()
        addSubview(topView!)
        imageView = UIImageView()
        imageView?.image = UIImage(named: "fm_list")
        topView?.addSubview(imageView!)
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTitle?.textColor = UIColor.white
        topView?.addSubview(labelTitle!)
        
        imageArrow = UIImageView()
        imageArrow?.image = UIImage(named: "fm_arrow")
        topView?.addSubview(imageArrow!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topView?.xm_origin = CGPoint(x: 0, y: 0)
        topView?.xm_size = CGSize(width: xm_width, height: 50)
        
        imageView?.xm_size = CGSize(width: 26, height: 26)
        imageView?.xm_origin = CGPoint(x: 12, y: xm_padding)
        
        imageArrow?.xm_size = CGSize(width: 20, height: 20)
        imageArrow?.xm_origin = CGPoint(x: topView!.xm_width - imageArrow!.xm_width - xm_padding, y: 17)
        
        labelTitle?.xm_origin = CGPoint(x: imageView!.xm_right + 10, y: imageView!.xm_y)
        labelTitle?.xm_size = CGSize(width: imageArrow!.xm_x - 10 - labelTitle!.xm_x, height: 26)
    }
}
