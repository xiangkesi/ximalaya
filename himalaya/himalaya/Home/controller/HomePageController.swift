//
//  HomePageController.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift
class HomePageController: XMBaseViewController {

    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func initWithSubviews() {
        super.initWithSubviews()
        
        let rightItem = UIBarButtonItem(customView: btnCategoary)
        navigationItem.rightBarButtonItem = rightItem
        navigationItem.titleView = pageViewManager.titleView
        let contentView = pageViewManager.contentView
        view.addSubview(contentView)
        if #available(iOS 11, *) {
            contentView.collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageViewManager.titleView.frame = CGRect(x: 0, y: 0, width: view.xm_width, height: 44)
        pageViewManager.contentView.frame = view.bounds
    }
    
    private lazy var btnCategoary: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
//        btn.backgroundColor = UIColor.red
        btn.setImage(UIImage(named: "xm_home_more"), for: UIControl.State.normal)
        btn.xm_size = CGSize(width: 30, height: 30)
        btn.rx.tap.subscribe(onNext: {[weak self] in
            let categoryVc = XMHomeCategoryController()
            self?.navigationController?.pushViewController(categoryVc, animated: true)
        }).disposed(by: disposeBag)
        return btn
    }()
    
//    private lazy var navView: HomeNavView = {
//        let nav_view = HomeNavView()
//        return nav_view
//    }()
    
    private lazy var pageViewManager: PageViewManager = {
        let style = PageStyle()
        style.isShowBottomLine = true
        style.isTitleViewScrollEnabled = true
        style.titleViewBackgroundColor = UIColor.clear
        style.titleColor = UIColor.xm.dynamicRGB((30, 30, 30), (220, 220, 220))
        style.titleSelectedColor = UIColor.xm.dynamicRGB((0, 0, 0), (255, 255, 255))
        style.titleFont = UIFont.boldSystemFont(ofSize: 17)
        style.titleSelectedFont = UIFont.boldSystemFont(ofSize: 17)
        style.bottomLineColor = UIColor.xm.dynamicRGB((231, 108, 77), (255, 255, 255))
        style.bottomLineWidth = 26
        style.bottomLineHeight = 4
        style.isTitleScaleEnabled = true
        let dics: [[String: String]] = [["title": "推荐", "controller": "HomeRcmdController"],
                    ["title": "VIP", "controller": "XMVipViewController"],
                    ["title": "小说", "controller": "XMNovelViewController"],
                    ["title": "直播", "controller": "XMLiveViewController"],
                    ["title": "少儿教育", "controller": "XMHomeCommonController"],
                    ["title": "儿童", "controller": "XMHomeCommonController"],
                    ["title": "博客", "controller": "XMHomeCommonController"],
                    ["title": "精品", "controller": "XMHomeCommonController"],
                    ["title": "广播", "controller": "XMHomeCommonController"]]
//        XMHomeCommonController
        var titleItems = [PageTitleItem]()
        var vcs = [UIViewController]()
        for dic in dics {
            var cls: UIViewController.Type?
            if (NSClassFromString(Bundle.nameSpace + "." + dic["controller"]!) as? UIViewController.Type) != nil{
                cls = NSClassFromString(Bundle.nameSpace + "." + dic["controller"]!) as? UIViewController.Type
                let vc = cls!.init()
                vcs.append(vc)
                addChild(vc)
                let item = PageTitleItem()
                item.title = dic["title"]!
                titleItems.append(item)
            }
        }
        
        return PageViewManager(style: style, titleItems: titleItems, childViewControllers: vcs)
    }()
    
    
}

//extension HomePageController: HideNavigationBarProtocol {}
