//
//  BaseTableViewCell.swift
//  gokarting
//
//  Created by Farben on 2020/7/22.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initWithSubViews()
        
        initWithSubviewsLayout()
    }
    
    func initWithSubViews() {
        selectionStyle = .none
    }
    
    func initWithSubviewsLayout() {
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var mainView: UIView = {
        let main_view = UIView()
        return main_view
    }()
}
