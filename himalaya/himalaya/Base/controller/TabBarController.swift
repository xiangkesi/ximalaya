//
//  ZSTabBarController.swift
//  gokarting
//
//  Created by Farben on 2020/7/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import Kingfisher
class TabBarController: UITabBarController {

    
    private var itemImageViews = [UIImageView]()
    private var currentIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarView = XMTabBar()
        setValue(tabBarView, forKey: "tabBar")
        setupConfog()
        addAllChildsControllors()
        
//        getImageViews()
//
//        print(itemImageViews)
        
//        XMLaunchBanderView.show(fatnerView: view)
//        XMPreperViewModel.requestAds()
//        KingfisherManager.shared.downloader.downloadImage(with: URL(string: "http://fdfs.xmcdn.com//group87//M00//FB//C6//wKg5J189PyrzlX6KAAHisUlIQns123.jpg")!, options: nil, progressBlock: nil) { result in
//
//            switch result {
//            case let .success(image):
//                print("下载成功了")
//                print(image.image)
//                break
//            case let .failure(error):
//                print("下载出错了")
//                break
//            }
//        }
        
//        KingfisherManager.shared.retrieveImage(with: URL(string: "http://fdfs.xmcdn.com//group80//M00//C6//D7//wKgPDF7Q7C-gRALFAAeA9JAliqw169.gif")!) { (result) in
//            switch result {
//            case let .success(image):
//                print("查找到了")
//                print(image.image)
//                break
//            case let .failure(error):
//                print("查找出错了")
//                break
//            }
//        }
//        
//        KingfisherManager.shared.cache.retrieveImage(forKey: "http://fdfs.xmcdn.com//group87//M00//FB//C6//wKg5J189PyrzlX6KAAHisUlIQns123.jpg") { (result) in
//            switch result {
//            case let .success(image):
//                print("查找到了")
//                print(image.image)
//                break
//            case let .failure(error):
//                print("查找出错了")
//                break
//            }
//        }
//        KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: "http://fdfs.xmcdn.com//group87//M00//FB//C6//wKg5J189PyrzlX6KAAHisUlIQns123.jpg") { (result) in
//            switch result {
//            case let .success(image):
//                print("查找到了")
//                print(image)
//                break
//            case let .failure(error):
//                print("查找出错了")
//                break
//            }
//        }
    }
}

extension TabBarController {
    
    private func addAllChildsControllors() {
//        home_selected
//        home_unselectedmine_selected
        let arrayTuples = [("HomePageController", "首页", "home_"),
                           ("MyTingController", "我听", "mine_ting_"),
                           ("FindPageController", "发现", "find_"),
                           ("XMMineViewController", "我的", "mine_")]
        var arrayVcs = [UIViewController]()
        for tuples in arrayTuples {
            arrayVcs.append(controller(tuples: tuples))
        }
        viewControllers = arrayVcs
    }
    
    private func controller(tuples: (String, String, String)) -> UIViewController {
        var cls: UIViewController.Type?
        if (NSClassFromString(Bundle.nameSpace + "." + tuples.0) as? UIViewController.Type) != nil{
            cls = NSClassFromString(Bundle.nameSpace + "." + tuples.0) as? UIViewController.Type
        }else{
            return UIViewController()
        }
        let vc = cls!.init()
        vc.title = tuples.1
        let navVc = NavgationController(rootViewController: vc)
        
        
        
        navVc.tabBarItem.image = UIImage(named: tuples.2 + "unselected")?.withRenderingMode(.alwaysOriginal)
        navVc.tabBarItem.selectedImage = UIImage(named: tuples.2 + "selected")?.withRenderingMode(.alwaysOriginal)
        //230 108 77
        navVc.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.xm.dynamicRGB((160, 160, 160), (120, 120, 120)), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
        navVc.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.xm.dynamicRGB((236, 97, 62), (236, 97, 62)), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .selected)
        
        return navVc
        
    }
    
    private func setupConfog() {
        tabBar.backgroundColor = UIColor.xm.xm_255_30_color
        tabBar.tintColor = UIColor.xm.dynamicRGB((236, 97, 62), (236, 97, 62))
    }
    
    
    private func getImageViews() {
        if let items = tabBar.items {
                   for item in items {
                       if let subView = item.value(forKey: "view") as? UIView {
                           for imageView in subView.subviews {
                               if imageView.isKind(of: UIImageView.self) {
                                   itemImageViews.append(imageView as! UIImageView)
                                   break
                               }
                           }
                       }
                   }
               }
    }
    
}
