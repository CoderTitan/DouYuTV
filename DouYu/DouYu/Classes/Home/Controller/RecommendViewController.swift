//
//  RecommendViewController.swift
//  DouYu
//
//  Created by 田全军 on 17/1/14.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

//// MARK: 自定义常量
private let kCycleViewH = kScreenWidth * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorController {
    
    // MARK: 懒加载属性
    fileprivate lazy var recommendViewM: RecommendViewModel = RecommendViewModel()
    fileprivate lazy var cycleView: RecommendCycleView = {
       let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH) , width: kScreenWidth, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        return gameView
    }()

}
// MARK: 初始化界面
extension RecommendViewController{
    override func onfinishInfalse(){
        //1.调用super
        super.onfinishInfalse()
        // 2.将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        // 3.将gameView添加collectionView中
        collectionView.addSubview(gameView)
        
        // 4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    }
}

// MARK: 请求数据
extension RecommendViewController{
    override func loadRequestData() {
        //1.给父类属性赋值
        baseVM = recommendViewM
        //2.请求数据
        recommendViewM.requestData({
            //刷新数据
            self.collectionView.reloadData()
            //添加游戏数据
            var groups = self.recommendViewM.anchorGroups
            groups.removeFirst()
            groups.removeFirst()
            //添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.group = groups
            // 3.数据请求完成
            self.loadDataFinished()
            
        })
        //请求轮播图数据
        recommendViewM.requestCycleData { 
            self.cycleView.cycleModelArr = self.recommendViewM.cycleModels
        }
    }
}

// MARK: UICollectionViewDataSource
extension RecommendViewController:  UICollectionViewDelegateFlowLayout{
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath as NSIndexPath).section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
            cell.anchor = recommendViewM.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath as NSIndexPath).section == 1{
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
}
