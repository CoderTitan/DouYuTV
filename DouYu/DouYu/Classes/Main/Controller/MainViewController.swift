//
//  MainViewController.swift
//  DouYu
//
//  Created by 田全军 on 17/1/11.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers("Home")
        addChildViewControllers("Live")
        addChildViewControllers("Follow")
        addChildViewControllers("Profile")

    
    }

    private func addChildViewControllers(vcName: String) {
        //通过sto获取控制器
        let viewController = UIStoryboard(name: vcName, bundle: nil).instantiateInitialViewController()!
        
        //将viewController作为子控制器
        addChildViewController(viewController)
    }

}
