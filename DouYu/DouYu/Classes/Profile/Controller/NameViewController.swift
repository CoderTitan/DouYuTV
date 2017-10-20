//
//  NameViewController.swift
//  DouYu
//
//  Created by iOS_Tian on 2017/10/18.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first ?? UITouch()
        //获取重按力度
        print("平均触摸的力--\(touch.force)")
        print("触摸的最大可能力--\(touch.maximumPossibleForce)")
        
        let change = touch.force / touch.maximumPossibleForce
        view.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: change, alpha: 1)
    }

}
