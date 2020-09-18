//
//  PageOneController.swift
//  himalaya
//
//  Created by cocoazhang on 2020/8/30.
//  Copyright © 2020 Farben. All rights reserved.
//

import UIKit

class PageOneController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PageOneController: XMpageControllerLoadFunc {
    func lazyLoad() {
        print("第一次运行,也就运行一次")
    }
    
    func controllerDidShow() {
        print("停止滚动的时候调用了")
    }
    
    
}
