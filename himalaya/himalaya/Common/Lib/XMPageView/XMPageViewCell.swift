//
//  XMPageViewCell.swift
//  himalaya
//
//  Created by Farben on 2020/8/24.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMPageViewCell: UICollectionViewCell {
    
    lazy var controller: PageOneController = {
        let vc = PageOneController()
        return vc
    }()
    
     var isAddContentViewController: Bool = false
    
    
    lazy var labelTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.white
        title.font = UIFont.boldSystemFont(ofSize: 100)
        title.text = "这是首页哟"
        title.numberOfLines = 0
        return title
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(controller.view)
        contentView.addSubview(labelTitle)
      print("首页创建了多少次呢")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        controller.view.frame = contentView.bounds
        labelTitle.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class XMPageCommonViewCell: UICollectionViewCell {
    
    var isAddContentViewController: Bool = false
    
    var theOnlyId: Int = 1000
    
    
    lazy var conterollerView: CommonPageViewController = {
        let vc = CommonPageViewController()
        return vc
    }()
    
    lazy var labelTitle: UILabel = {
        let title = UILabel()
        title.textColor = UIColor.cyan
        title.font = UIFont.boldSystemFont(ofSize: 100)
        title.numberOfLines = 0
        return title
    }()
    
    lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(conterollerView.view)
        contentView.addSubview(loadingView)
        contentView.addSubview(labelTitle)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        conterollerView.view.frame = contentView.bounds
        labelTitle.frame = contentView.bounds
        loadingView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
