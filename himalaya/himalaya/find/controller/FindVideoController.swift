//
//  FindVideoController.swift
//  himalaya
//
//  Created by Farben on 2020/8/4.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class FindVideoController: XMBaseViewController {

   
    lazy var viewModel = ShortVideoViewModel(collectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func initWithSubviews() {
        super.initWithSubviews()
        view.addSubview(collectionView)
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = CHTCollectionViewWaterfallLayout()
        layout.minimumColumnSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 10)
        let collectionViewVideo = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionViewVideo.backgroundColor = UIColor.xm.xm_230_20_color
        collectionViewVideo.register(XMShortVideoCell.self, forCellWithReuseIdentifier: XMShortVideoCell.XMShortVideoCell_identify)
        collectionViewVideo.dataSource = self
        collectionViewVideo.delegate = self
        collectionViewVideo.jk_headerRefreshBlock = { [weak self] in
            self?.viewModel.requestVideo.onNext(true)
        }
        collectionViewVideo.jk_footerRefreshBlock = { [weak self] in
            self?.viewModel.requestVideo.onNext(false)
        }
        return collectionViewVideo
    }()
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

}

extension FindVideoController: UICollectionViewDelegate, UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.layouts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XMShortVideoCell.XMShortVideoCell_identify, for: indexPath) as! XMShortVideoCell
        cell.layout = viewModel.layouts[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return viewModel.layouts[indexPath.row].cellSize
    }
    
}

extension FindVideoController: PageEventHandleable {
    
    func contentViewFirstShow() {
         viewModel.requestVideo.onNext(true)
    }
}
