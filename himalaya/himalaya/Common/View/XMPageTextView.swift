//
//  XMPageTextView.swift
//  himalaya
//
//  Created by Farben on 2020/8/20.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


protocol XMPageTextViewDelegate: NSObjectProtocol {
    func scollerTextView(textView: XMPageTextView, index: Int)
}
class XMPageTextView: UIView {

    weak var delegate: XMPageTextViewDelegate?
    private var labelScroller: UILabel?
    private var labelSecondScroller: UILabel?
    
    private var width: CGFloat = 0
    private var height: CGFloat = 0
    
    private var timeInterval: TimeInterval = 4
    private var scrollTimeInterval: TimeInterval = 0.3
    
    private var obserVable: Observable<Int>?
    private var disposable: Disposable?
    
    var curentIndex: Int = 0
    private var nextIndex: Int = 1
    
    private var showLabel: UILabel?
    private var hiddenLabel: UILabel?
    
    var titles: [String]? {
        didSet{
            cancelTimer()
            if let texts = titles, texts.count > 0 {
                curentIndex = 0
                nextIndex = 1
                showLabel?.text = texts[curentIndex]
                if texts.count > 1 {
                    hiddenLabel?.text = texts[nextIndex]
                    startTimer()
                }
                
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        width = frame.size.width
        height = frame.size.height
        initWithSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XMPageTextView {
    
    private func initWithSubviews() {
        clipsToBounds = true
        labelScroller = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: height))
        labelScroller?.textColor = UIColor.xm.dynamicRGB((129, 129, 129), (140, 140, 140))
        labelScroller?.font = UIFont.systemFont(ofSize: 12)
        addSubview(labelScroller!)
        
        labelSecondScroller = UILabel(frame: CGRect(x: 0, y: height, width: width, height: height))
        labelSecondScroller?.textColor = UIColor.xm.dynamicRGB((129, 129, 129), (140, 140, 140))
               labelSecondScroller?.font = UIFont.systemFont(ofSize: 12)
        addSubview(labelSecondScroller!)
        
        showLabel = labelScroller
        hiddenLabel = labelSecondScroller
        
        showLabel?.alpha = 1
        hiddenLabel?.alpha = 0.1
    }
    
    
    
    private func startTimer() {
        if obserVable == nil {
            obserVable = Observable<Int>.timer(DispatchTimeInterval.seconds(4), period: DispatchTimeInterval.seconds(4), scheduler: MainScheduler.instance)
            disposable = obserVable!.subscribe(onNext: {[weak self] (event) in
                self?.animationLabel()
            })
        }
    }
    
    func cancelTimer() {
        if disposable != nil {
            disposable?.dispose()
        }
        if obserVable != nil {
            obserVable = nil
        }
    }
    
    
   
    private func animationLabel() {
        
        curentIndex = nextIndex
        nextIndex += 1
        if nextIndex > titles!.count - 1 {
            nextIndex = 0
        }
        UIView.animate(withDuration: scrollTimeInterval, animations: {
            self.showLabel?.alpha = 0.1
            self.hiddenLabel?.alpha = 1
            self.showLabel?.frame = CGRect(x: 0, y: -self.height, width: self.width, height: self.height)
            self.hiddenLabel?.frame = CGRect(x: 0, y: 0, width: self.width, height: self.height)
        }) { (finish) in
            if self.delegate != nil {
                self.delegate?.scollerTextView(textView: self, index: self.curentIndex)
            }
            let tempLabel = self.showLabel
            self.showLabel = self.hiddenLabel
            self.hiddenLabel = tempLabel
            self.showLabel?.alpha = 1
            self.hiddenLabel?.alpha = 0.1
            self.hiddenLabel?.frame = CGRect(x: 0, y: self.height, width: self.width, height: self.height)
            self.showLabel?.text = self.titles![self.curentIndex]
            self.hiddenLabel?.text = self.titles![self.nextIndex]
        }
    }
}
