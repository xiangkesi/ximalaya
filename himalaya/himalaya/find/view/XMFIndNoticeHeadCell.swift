//
//  XMFIndNoticeHeadCell.swift
//  himalaya
//
//  Created by Farben on 2020/9/10.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit


class XMFIndNoticeHeadTitleCell: XMCommonCollectionViewCell {
    
    var labelTitle: UILabel?
    var btnMore: UIButton?
    
    
    
    override func initWithSubViews() {
        super.initWithSubViews()
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: 0)
        labelTitle?.xm_size = CGSize(width: contentView.xm_width - 100, height: contentView.xm_height)
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 16)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((20, 20, 20), (230, 230, 230))
        contentView.addSubview(labelTitle!)
        
        btnMore = UIButton(type: UIButton.ButtonType.custom)
        btnMore?.setTitle("全部〉", for: UIControl.State.normal)
        btnMore?.xm_size = CGSize(width: 70, height: contentView.xm_height)
        btnMore?.xm_origin = CGPoint(x: contentView.xm_width - 85, y: 0)
        btnMore?.contentHorizontalAlignment = .right
        btnMore?.setTitleColor(UIColor.xm.dynamicRGB((50, 50, 50), (200, 200, 200)), for: UIControl.State.normal)
        btnMore?.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        contentView.addSubview(btnMore!)
    }
}

class XMFIndNoticeHeadTopView: XMCommonView {
    
    fileprivate var imageView: UIImageView?
    fileprivate var labelBottom: UILabel?
    override func initWithSubViews() {
        super.initWithSubViews()
        
        imageView = UIImageView()
        addSubview(imageView!)
        
        labelBottom = UILabel()
        labelBottom?.textColor = UIColor.white
        labelBottom?.font = UIFont.systemFont(ofSize: 12)
        labelBottom?.textAlignment = .right
        addSubview(labelBottom!)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = bounds
        labelBottom?.xm_size = CGSize(width: xm_width, height: 20)
        labelBottom?.xm_origin = CGPoint(x: 0, y: xm_height - labelBottom!.xm_height)
    }
}
class XMFindNoticeHeadCell: XMCommonCollectionViewCell {
    
    fileprivate var topView: XMFIndNoticeHeadTopView?
    fileprivate var labelTitle: UILabel?
    
    override func initWithSubViews() {
        super.initWithSubViews()
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        topView = XMFIndNoticeHeadTopView()
        contentView.addSubview(topView!)
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.systemFont(ofSize: 13)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (250, 250, 250))
        contentView.addSubview(labelTitle!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        topView?.xm_origin = CGPoint(x: 0, y: 0)
        topView?.xm_size = CGSize(width: contentView.xm_width, height: contentView.xm_width)
        labelTitle?.xm_origin = CGPoint(x: 5, y: topView!.xm_bottom)
        labelTitle?.xm_size = CGSize(width: contentView.xm_width - 10, height: 30)
    }
}

class XMFindNoticeCollectionCell: XMCommonCollectionViewCell {
    
    override func initWithSubViews() {
        super.initWithSubViews()
        
        contentView.addSubview(collectionView)
    }
    
    var lists: [XMCycleListModel]? {
        didSet {
            if lists != nil && lists!.count > 0 {
                collectionView.reloadData()
            }
        }
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 110)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.contentInset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
        view.register(XMFindNoticeHeadCell.self, forCellWithReuseIdentifier: "XMFindNoticeHeadCell_identify")
        view.delegate = self
        view.dataSource = self
        return view
    }()
}

extension XMFindNoticeCollectionCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XMFindNoticeHeadCell_identify", for: indexPath) as! XMFindNoticeHeadCell
        if let models = lists {
            let model = models[indexPath.row]
            cell.topView?.imageView?.setImage(urlString: model.logo, placeHolderName: "find_albumcell_cover_bg")
            cell.labelTitle?.text = model.name
        }
        
        return cell
        
    }
    
    
}
