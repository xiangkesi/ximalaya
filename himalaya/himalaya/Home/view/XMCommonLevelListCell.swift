//
//  XMCommentListCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/31.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMCommonLevelListCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(collectionView)
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
//        view.contentInset = UIEdgeInsets(top: 0, left: xm_padding, bottom: 0, right: 5)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class XMCommonLevelListDetailTopView: UIView {
    
    
    lazy var imageView: UIImageView = {
        let i_view = UIImageView()
        return i_view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XMCommonLevelListDetailCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = false
        contentView.addSubview(topView)
        contentView.addSubview(labelTitle)
    }
    
    lazy var topView: XMCommonLevelListDetailTopView = {
        let t_view = XMCommonLevelListDetailTopView()
        t_view.xm_origin = CGPoint(x: 0, y: 0)
        t_view.xm_size = CGSize(width: contentView.xm_width, height: contentView.xm_width)
        return t_view
    }()
    lazy var labelTitle: UILabel = {
        let l_view = UILabel()
        l_view.xm_origin = CGPoint(x: 0, y: topView.xm_bottom + 10)
        l_view.xm_size = CGSize(width: contentView.xm_width, height: 0)
        l_view.numberOfLines = 2
        return l_view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMCommonLevelListTopCell: UICollectionViewCell {
    
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.xm.dynamicRGB((20, 20, 20), (220, 220, 220))
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(labelTitle)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelTitle.xm_origin = CGPoint(x: xm_padding, y: 0)
        labelTitle.xm_size = CGSize(width: contentView.xm_width - 30, height: contentView.xm_height)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class XMCommonVerticalHeadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(labelTitle)
        addSubview(btnListen)
    }
    
    lazy var labelTitle: UILabel = {
        let l_label = UILabel()
        l_label.xm_origin = CGPoint(x: 10, y: 10)
        l_label.xm_size = CGSize(width: 200, height: 40)
        l_label.font = UIFont.boldSystemFont(ofSize: 14)
        l_label.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (230, 230, 230))
        return l_label
    }()
    lazy var btnListen: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.xm_size = CGSize(width: 70, height: 30)
        btn.xm_origin = CGPoint(x: content_view_width - btn.xm_width - xm_padding, y: 15)
        btn.backgroundColor = UIColor.colorWithrgba(223, 80, 62)
        btn.layer.cornerRadius = 15
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        btn.setTitle("一键收听", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.white, for: UIControl.State.normal)
        return btn
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XMCommonVerticalListCell: UICollectionViewCell {
    
    
    var cells = [XMCommonVerTicalDetailView]()
    
    var layout: XMNoveLayout? {
        didSet {
            if let sleeps = layout?.categoryContent?.lists?.first?.sleepNights {
                for (index, cell) in cells.enumerated() {
                    if index < sleeps.count {
                        cell.isHidden = false
                        let sleep = sleeps[index]
                        cell.labelTitle.text = sleep.title
                    }else {
                        cell.isHidden = true
                    }
                }
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = false
        contentView.backgroundColor = UIColor.xm.xm_255_30_color
        contentView.addSubview(headView)
        
        for index in 0..<5 {
            let cell = XMCommonVerTicalDetailView()
            cell.xm_size = CGSize(width: content_view_width, height: 46)
            cell.xm_origin = CGPoint(x: 0, y:headView.xm_bottom + CGFloat(index) * cell.xm_height)
            contentView.addSubview(cell)
            cells.append(cell)
        }
        contentView.addSubview(btnMore)
    }
    
    lazy var btnMore: UIButton = {
        let b_btn = UIButton(type: UIButton.ButtonType.custom)
        b_btn.xm_size = CGSize(width: contentView.xm_width, height: 40)
        b_btn.xm_origin = CGPoint(x: 0, y: contentView.xm_height - b_btn.xm_height)
        b_btn.setTitle("查看更多", for: UIControl.State.normal)
        b_btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        b_btn.setTitleColor(UIColor.xm.dynamicRGB((50, 50, 50), (230, 230, 230)), for: UIControl.State.normal)
        
        let imageView = UIImageView()
        imageView.xm_size = CGSize(width: b_btn.xm_width, height: 1)
        imageView.xm_origin = CGPoint(x: 0, y: 0)
        imageView.image = UIImage(named: "line_image_dark")
        b_btn.addSubview(imageView)
        return b_btn
    }()
    lazy var headView: XMCommonVerticalHeadView = {
        let h_headView = XMCommonVerticalHeadView()
        h_headView.xm_origin = CGPoint(x: 0, y: 0)
        h_headView.xm_size = CGSize(width: contentView.xm_width, height: 50)
        return h_headView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
class XMCommonVerTicalDetailView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(labelTitle)
    }
    
    lazy var imageView: UIImageView = {
        let i_imageView = UIImageView()
        i_imageView.xm_size = CGSize(width: 30, height: 30)
        i_imageView.xm_origin = CGPoint(x: xm_padding, y: 8)
        i_imageView.image = UIImage(named: "newer_rec_video_play")
        return i_imageView
    }()
    lazy var labelTitle: UILabel = {
        let l_label = UILabel()
        l_label.font = UIFont.systemFont(ofSize: 13)
        l_label.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (230, 230, 230))
        l_label.xm_size = CGSize(width: content_view_width - imageView.xm_right - 30, height: 30)
        l_label.xm_origin = CGPoint(x: imageView.xm_right, y: 8)
        return l_label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
