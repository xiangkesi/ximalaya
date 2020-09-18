//
//  XMLiveCategoryView.swift
//  himalaya
//
//  Created by cocoazhang on 2020/8/29.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit
import IGListKit
import RxSwift



class XMLiveCategoryView: UIScrollView {
    
    let disposeBag = DisposeBag()
    let clickItemPublish = PublishSubject<XMLiveCategoryVoListModel>()
    
    
    private var currentModel: XMLiveCategoryVoListModel?
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 60)
        layout.minimumLineSpacing = 1
        layout.scrollDirection = .horizontal
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(XMLiveCategoryCell.self, forCellWithReuseIdentifier: "XMLiveCategoryCell_identify")
        view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
        view.dataSource = self
        view.delegate = self
        return view
    }()
        
    
    var lauout: XMLiveCategoryLayout? {
        didSet {
            if currentModel != nil {
                return
            }
            if let models = lauout?.categoryVoLists, models.count > 0 {
                currentModel = lauout?.categoryVoLists?.first
                collectionView.reloadData()
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(collectionView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XMLiveCategoryView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lauout?.categoryVoLists?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "XMLiveCategoryCell_identify", for: indexPath) as! XMLiveCategoryCell
        if let models = lauout?.categoryVoLists {
            let model = models[indexPath.row]
            cell.imageView.setImage(urlString: model.isSelected ? model.darkSecondIcon : model.darkFirstIcon, placeHolderName: nil)
            cell.labelTitle.text = model.name
            cell.isClickSelected = model.isSelected
            cell.lineView.isHidden = model.isHiddenLineRight
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let models = lauout?.categoryVoLists {
            let model = models[indexPath.row]
            if model.isSelected == true {
                return
            }
            model.isSelected = true
            currentModel?.isSelected = false
            currentModel = model
            collectionView.reloadData()
            clickItemPublish.onNext(currentModel!)
        }
    }
    
    
}

