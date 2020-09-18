//
//  FindViewController.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class FindPageController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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
        pageViewManager.titleView.frame = CGRect(x: 0, y: 0, width: view.xm_width, height: 40)
        pageViewManager.contentView.frame = view.bounds
    }
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
        
        let vcMsgs = [("关注", "XMFindNoticeController"),
                      ("推荐", "FindRecommendedController"),
                      ("趣配音", "FindVoiceController"),
                      ("小视频", "FindVideoController")]
        var titles = [PageTitleItem]()
        var vcs = [UIViewController]()
        
        for tuple in vcMsgs {
            var cls: UIViewController.Type?
            if (NSClassFromString(Bundle.nameSpace + "." + tuple.1) as? UIViewController.Type) != nil{
                cls = NSClassFromString(Bundle.nameSpace + "." + tuple.1) as? UIViewController.Type
                let vc = cls!.init()
                vcs.append(vc)
                let item = PageTitleItem()
                item.title = tuple.0
                titles.append(item)
            }
        }
        
        return PageViewManager(style: style, titleItems: titles, childViewControllers: vcs, currentIndex: 1)
    }()


}
