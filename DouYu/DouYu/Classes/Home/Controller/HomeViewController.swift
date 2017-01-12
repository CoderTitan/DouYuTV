//
//  HomeViewController.swift
//  DouYu
//
//  Created by 田全军 on 17/1/11.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kPageTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    
    // MARK: 懒加载属性
    private lazy var pageTitleView : PageTitleView = {
        let titleFrame = CGRectMake(0, kStatusBarH + kNavigationH, kScreenWidth, kPageTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)

        return titleView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置界面
        onFinishView()

        
    }

    
}

// MARK: 设置UI界面
extension HomeViewController{
    
    private func onFinishView(){
        
        automaticallyAdjustsScrollViewInsets = false
        //创建导航栏
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
    }
    
    //创建导航栏
    
    private func setupNavigationBar(){
        //左侧
        navigationItem.leftBarButtonItem = UIBarButtonItem(norImage: "logo")
        
        //右侧
        let itemSize = CGSizeMake(45, 45)
        
        let historyItem = UIBarButtonItem(norImage: "image_my_history", selectImage: "Image_my_history_click", itemSize: itemSize)
        let searchItem = UIBarButtonItem(norImage: "btn_search", selectImage: "btn_search_clicked", itemSize: itemSize)
        let qrcodeItem = UIBarButtonItem(norImage: "Image_scan", selectImage: "Image_scan_click", itemSize: itemSize)

        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem]
        
    }
    
}