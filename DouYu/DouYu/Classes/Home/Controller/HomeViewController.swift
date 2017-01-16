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
    private lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRectMake(0, kStatusBarH + kNavigationH, kScreenWidth, kPageTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    //collectionView
    private lazy var contentView: PageContentView = {[weak self] in
        // 1.确定内容的frame
        let contentH = kScreenHeight - kStatusBarH - kNavigationH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationH + kTitleViewH, width: kScreenWidth, height: contentH)
        
        //添加子控制器
        var childVCs = [UIViewController]()
        childVCs.append(RecommendViewController())
        childVCs.append(GameViewController())
        childVCs.append(RecommendViewController())
        childVCs.append(GameViewController())

        let contentView = PageContentView(frame: contentFrame, childVcs: childVCs, parentViewController: self)
        contentView.delegate = self
        return contentView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置界面
        onFinishView()
        view.addSubview(contentView)
        
    }

    
}

// MARK: 设置UI界面
extension HomeViewController{
    
    private func onFinishView(){
        
        automaticallyAdjustsScrollViewInsets = false
        //创建导航栏
        setupNavigationBar()
        
        view.addSubview(pageTitleView)
        view.addSubview(contentView)
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

// MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}


// MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
