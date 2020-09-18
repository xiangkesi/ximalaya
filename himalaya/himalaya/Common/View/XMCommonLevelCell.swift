//
//  XMCommonLevelCell.swift
//  himalaya
//
//  Created by cocoazhang on 2020/9/6.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit


class XMCommonLevelTopView: UIView {
    
    var imageView: UIImageView?
    var labelBottomTitle: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView = UIImageView()
        addSubview(imageView!)
        
        labelBottomTitle = UILabel()
        labelBottomTitle?.xm_size = CGSize(width: 100, height: 20)
        labelBottomTitle?.xm_origin = CGPoint(x: 0, y: 75)
        labelBottomTitle?.backgroundColor = UIColor(white: 0.3, alpha: 0.1)
        addSubview(labelBottomTitle!)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XMCommonLevelCell: UICollectionViewCell {
    
    
    var topView: XMCommonLevelTopView?
    var labelTitle: UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        topView = XMCommonLevelTopView()
        topView?.xm_origin = CGPoint(x: 0, y: 0)
        topView?.xm_size = CGSize(width: contentView.xm_width, height: contentView.xm_width)
        contentView.addSubview(topView!)
        
        labelTitle = UILabel()
        labelTitle?.xm_origin = CGPoint(x: 10, y: topView!.xm_bottom + 10)
        labelTitle?.xm_size = CGSize(width: contentView.xm_width - 20, height: 0)
        labelTitle?.numberOfLines = 2
        contentView.addSubview(labelTitle!)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



protocol XMCommonFocusImageCellDelegate: NSObjectProtocol {
   func clickCell(cell: XMCommonFocusImageCell, atIndex index: Int)
}

class XMCommonFocusImageCell: UICollectionViewCell {
    
    
    private var banderView: FSPagerView?
    private var pageControl: FSPageControl?
    weak var delegate: XMCommonFocusImageCellDelegate?
    
    var imageUrls: [String]? {
        didSet {
            guard let urls = imageUrls, urls.count > 0 else {
                return
            }
            banderView?.itemSize = CGSize(width: content_view_width, height: contentView.xm_height)
            pageControl?.xm_width = CGFloat(urls.count * 14)
            pageControl?.numberOfPages = urls.count
            banderView?.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithSubviews()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        banderView?.frame = bounds
        pageControl?.xm_y = banderView!.xm_height - pageControl!.xm_height - 10
        pageControl?.xm_centerX = banderView!.xm_centerX
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XMCommonFocusImageCell: FSPagerViewDelegate, FSPagerViewDataSource {
    private func initWithSubviews() {
//        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        banderView = FSPagerView()
        banderView?.register(XMPagerViewCell.self, forCellWithReuseIdentifier: "XMPagerViewCell")
        banderView?.delegate = self
        banderView?.dataSource = self
        banderView?.automaticSlidingInterval = 6
        banderView?.isInfinite = true
        banderView?.backgroundColor = UIColor.xm.dynamicRGB((230, 230, 230), (30, 30, 30))
        banderView?.interitemSpacing = xm_padding
        contentView.addSubview(banderView!)
            
        pageControl = FSPageControl()
        pageControl?.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
        pageControl?.xm_height = 16
        pageControl?.layer.cornerRadius = 8
            
        pageControl?.contentHorizontalAlignment = .center
        pageControl?.contentInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        pageControl?.hidesForSinglePage = true
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
