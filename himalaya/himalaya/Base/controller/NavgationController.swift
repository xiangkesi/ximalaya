//
//  ZSNavgationController.swift
//  gokarting
//
//  Created by Farben on 2020/7/17.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class NavgationController: UINavigationController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.interactivePopGestureRecognizer?.delegate = self
        
        self.delegate = self
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .default
        
        edgesForExtendedLayout = .all
        
        var fontType: UIFont = UIFont.systemFont(ofSize: 17)
        if let fontRight = UIFont.init(name: "PingFangSC-Medium", size: 17){
            fontType = fontRight
        }
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: fontType, NSAttributedString.Key.foregroundColor: UIColor.xm.dynamicRGB((30, 30, 30), (255, 255, 255))]
        navigationBar.isTranslucent = false
        navigationBar.shadowImage = UIImage()
        navigationBar.barTintColor = UIColor.xm.xm_230_20_color
        
//        let lineBottom = CALayer()
//        lineBottom.xm_size = CGSize(width: view.xm_width, height: 1)
//        lineBottom.backgroundColor = UIColor.colorWidthHexString(hex: "F2F2F2").cgColor
//        lineBottom.xm_origin = CGPoint(x: 0, y: navigationBar.xm_height - 1)
//        navigationBar.layer.addSublayer(lineBottom)
        
        
        
        // 获取系统的Pop手势
//        guard let systemGes = interactivePopGestureRecognizer else { return }
//        guard let gesView = systemGes.view else { return }
//        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
//        guard let targetObjc = targets?.first else { return }
//        guard let target = targetObjc.value(forKey: "target") else { return }
//        let action = Selector(("handleNavigationTransition:"))
//        let panGes = UIPanGestureRecognizer()
//        gesView.addGestureRecognizer(panGes)
//        panGes.addTarget(target, action: action)
        
        
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if viewControllers.count <= 1 {
            return false
        }
        return true
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if children.count > 0 {
            let btnBack = UIButton(type: .custom)
            
            btnBack.setImage(UIImage(named: "XMEmoticon_xmb_back_h"), for: .normal)
            btnBack.setImage(UIImage(named: "XMEmoticon_xmb_back_h"), for: .selected)
            
            btnBack.bounds.size = CGSize(width: 50, height: 30)
            btnBack.contentHorizontalAlignment = .left
            btnBack.imageView?.isUserInteractionEnabled = false
            btnBack.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            btnBack.addTarget(self, action: #selector(backPop), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btnBack)
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func backPop() {
        popViewController(animated: true)
    }
}

protocol HideNavigationBarProtocol where Self: UIViewController {}
extension NavgationController: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//
//    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is HideNavigationBarProtocol {
            self.setNavigationBarHidden(true, animated: true)
        }else {
            setNavigationBarHidden(false, animated: true)
        }
        
    }
    
//
//    /*
//
//            分析：一般用手势触发某个行为需要哪些条件 ？
//
//            1、需要创建一个我们需要的手势实例；
//            2、添加到一个View上（需要一个view）；
//            3、需要一个Target；
//            4、需要一个Action。
//
//            let tapG = UITapGestureRecognizer()
//            view.addGestureRecognizer(tapG)
//            tapG.addTarget(<#T##target: Any##Any#>, action: <#T##Selector#>)
//
//            我们需要改成全屏触发，其实Target和Action 是不需要改的，那我们就先拿到 Target和Action。
//            再拿到手势和添加手势的View，尝试的去改手势和添加手势的View 。
//
//            总结： 从iOS 7.0 系统就帮我添加了手势返回，但是只支持左边缘触发，现在我们需要改成全屏触发，只要把系统的手势更换为UIPanGestureRecognizer.
//
//            */
//
//
//           // 获取系统的Pop手势
//           guard let systemGes = interactivePopGestureRecognizer else { return }
//
//           print(systemGes)
//           // 获取系统手势添加的view
//           guard let gesView = systemGes.view else { return }
//
//           // 获取Target和Action，但是系统并没有暴露相关属性
//           //利用 class_copyIvarList 查看所有的属性 (发现_targets 是一个数组)
//           print("------------------------属性---------------------------------")
//           var ivarCount : UInt32 = 0
//           let ivars = class_copyIvarList(UIGestureRecognizer.self, &ivarCount)!
//           for i in 0..<ivarCount {
//               let ivar = ivars[Int(i)]
//               let name = ivar_getName(ivar)
//               print(String(cString: name!))
//           }
//           print("------------------------方法---------------------------------")
//           //利用 class_copyMethodList 查看所有的方法（并没有找到我们想要的方法）
//           var methodCount : UInt32 = 0
//           let methods = class_copyMethodList(UIGestureRecognizer.self, &methodCount)!
//
//           for i in 0 ..< methodCount {
//               let method = methods[Int(i)]
//               let name = method_getName(method)
//               print("\(name)")
//           }
//           //从Targets 取出 Target
//           let targets = systemGes.value(forKey: "_targets") as? [NSObject]
//           guard let targetObjc = targets?.first else { return }
//           guard let target = targetObjc.value(forKey: "target") else { return }
//           //方法名称获取 Action
//           let action = Selector(("handleNavigationTransition:"))
//
//
//           let panGes = UIPanGestureRecognizer()
//           gesView.addGestureRecognizer(panGes)
//           panGes.addTarget(target, action: action)
           
}
