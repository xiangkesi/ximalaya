//
//  XMLiveCell.swift
//  himalaya
//
//  Created by cocoazhang on 2020/8/29.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMLiveCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(layerBg)
        contentView.addSubview(topLeftImageView)
        contentView.addSubview(headView)
        contentView.addSubview(labelUserName)
        contentView.addSubview(labelTitle)
        contentView.addSubview(animationImageView)
    }
    
    
    private lazy var images: [UIImage] = {
        var i_images = [UIImage]()
        for index in 0..<24 {
            if let image = UIImage(named: "live_wave\(index)") {
                i_images.append(image)
            }
        }
        return i_images
    }()
    
    private let path = Bundle.main.path(forResource: "live_play_anim", ofType: "gif")
    
    var layout: XMLiveLayout? {
        didSet {
            imageView.setImage(urlString: layout?.hall?.coverMiddle, placeHolderName: "find_albumcell_cover_bg")
            headView.setImage(urlString: layout?.hall?.avatar, placeHolderName: "find_vip_default_icon")
            labelUserName.text = layout?.hall?.nickname
            labelTitle.text = layout?.hall?.name
//            animationImageView.kf.setImage(with: URL(fileURLWithPath: path!))
//            if animationImageView.isAnimating == false {
//                animationImageView.animationImages = images
//                animationImageView.startAnimating()
//            }
            
        }
    }
    
    
    private lazy var topLeftImageView: UIImageView = {
        let l_view = UIImageView()
        l_view.xm_size = CGSize(width: 50, height: 24)
        l_view.xm_origin = CGPoint(x: 0, y: 0)
        l_view.image = UIImage(named: "tag_cover_live_ing")
        return l_view
    }()
    private lazy var labelTitle: UILabel = {
        let l_title = UILabel()
        l_title.font = UIFont.boldSystemFont(ofSize: 15)
        l_title.textColor = UIColor.white
        l_title.xm_size = CGSize(width: contentView.xm_width - 20, height: 24)
        l_title.xm_origin = CGPoint(x: 10, y: headView.xm_y - 30)
        return l_title
    }()
    
    private lazy var headView: UIImageView = {
        let h_view = UIImageView()
        h_view.xm_size = CGSize(width: 24, height: 24)
        h_view.xm_origin = CGPoint(x: 10, y: contentView.xm_height - h_view.xm_height - 10)
        h_view.layer.cornerRadius = 12
        h_view.layer.masksToBounds = true
        return h_view
    }()
    private lazy var layerBg: UIImageView = {
        let l_bg = UIImageView()
        l_bg.frame = contentView.bounds
        l_bg.layer.cornerRadius = 5
        l_bg.layer.masksToBounds = false
        l_bg.image = UIImage(named: "find_mask_96")
        return l_bg
    }()
    private lazy var labelUserName: UILabel = {
        let l_name = UILabel()
        l_name.font = UIFont.systemFont(ofSize: 13)
        l_name.xm_height = 24
        l_name.xm_x = headView.xm_right + 5
        l_name.xm_width = contentView.xm_width - l_name.xm_x - xm_padding - 50
        l_name.xm_y = headView.xm_y
        l_name.textColor = UIColor.white
        return l_name
    }()
    private lazy var imageView: UIImageView = {
        let i_view = UIImageView()
        i_view.frame = contentView.bounds
        i_view.layer.cornerRadius = 5
        i_view.layer.masksToBounds = true
        return i_view
    }()
    
    private lazy var animationImageView: UIImageView = {
        let a_view = UIImageView()
        a_view.xm_size = CGSize(width: 16, height: 16)
        a_view.xm_x = contentView.xm_width - xm_padding - a_view.xm_width
        a_view.xm_centerY = headView.xm_centerY
//        a_view.animationDuration = 1
//        a_view.animationImages = self.images
//        a_view.animationRepeatCount = Int(MAXFRAG)
//        a_view.startAnimating()
        return a_view
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMLiveChatRoomCell: UICollectionViewCell {
    
    
    private var cells = [XMLiveChatRoomDetailCell]()
    
    var layout: XMLiveLayout? {
        didSet {
            guard let models = layout?.hotModuleModel?.halls, models.count > 0 else {
                return
            }
            labelTitle.text = layout?.hotModuleModel?.cardName
            for (index, view) in cells.enumerated() {
                if index < models.count {
                    let model = models[index]
                    view.labelTitle.text = model.name
                    view.imageView.setImage(urlString: model.avatar, placeHolderName: "find_vip_default_icon")
                    view.labelCount.text = "\(model.onlineCnt)"
                }
            }
        }
    }
    private lazy var viewTop: UIView = {
        let v_top = UIView()
        v_top.xm_size = CGSize(width: contentView.xm_width, height: 40)
        v_top.xm_origin = CGPoint(x: 0, y: 0)
        v_top.addSubview(labelTitle)
        return v_top
    }()
    
    private lazy var labelTitle: UILabel = {
        let l_title = UILabel()
        l_title.xm_origin = CGPoint(x: xm_padding, y: 10)
        l_title.xm_size = CGSize(width: 200, height: 20)
        l_title.font = UIFont.boldSystemFont(ofSize: 15)
        l_title.textColor = UIColor.xm.dynamicRGB((50, 50, 50), (230, 230, 230))
        return l_title
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let mainView = UIView()
        mainView.frame = contentView.bounds
        mainView.backgroundColor = UIColor.xm.xm_255_30_color
        mainView.layer.cornerRadius = 5
        contentView.addSubview(mainView)
        contentView.addSubview(viewTop)
        

        let topCellWidth = floor(contentView.xm_width * 0.5)
        
        var topViewY: CGFloat = 0
        for index in 0..<2 {
            let r_view = XMLiveChatRoomDetailCell()
            r_view.xm_size = CGSize(width: topCellWidth, height: 120)
            r_view.xm_origin = CGPoint(x: r_view.xm_width * CGFloat(index), y: viewTop.xm_bottom)
            r_view.labelTitle.xm_origin = CGPoint(x: xm_padding, y: 10)
            r_view.labelTitle.xm_size = CGSize(width: r_view.xm_width - 30, height: 26)
            r_view.labelTitle.font = UIFont(name: "Helvetica-Bold", size: 15)
            r_view.imageView.xm_size = CGSize(width: 50, height: 50)
            r_view.imageView.layer.cornerRadius = 25
            r_view.imageView.layer.masksToBounds = true
            r_view.imageView.xm_origin = CGPoint(x: xm_padding, y: r_view.xm_height - r_view.imageView.xm_height - xm_padding)
            r_view.backgroundColor = index == 0 ? UIColor.colorWithrgba(51, 80, 84) : UIColor.colorWithrgba(90, 68, 50)
            r_view.labelTitle.textColor = index == 0 ? UIColor.colorWithrgba(139, 205, 212) : UIColor.colorWithrgba(225, 165, 117)
            cells.append(r_view)
            contentView.addSubview(r_view)
            topViewY = r_view.xm_bottom
        }
        let cellWidth: CGFloat = floor(contentView.xm_width / 3)
        for index in 0..<3 {
            let r_view = XMLiveChatRoomDetailCell()
            r_view.xm_size = CGSize(width: cellWidth, height: 120)
            r_view.xm_origin = CGPoint(x: cellWidth * CGFloat(index), y: topViewY)
            if index < 2 {
                let lineRight = UIView()
                lineRight.xm_size = CGSize(width: 1, height: r_view.xm_height)
                lineRight.backgroundColor = UIColor.xm.dynamicRGB((245, 245, 245), (41, 42, 43))
                lineRight.xm_origin = CGPoint(x: r_view.xm_width - lineRight.xm_width, y: 0)
                r_view.addSubview(lineRight)
            }
            
            r_view.labelTitle.xm_origin = CGPoint(x: xm_padding, y: 10)
            r_view.labelTitle.xm_size = CGSize(width: r_view.xm_width - 30, height: 20)
            r_view.labelTitle.font = UIFont(name: "Helvetica-Bold", size: 14)
            r_view.labelTitle.textColor = UIColor.xm.dynamicRGB((20, 20, 20), (210, 210, 210))
            
            r_view.imageView.xm_size = CGSize(width: 36, height: 36)
            r_view.imageView.xm_origin = CGPoint(x: ceil((r_view.xm_width - r_view.imageView.xm_width) * 0.5), y: r_view.labelTitle.xm_bottom + xm_padding)
            r_view.imageView.layer.cornerRadius = 18
            r_view.imageView.layer.masksToBounds = true
            
            r_view.imageAnimationView.xm_size = CGSize(width: 12, height: 12)
            r_view.labelCount.xm_size = CGSize(width: 50, height: 16)
            r_view.imageAnimationView.xm_origin = CGPoint(x: ceil((r_view.xm_width - r_view.imageAnimationView.xm_width - r_view.labelCount.xm_width) * 0.5), y: r_view.imageView.xm_bottom + xm_padding)
            r_view.labelCount.xm_origin = CGPoint(x: r_view.imageAnimationView.xm_right, y: r_view.imageAnimationView.xm_y)
            r_view.labelCount.font = UIFont.systemFont(ofSize: 12)
            r_view.labelCount.textColor = UIColor.xm.dynamicRGB((160, 160, 160), (130, 130, 130))
            contentView.addSubview(r_view)
            r_view.imageAnimationView.startAnimating()
            cells.append(r_view)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMLiveChatRoomDetailCell: UIView {
    
    lazy var imageView: UIImageView = {
        let i_view = UIImageView()
        return i_view
    }()
    lazy var labelTitle: UILabel = {
        let l_title = UILabel()
        return l_title
    }()
    lazy var imageAnimationView: UIImageView = {
        let a_view = UIImageView()
        a_view.image = UIImage(named: "main_ic_album_play_idle_flag")
//        var loadingArrayImage = [UIImage]()
//        for index in 2..<20 {
//            let imageName = "host_play_flag_wave_" + String(index)
//            if let image = UIImage(named: imageName) {
//                loadingArrayImage.append(image)
//            }
//        }
//        a_view.animationDuration = 1
//        a_view.animationImages = loadingArrayImage
//        a_view.animationRepeatCount = 10000000
        return a_view
    }()
    lazy var labelCount: UILabel = {
        let l_count = UILabel()
        return l_count
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(labelTitle)
        addSubview(imageAnimationView)
        addSubview(labelCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



class XMLiveFocusImageCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.addSubview(banderView)
    }
    
    var layout: XMLiveLayout? {
        didSet {
             banderView.itemSize = contentView.bounds.size
            if layout?.cellType == XMLiveLayout.XMLiveCellType.focusImage {
                if let focusImage = layout?.focusImageModels, focusImage.count > 0 {
                    banderView.reloadData()
                }
            }else {
                if let rankSections = layout?.rankModel?.rankSection, rankSections.count > 0 {
                    banderView.reloadData()
                }
            }
            
        }
    }
    
    private lazy var imageView: UIImageView = {
        let i_view = UIImageView()
        i_view.frame = contentView.bounds
        i_view.image = UIImage(named: "live_guardian_status_bg_green")
        return i_view
    }()
    
    private lazy var banderView: FSPagerView = {
        let b_view = FSPagerView()
        b_view.automaticSlidingInterval = 6
        b_view.isInfinite = true
        b_view.backgroundColor = .clear
        b_view.register(XMLiveFocusImageDetailCell.self, forCellWithReuseIdentifier: "XMLiveFocusImageDetailCell_identify")
        b_view.register(XMLiveRankCell.self, forCellWithReuseIdentifier: "XMLiveRankCell_identify")
        b_view.dataSource = self
//        banderView?.interitemSpacing = xm_padding
    
        return b_view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        banderView.frame = contentView.bounds
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XMLiveFocusImageCell: FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        
        return layout?.cellType == XMLiveLayout.XMLiveCellType.focusImage ? (layout?.focusImageModels?.count ?? 0) : (layout?.rankModel?.rankSection?.count ?? 0)
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
       
        if layout?.cellType == XMLiveLayout.XMLiveCellType.focusImage {
             let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "XMLiveFocusImageDetailCell_identify", at: index)
            let focusModel = layout?.focusImageModels![index]
            cell.imageView?.setImage(urlString: focusModel?.cover, placeHolderName: "new_playpage_default_wide")
            return cell
        }else {
             let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "XMLiveRankCell_identify", at: index) as! XMLiveRankCell
            let rankModel = layout?.rankModel?.rankSection![index]
            cell.labelLeftTitle.text = rankModel?.dimensionName
            cell.userMsgs = rankModel?.ranks
            return cell
        }
        
        
        
    }
    
    
}

class XMLiveRankCell: FSPagerViewCell {
    
    
    var userMsgs: [XMLiveRankUserMsgModel]? {
        didSet {
            if let users = userMsgs, users.count > 0 {
                for (index, cell) in cells.enumerated() {
                    if index < users.count {
                        cell.isHidden = false
                        let user = users[index]
                        cell.setImage(urlString: user.coverSmall, placeHolderName: "find_vip_default_icon")
                    }else {
                        cell.cancelRequest()
                        cell.isHidden = true
                    }
                }
            }
        }
    }
    private var cells = [UIImageView]()
    private let cellHeight = UIDevice.isPad ? 80 : ceil(content_view_width * 0.2)
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(labelLeftTitle)
        for index in 0..<3 {
            let image_view = UIImageView()
            image_view.xm_size = CGSize(width: 36, height: 36)
            image_view.xm_y = ceil((cellHeight - image_view.xm_height) * 0.5)
            image_view.xm_x = content_view_width - xm_padding - CGFloat(30 * index) - image_view.xm_width
            image_view.layer.cornerRadius = image_view.xm_width * 0.5
            image_view.layer.masksToBounds = true
            image_view.isHidden = true
            contentView.addSubview(image_view)
            cells.append(image_view)
        }
    }
    
    lazy var labelLeftTitle: UILabel = {
        let l_title = UILabel()
        l_title.xm_size = CGSize(width: 200, height: 20)
        l_title.xm_origin = CGPoint(x: xm_padding, y: (cellHeight - l_title.xm_height) * 0.5)
        l_title.font = UIFont.boldSystemFont(ofSize: 15)
        l_title.textColor = UIColor.white
        return l_title
    }()
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMLiveFocusImageDetailCell: FSPagerViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView?.layer.cornerRadius = 5
        self.imageView?.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
