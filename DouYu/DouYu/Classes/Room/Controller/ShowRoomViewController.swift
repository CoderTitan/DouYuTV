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
    @IBOutlet weak var showLabel: UILabel!
    var showStr = ""
    
    // MARK: 自定义属性
//    fileprivate var ijkPlayer : IJKFFMoviePlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.cyan

        showLabel.text = showStr
    }

    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


//MARK: UIPreviewActionItem
extension ShowRoomViewController {
    //重写previewActionItems的get方法
    override var previewActionItems: [UIPreviewActionItem] {
        let action1 = UIPreviewAction(title: "跳转", style: .default) { (action, previewViewController) in
            let showVC = ShowRoomViewController()
            showVC.hidesBottomBarWhenPushed = true
            previewViewController.navigationController?.pushViewController(showVC, animated: true)
        }
        
        let action3 = UIPreviewAction(title: "取消", style: .destructive) { (action, previewViewController) in
            print("我是取消按钮")
        }
        
        ////该按钮可以是一个组，点击该组时，跳到组里面的按钮。
        let subAction1 = UIPreviewAction(title: "测试1", style: .default) { (action, previewViewController) in
            print("我是测试按钮1")
        }
        let subAction2 = UIPreviewAction(title: "测试2", style: .selected) { (action, previewViewController) in
            print("我是测试按钮2")
        }
        let subAction3 = UIPreviewAction(title: "测试3", style: .destructive) { (action, previewViewController) in
            print("我是测试按钮3")
        }
        let groupAction = UIPreviewActionGroup(title: "更多", style: .default, actions: [subAction1, subAction2, subAction3])
        
        return [action1, action3, groupAction]
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
