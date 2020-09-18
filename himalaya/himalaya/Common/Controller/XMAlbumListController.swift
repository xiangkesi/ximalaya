//
//  XMAlbumListController.swift
//  himalaya
//
//  Created by Farben on 2020/8/26.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class XMAlbumListController: XMBaseViewController {

    private var scrollerView: UIScrollView?
    private var contentView: XMAlbumListContentView?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private var topView: UIView?
    
    private var orY: CGFloat = 0
    override func initWithSubviews() {
        super.initWithSubviews()
        scrollerView = UIScrollView()
        scrollerView?.backgroundColor = UIColor.purple
        scrollerView?.contentSize = CGSize(width: 0, height: view.xm_height * 2)
        scrollerView?.delegate = self
        scrollerView?.frame = view.bounds
        view.addSubview(scrollerView!)
        
        topView = UIView()
        topView?.frame = CGRect(x: 0, y: 0, width: view.xm_width, height: view.xm_height)
        topView?.backgroundColor = UIColor.brown
        scrollerView?.addSubview(topView!)
        let redView = UIView()
        redView.frame = CGRect(x: 0, y: topView!.xm_height - 20, width: view.xm_width, height: 20)
        redView.backgroundColor = UIColor.red
        topView?.addSubview(redView)
        
        
        
        contentView = XMAlbumListContentView()
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(action(sender:)))
        contentView?.addGestureRecognizer(pan)
        contentView?.xm_y = view.xm_height - (100 + xm_navgationheight)
        orY = contentView!.xm_y
        view.addSubview(contentView!)
    }
    
    @objc func action(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            let panGestureBeginPoint = sender.location(in: self.view)
            print(panGestureBeginPoint)
            break
        case .ended:
            break
        case .changed:
            break
        case .cancelled:
            break
        default:
            break
        }
    }
    private var isAddScroller: Bool = false
}

extension XMAlbumListController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offetY = scrollView.contentOffset.y
        
        if offetY > 189 && offetY < 898 {
            if isAddScroller == false {
                isAddScroller = true
                scrollView.addSubview(contentView!)
                contentView?.xm_y = topView!.xm_bottom
            }
        }else if offetY < 189{
            if isAddScroller == true {
                isAddScroller = false
                view.addSubview(contentView!)
                contentView?.xm_y = orY
            }
        }else if offetY > 898 {
            if isAddScroller == true {
                isAddScroller = false
                view.addSubview(contentView!)
                contentView?.xm_y = 0
            }
        }
        
    }
}
