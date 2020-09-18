//
//  XMCommonLikeTitleCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/19.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMCommonLikeTitleCell: UICollectionViewCell {
    
    private var labelTitle: UILabel?
    private var cellArray = [XMCommonGuessLikeView]()
    
    private var exchangeBtn: UIButton?

    
    var layout: XMVipLayout? {
        didSet {
            main_view?.xm_height = layout!.cellSize.height
            labelTitle?.text = layout?.module?.moduleName
        
            guard let albums = layout?.module?.albums else {
                return
            }
            for index in 0..<cellArray.count {
                let cell = cellArray[index]
                cell.isHidden = true
                if index < albums.count {
                    cell.isHidden = false
                    let albem = albums[index]
                    cell.mainView?.imageView.setWebpImage(urlString: albem.coverPath, placeHolderName: "find_albumcell_cover_bg")
                    cell.labelTitle?.xm_height = albem.titleAttrHeight
                    cell.labelTitle?.attributedText = albem.titleAttr
                }
            }
        }
    }
    
    var nove_layout: XMNoveLayout? {
        didSet {
            main_view?.xm_height = nove_layout!.cellHeight
            labelTitle?.text = nove_layout?.categoryContent?.title
            guard let albums = nove_layout?.categoryContent?.lists else {
                return
            }
            for (index, view) in cellArray.enumerated() {
                if index < albums.count {
                    view.isHidden = false
                    let album = albums[index]
                    view.mainView?.imageView.setWebpImage(urlString: album.coverMiddle, placeHolderName: "find_albumcell_cover_bg")
                    view.labelTitle?.xm_height = album.titleAttrHeight
                    view.labelTitle?.attributedText = album.titleAttr
                }
            }
            exchangeBtn?.isHidden = (nove_layout?.categoryContent?.loopCount == 2) ? false : true
        }
    }
    
    var qhgLayout: XMHQGLayout? {
        didSet {
            guard let q_layout = qhgLayout,
                let albums = q_layout.resultModule?.albums else {
                return
            }
            main_view?.xm_height = q_layout.cellHeight
            labelTitle?.text = q_layout.resultModule?.title
            for (index, view) in cellArray.enumerated() {
                if index < albums.count {
                    view.isHidden = false
                    let album = albums[index]
                    view.mainView?.imageView.setWebpImage(urlString: album.coverPath, placeHolderName: "find_albumcell_cover_bg")
                    view.labelTitle?.xm_height = album.titleAttrHeight
                    view.labelTitle?.attributedText = album.titleAttr
                }
            }
            exchangeBtn?.isHidden = false
        }
    }
    
    
    var main_view: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cellWidth = UIDevice.isPad ? floor((content_view_width - 80) / 6) : floor((content_view_width - 40) / 3)
        let cellHeight = cellWidth + 60
        let mainView = UIView()
        main_view = mainView
        mainView.backgroundColor = UIColor.xm.xm_255_30_color
        mainView.xm_size = CGSize(width: content_view_width, height: xm_height)
        mainView.xm_origin = CGPoint(x: xm_padding, y: 0)
        mainView.layer.cornerRadius = 5
        mainView.layer.masksToBounds = false
        contentView.addSubview(mainView)
        
        labelTitle = UILabel()
        labelTitle?.font = UIFont.boldSystemFont(ofSize: 15)
        labelTitle?.textColor = UIColor.xm.dynamicRGB((10, 10, 10), (210, 210, 210))
        labelTitle?.xm_origin = CGPoint(x: xm_padding, y: 0)
        labelTitle?.xm_size = CGSize(width: 200, height: 40)
        mainView.addSubview(labelTitle!)
        
        
        var lastCell: XMCommonGuessLikeView?
        for index in 0..<6 {
            let cell = XMCommonGuessLikeView()
            cell.isHidden = true
            cell.xm_size = CGSize(width: cellWidth, height: cellHeight)
            let margin: CGFloat = 10
            var cellX: CGFloat = 0
            var cellY: CGFloat = 0
            if UIDevice.isPad {
                cellY = labelTitle!.xm_bottom
                cellX = margin + floor((cellWidth + margin) * CGFloat(index))
            }else {
                let row = index / 3
                let col = index % 3
                cellY = labelTitle!.xm_bottom + ceil(cellHeight * CGFloat(row))
                cellX = margin + floor((cellWidth + margin) * CGFloat(col))
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


