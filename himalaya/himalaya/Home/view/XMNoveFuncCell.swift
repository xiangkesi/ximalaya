//
//  XMNoveFuncCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/27.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift
class XMNoveFuncCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(labelTitle)
    }
    
    lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.xm.xm_255_30_color
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.xm.dynamicRGB((20, 20, 20), (205, 205, 205))
        label.layer.cornerRadius = 15
        label.layer.masksToBounds = true
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelTitle.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class XMNoveFlimCell: UICollectionViewCell {
    
    
    private var cells = [XMCommonGuessLikeView]()
    
    var layout: XMNoveLayout? {
        didSet {
            imageView.setWebpImage(urlString: layout?.categoryContent?.lists?.first?.smallLogo, placeHolderName: "new_playpage_default_wide")
            labelTitle.attributedText = layout?.hotFilmAttr
            
            if let models = layout?.categoryContent?.lists?.first?.albums, models.count > 0 {
                
                for (index, cell) in cells.enumerated() {
                    if index < models.count {
                        let album = models[index]
                        cell.mainView?.imageView.setWebpImage(urlString: album.model?.albumCoverUrl290, placeHolderName: "find_albumcell_cover_bg")
                        cell.labelTitle?.xm_height = album.titleHeight
                        cell.labelTitle?.attributedText = album.titleAttr
                    }
                }
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(mainView)
        mainView.addSubview(imageView)
        mainView.addSubview(labelTitle)
        
        let cellWidth = UIDevice.isPad ? floor((content_view_width - 70) / 6) : floor((content_view_width - 40) / 3)
        let cellHeight = cellWidth + 60
        let leftPadding: CGFloat = 10
        let medilePading: CGFloat = ceil(((content_view_width - cellWidth * 3) - 20) * 0.5)
        for index in 0..<3 {
            let filmView = XMCommonGuessLikeView()
            filmView.xm_y = labelTitle.xm_bottom + xm_padding
            filmView.xm_size = CGSize(width: cellWidth, height: cellHeight)
            filmView.xm_x = leftPadding + (cellWidth + medilePading) * CGFloat(index)
            mainView.addSubview(filmView)
            cells.append(filmView)
        }
    }
    
    
    private lazy var imageView: UIImageView = {
        let  image_view = UIImageView()
        image_view.xm_origin = CGPoint(x: 0, y: 0)
        image_view.xm_size = CGSize(width: mainView.xm_width, height: ceil(mainView.xm_width * 0.417))
        return image_view
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.xm.xm_255_30_color
        view.frame = CGRect(x: xm_padding, y: 0, width: content_view_width, height: contentView.xm_height)
        return view
    }()
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.xm_origin = CGPoint(x: xm_padding, y: 20)
        label.xm_size = CGSize(width: mainView.xm_width - 30, height: 50)
        label.numberOfLines = 2
        return label
    }()
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMNoveAdCardCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(leftImageView)
        contentView.addSubview(rightImageView)
        leftImageView.xm_size = CGSize(width: floor((contentView.xm_width - 30) * 0.67), height: contentView.xm_height)
        rightImageView.frame = CGRect(origin: CGPoint(x: leftImageView.xm_right, y: 0), size: CGSize(width: (contentView.xm_width - 30) - leftImageView.xm_width, height: contentView.xm_height))
        
    }
    
    lazy var leftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.xm_origin = CGPoint(x: xm_padding, y: 0)
        imageView.backgroundColor = UIColor.red
        return imageView
    }()
    
    lazy var rightImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = UIColor.brown
        return view
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMNoveWeekCell: UICollectionViewCell {
    
    
    
    var layout: XMNoveLayout? {
        didSet {
            labelTitle.text = layout?.categoryContent?.title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(mainView)
        mainView.addSubview(topView)
        mainView.addSubview(weekView)
        mainView.addSubview(collectionView)
        mainView.addSubview(btnExchange)
    }
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.xm.xm_255_30_color
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = false
        view.xm_origin = CGPoint(x: xm_padding, y: 0)
        view.xm_size = CGSize(width: contentView.xm_width - 30, height: contentView.xm_height)
        return view
    }()
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.xm_origin = CGPoint(x: 0, y: 0)
        view.xm_size = CGSize(width: mainView.xm_width, height: 40)
        let bottomLine = UIView()
        bottomLine.xm_size = CGSize(width: view.xm_width, height: 1)
        bottomLine.xm_origin = CGPoint(x: 0, y: view.xm_height - bottomLine.xm_height)
        bottomLine.backgroundColor = UIColor.xm.dynamicRGB((245, 245, 245), (40, 40, 40))
        view.addSubview(bottomLine)
        view.addSubview(topImageView)
        view.addSubview(buttonMore)
        view.addSubview(labelTitle)
        return view
    }()
    
    private lazy var weekView: XMNoveWeekView = {
        let view = XMNoveWeekView()
        view.xm_origin = CGPoint(x: 0, y: topView.xm_bottom)
        view.xm_size = CGSize(width: mainView.xm_width, height: 40)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let c_view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        c_view.backgroundColor = UIColor.clear
        c_view.xm_origin = CGPoint(x: 0, y: weekView.xm_bottom)
        c_view.xm_size = CGSize(width: weekView.xm_width, height: mainView.xm_height - 116)
        return c_view
    }()
    
    private lazy var btnExchange: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor.colorWidthHexString(hex: "888888"), for: UIControl.State.normal)
        btn.xm_origin = CGPoint(x: 0, y: collectionView.xm_bottom)
        btn.xm_size = CGSize(width: collectionView.xm_width, height: 36)
        btn.setImage(UIImage(named: "find_change_batch_new"), for: UIControl.State.normal)
        btn.setTitle("   换一批", for: UIControl.State.normal)
        return btn
    }()
    
    private lazy var topImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.xm_size = CGSize(width: 30, height: 30)
        imageView.xm_origin = CGPoint(x: 10, y: 5)
        imageView.image = UIImage(named: "weeklyAlbumIcon")
        return imageView
    }()
    private lazy var buttonMore: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.xm_size = CGSize(width: 100, height: 40)
        btn.xm_origin = CGPoint(x: mainView.xm_width - btn.xm_width - xm_padding, y: 0)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.setTitleColor(UIColor.xm.dynamicRGB((150, 150, 150), (150, 150, 150)), for: UIControl.State.normal)
        btn.contentHorizontalAlignment = .right
        return btn
    }()
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.xm_size = CGSize(width: buttonMore.xm_x - topImageView.xm_right - 10, height: 30)
        label.xm_origin = CGPoint(x: topImageView.xm_right + 10, y: topImageView.xm_y)
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (220, 220, 220))
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMNoveWeekView: UIView {
    
    let disposeBag = DisposeBag()
    
    private lazy var layerBg: CALayer = {
        let line_bg = CALayer()
        line_bg.cornerRadius = 15
        line_bg.backgroundColor = UIColor.colorWidthHexString(hex: mainColorString).cgColor
        line_bg.opacity = 0.2
        return line_bg
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let labelWidth: CGFloat = ceil((content_view_width - 80) / 7)
        let labelHeight: CGFloat = 40
        let margen: CGFloat = 10
        layerBg.xm_size = CGSize(width: labelWidth, height: 30)
        layerBg.xm_y = 5
        layer.addSublayer(layerBg)
        let titles = ["一", "二", "三", "四", "五", "六", "七"]
        let week = Date().getWeekDay() - 1
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer()
            tap.rx.event.subscribe(onNext: {[weak self](tap) in
                UIView.animate(withDuration: 0.1, animations: {
                    self?.layerBg.xm_x = label.xm_x
                }) { (finish) in
                    
                }
            }).disposed(by: disposeBag)
            label.addGestureRecognizer(tap)
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (220, 220, 220))
            label.xm_size = CGSize(width: labelWidth, height: labelHeight)
            label.xm_y = 0
            label.xm_x = margen + (labelWidth + margen) * CGFloat(index)
            if week == index {
                label.text = "今"
                layerBg.xm_x = label.xm_x
            }else {
                label.text = title
            }
            addSubview(label)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
