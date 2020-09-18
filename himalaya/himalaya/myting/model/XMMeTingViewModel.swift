//
//  XMMeTingViewModel.swift
//  himalaya
//
//  Created by Farben on 2020/9/18.
//  Copyright © 2020 Farben. All rights reserved.
//

import Foundation

class XMMeTingViewModel {
    
    
    lazy var layouts = [XMItingLayout]()
    init() {
        if let path = Bundle.main.path(forResource: "voice0", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let jsonString = String(data: data, encoding: String.Encoding.utf8), let resultModel = XMItingTitleResponse<XMMeTingTitleModel>(JSONString: jsonString) {
            if resultModel.ret == 0 {
                if let models = resultModel.resultModels, models.count > 0 {
                    let layout = XMItingLayout(titleModels: models)
                    self.layouts.append(layout)
                    
                }
            }
        }
        
        if let path = Bundle.main.path(forResource: "voice2", ofType: "json"),
           let data = try? Data(contentsOf: URL(fileURLWithPath: path)),
           let jsonString = String(data: data, encoding: String.Encoding.utf8), let resultModel = XMItingTitleResponse<XMItingDataModel>(JSONString: jsonString) {
            if resultModel.ret == 0 {
                if let model = resultModel.resultModel {
                    self.layouts.first?.resultModel = model
                }
            }
        }
    }
}
