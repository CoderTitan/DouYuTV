//
//  NormalRoomController.swift
//  DouYu
//
//  Created by 田全军 on 17/1/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class NormalRoomController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.yellow
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    

}
