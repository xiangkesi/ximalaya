//
//  XMSleepDecomController.swift
//  himalaya
//
//  Created by Farben on 2020/8/20.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift

class XMSleepPageDecomController: XMBaseViewController {

    
    let viewModel = XMSleepViewModel()
    var pageViewManager: PageViewManager?
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.titlesResult.subscribe(onNext: {[weak self] (success) in
            self?.creatUI()
        }).disposed(by: viewModel.disposeBag)
        viewModel.titleRequest.onNext(true)
    }
    
    
    override func initWithSubviews() {
        super.initWithSubviews()
                
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btnClose)
       
    }
    
    private lazy var btnClose: UIButton = {
        let btn_close = UIButton(type: UIButton.ButtonType.custom)
        btn_close.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        btn_close.setImage(UIImage(named: "common_close"), for: UIControl.State.normal)
        btn_close.rx.tap.subscribe(onNext: { [weak self] in
            ConfigKingfisher.removeMemoryCache()
//            self?.navigationController?.dismiss(animated: true, completion: nil)
            self?.navigationController?.dismiss(animated: true, completion: {
                
            })
        }).disposed(by: disposeBag)
        return btn_close
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        pageViewManager?.titleView.frame = CGRect(x: 0, y: 0, width: view.xm_width, height: 44)
        pageViewManager?.contentView.frame = view.bounds
    }
}

extension XMSleepPageDecomController {
    
    private func creatUI() {
        let style = PageStyle()
        style.isShowBottomLine = true
        style.isTitleViewScrollEnabled = true
        style.titleViewBackgroundColor = UIColor.clear
        style.titleColor = UIColor.colorWithrgba(200, 200, 200)
        style.titleSelectedColor = UIColor.colorWithrgba(255, 255, 255)
        style.titleFont = UIFont.boldSystemFont(ofSize: 16)
        style.titleSelectedFont = UIFont.boldSystemFont(ofSize: 16)
        style.bottomLineColor = UIColor.colorWithrgba(230, 230, 230)
        style.bottomLineWidth = 26
        style.bottomLineHeight = 2
        style.titleInset = 20
        style.isTitleScaleEnabled = true
        style.titleMaximumScaleFactor = 1.6
        var titleItems = [PageTitleItem]()
        var vcs = [UIViewController]()
        for model in viewModel.titleModels {
            let item = PageTitleItem()
            item.title = model.title ?? ""
            switch model.sceneId {
            case 4:
                item.controllerSTring = "XMSleepHomeController"
            case 6:
                item.controllerSTring = "XMSleepHelpController"
            case 5:
                item.controllerSTring = "XMSleepVipController"
            case 2:
                item.controllerSTring = "XMSleepMeditationController"
            case 3:
                item.controllerSTring = "XMSleepUnpackController"
            case 1:
                item.controllerSTring = "XMSleepFocueController"
            default:
                continue
            }
            if let controller = creatVc(controllerString: item.controllerSTring!, titleModel: model) {
                titleItems.append(item)
                addChild(controller)
                 vcs.append(controller)
            }
        }
        pageViewManager = PageViewManager(style: style, titleItems: titleItems, childViewControllers: vcs)
        navigationItem.titleView = pageViewManager?.titleView
        let contentView = pageViewManager?.contentView
        view.addSubview(contentView!)
        if #available(iOS 11, *) {
            contentView!.collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    
    private func creatVc(controllerString: String, titleModel: XMSleepTitleModel) -> UIViewController? {
        var cls: UIViewController.Type?
        if (NSClassFromString(Bundle.nameSpace + "." + controllerString) as? UIViewController.Type) != nil{
            cls = NSClassFromString(Bundle.nameSpace + "." + controllerString) as? UIViewController.Type
            let vc = cls!.init()
            if vc.isKind(of: XMSleepBaseViewController.self) {
                let controller = vc as! XMSleepBaseViewController
                controller.titleModel = titleModel
            }
            return vc
        }
        return nil
    }
}
