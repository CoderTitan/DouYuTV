//
//  ShowRoomViewController.swift
//  DouYu
//
//  Created by 田全军 on 17/2/5.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit
//import IJKMediaFramework

class ShowRoomViewController: UIViewController {

    // MARK: xib属性
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    // MARK: 自定义属性
//    fileprivate var ijkPlayer : IJKFFMoviePlayerController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: 加载房间信息
extension ShowRoomViewController{
    fileprivate func setupIjkPlayerView(){
        // 0.关闭log
//        IJKFFMoviePlayerController.setLogReport(false)
        // 1.初始化播放器


    }
}
