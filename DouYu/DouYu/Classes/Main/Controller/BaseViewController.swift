//
//  BaseViewController.swift
//  DouYu
//
//  Created by 田全军 on 17/1/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    // MARK: 定义属性
    var contentView : UIView?

    //懒加载
    fileprivate lazy var animImageView: UIImageView = {[unowned self] in
       let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")!]
        imageView.animationDuration = 0.5
        //动画持续次数
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

      onfinishInfalse()
    }
    
}
// MARK: 初始化界面
extension BaseViewController{
    func onfinishInfalse(){
        // 1.隐藏内容的View
        contentView?.isHidden = true
        
        // 2.添加执行动画的UIImageView
        view.addSubview(animImageView)
        
        // 3.给animImageView执行动画
        animImageView.startAnimating()
        
        // 4.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    func loadDataFinished() {
        //1.停止动画
        animImageView.stopAnimating()
        //2.隐藏imageView
        animImageView.isHidden = true
        //3.显示contentView
        contentView?.isHidden = false
    }
}
