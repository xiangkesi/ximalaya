//
//  XMPageTitleView.swift
//  himalaya
//
//  Created by Farben on 2020/8/31.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit


protocol XMPageTitleViewDelegate: NSObjectProtocol {
    
    func clickCell(titleView: XMPageTitleView, cell: XMTitleViewCell, item: XMPageItem, index: Int)
}
class XMPageTitleView: UIView {

    weak var delegate: XMPageTitleViewDelegate?
    
    var items: [XMPageItem]? {
        didSet {
            guard let _ = items else {
                return
            }
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.yellow
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    private lazy var collectionView: UICollectionView = {
        let flewLayout = UICollectionViewFlowLayout()
        flewLayout.minimumLineSpacing = xm_padding
        flewLayout.minimumInteritemSpacing = xm_padding
        flewLayout.sectionInset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: xm_padding)
        flewLayout.scrollDirection = .horizontal
        let c_view = UICollectionView(frame: CGRect.zero, collectionViewLayout: flewLayout)
        c_view.dataSource = self
        c_view.delegate = self
        c_view.backgroundColor = UIColor.clear
        c_view.register(XMTitleViewCell.self, forCellWithReuseIdentifier: XMTitleViewCell.XMTitleViewCell_identify)
        return c_view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension XMPageTitleView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XMTitleViewCell.XMTitleViewCell_identify, for: indexPath) as! XMTitleViewCell
        
        if let titles = items {
            let item = titles[indexPath.row]
            cell.item = item
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.delegate != nil {
            guard let cell = collectionView.cellForItem(at: indexPath) as? XMTitleViewCell else {
                return
            }
            self.delegate?.clickCell(titleView: self, cell: cell, item: cell.item!, index: indexPath.row)
        }
    }
    
    
}

class XMTitleViewCell: UICollectionViewCell {
    
    static let XMTitleViewCell_identify = "XMTitleViewCell_identify"
    
    var item: XMPageItem? {
        didSet {
            titleLabel.text = item?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = UIColor.blue
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
