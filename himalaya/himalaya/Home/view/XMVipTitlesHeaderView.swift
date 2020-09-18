//
//  XMVipTitlesHeaderView.swift
//  himalaya
//
//  Created by Farben on 2020/8/21.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift


public class XMVipTitlesHeaderView: UICollectionReusableView {
            
    var scrollerView: UIScrollView?
    
    private var currentIndex: Int = 0
    
    private var lastLabel: UILabel?
    private var currentLabel: UILabel?
    
    private var linBottom: CALayer?
    
    private var isCreatedLabels: Bool = false
    
    private let disposeBag = DisposeBag()
    
    var clickLabel:((_ word: XMVipCategorieWordModel) -> ())?
    
    
    var categorieWords: [XMVipCategorieWordModel]? {
        didSet {
            if isCreatedLabels == true {return}//防止重复创建
            if let words = categorieWords, words.count > 0 {
                isCreatedLabels = true
                var finalLabel: UILabel?
//                var isClick: Bool = true
                for (index, word) in words.enumerated() {
                    let label = UILabel()
                    scrollerView?.addSubview(label)
                    label.isUserInteractionEnabled = true
                    label.xm_y = 0
                    label.xm_x = (finalLabel == nil) ? xm_padding : finalLabel!.xm_right + 20
                    label.xm_size = CGSize(width: word.titleWidth, height: xm_height)
                    label.attributedText = word.titleAttr
                    lastLabel = label
                    let tap = UITapGestureRecognizer()
                    label.addGestureRecognizer(tap)
                    tap.rx.event.subscribe(onNext: { (tap) in
//                        if isClick == false {
//                            return
//                        }
//                        isClick = false
                        if self.currentIndex == index {return}
                        self.currentIndex = index
                        let tempLabel = self.currentLabel
                        self.currentLabel = label
                        self.lastLabel = tempLabel
                        UIView.animate(withDuration: 0.25, animations: {
                            self.currentLabel!.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                            self.lastLabel?.transform = CGAffineTransform(scaleX: 1, y: 1)
                            self.linBottom?.xm_x = ceil(label.xm_x + (word.titleWidth - 30) * 0.5)
                        }) { (finish) in
                            self.refreshContenOffset()
//                            isClick = true
                        }
                         if self.clickLabel != nil {
                            self.clickLabel!(word)
                         }
                    }).disposed(by: disposeBag)
                    if index == 0 {
                        self.currentLabel = label
                        linBottom?.xm_x = ceil(label.xm_x + (word.titleWidth - 30) * 0.5)
                        self.currentLabel?.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                    }
                    finalLabel = label
                }
                scrollerView?.contentSize = CGSize(width: finalLabel!.xm_right, height: 0)
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.xm.xm_230_20_color
        scrollerView = UIScrollView()
        scrollerView?.showsHorizontalScrollIndicator = false
        addSubview(scrollerView!)
        
        linBottom = CALayer()
        linBottom?.xm_height = 4
        linBottom?.xm_width = 30
        linBottom?.xm_y = 46
        linBottom?.cornerRadius = 2
        linBottom?.backgroundColor = UIColor.colorWidthHexString(hex: mainColorString).cgColor
        scrollerView?.layer.addSublayer(linBottom!)
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        scrollerView?.frame = bounds
    }
    
    func refreshContenOffset() {
        let frame = self.currentLabel?.frame
        let itemX = frame?.origin.x
        let width = scrollerView?.frame.size.width
        let contentSize = scrollerView?.contentSize
        if itemX! > width! / 2 {
            var targetX: CGFloat = 0
            if (contentSize!.width - itemX!) <= width! / 2 {
                targetX = contentSize!.width - width!
            }else {
                targetX = frame!.origin.x - width! / 2 + frame!.size.width / 2
            }
            
            if targetX + width! > contentSize!.width {
                targetX = contentSize!.width - width!
            }
            scrollerView?.setContentOffset(CGPoint(x: targetX, y: 0), animated: true)
        }else {
            scrollerView?.setContentOffset(CGPoint.zero, animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
