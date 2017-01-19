//
//  FunyViewController.swift
//  DouYu
//
//  Created by 田全军 on 17/1/14.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200

class FunyViewController: BaseAnchorController {
// MARK: 定义属性
    
    // MARK: 懒加载
    fileprivate lazy var amuseVM : AmuseViewModel = AmuseViewModel()
    fileprivate lazy var amuseMenuView : AmuseMenuView = {
       let amuse = AmuseMenuView.amuseMenuView()
        amuse.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenWidth, height: kMenuViewH)
        return amuse
    }()
    
}

// MARK: 设置界面
extension FunyViewController{
    override func onfinishInfalse() {
        super.onfinishInfalse()
        //添加头视图
        collectionView.addSubview(amuseMenuView)
        collectionView.contentInset = UIEdgeInsetsMake(kMenuViewH, 0, 0, 0)
    }
}
// MARK: 请求数据
extension FunyViewController{
    override func loadRequestData() {
        //给父类中的VIewModel赋值
        baseVM = amuseVM
        //请求数据
        amuseVM.loadAmuseData {
            //刷新
            self.collectionView.reloadData()
            //调整数据
            var tempGroups = self.amuseVM.anchorGroups
            tempGroups.removeFirst()
            self.amuseMenuView.groups = tempGroups
            //完成回调
//            self.loadRequestData()
        }
    }
}
