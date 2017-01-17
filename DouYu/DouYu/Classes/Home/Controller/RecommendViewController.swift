//
//  RecommendViewController.swift
//  DouYu
//
//  Created by 田全军 on 17/1/14.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

// MARK: 自定义常量
private let kItemMargin : CGFloat = 10
private let kItemW = (kScreenWidth - 3 * kItemMargin) / 2
private let kNormalItemH = kItemW * 3 / 4
private let kPrettyItemH = kItemW * 4 / 3
private let kHeaderViewH : CGFloat = 50

private let kNormalCellID = "kNormalCellID"
private let kPrettyCellID = "kPrettyCellID"
private let kHeaderViewID = "kHeaderViewID"

private let kCycleViewH = kScreenWidth * 3 / 8
private let kGameViewH : CGFloat = 90

class RecommendViewController: UIViewController {
    
    // MARK: 自定义属性
    
    // MARK: 懒加载属性
    fileprivate lazy var recommendCollection: UICollectionView = {[weak self] in
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
        //设置垂直最小间隙
        flowLayout.minimumLineSpacing = 0
        //设置水平最小间隙
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical
        flowLayout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)
        
        let collectionV = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: flowLayout)
        collectionV.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionV.backgroundColor = UIColor.white
        collectionV.scrollsToTop = false
        collectionV.dataSource = self
        collectionV.delegate = self
        
        collectionV.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionV.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionV.register(UINib(nibName: "HeaderCollectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        return collectionV
    }()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
      //初始化界面
        onfinishInfalse()
        
      //请求数据
        loadRequestData()
    }
    
}
// MARK: 初始化界面
extension RecommendViewController{
    fileprivate func onfinishInfalse(){
        // 1.将UICollectionView添加到控制器的View中
        view.addSubview(recommendCollection)
        
        // 2.将CycleView添加到UICollectionView中
        recommendCollection.addSubview(cycleView)
        
        // 3.将gameView添加collectionView中
        recommendCollection.addSubview(gameView)
        
        // 4.设置collectionView的内边距
        recommendCollection.contentInset = UIEdgeInsetsMake(kCycleViewH + kGameViewH, 0, 0, 0)
    }
}

// MARK: 请求数据
extension RecommendViewController{
    fileprivate func loadRequestData(){
        recommendViewM.requestData({ 
            // 1.展示推荐数据
            self.recommendCollection.reloadData()
            //添加游戏数据
            self.gameView.group = self.recommendViewM.anchorGroups
        })
        //请求轮播图数据
        recommendViewM.requestCycleData { 
            self.cycleView.cycleModelArr = self.recommendViewM.cycleModels
        }
    }
}

// MARK: UICollectionViewDataSource
extension RecommendViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendViewM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendViewM.anchorGroups[section]
        return group.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //取出模型对象
        let group = recommendViewM.anchorGroups[(indexPath as NSIndexPath).section]
        let anchor = group.anchors[(indexPath as NSIndexPath).item]
        
        var cell :BaseCollectionCell!
        if (indexPath as NSIndexPath).section == 1{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! CollectionPrettyCell
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
        }
        cell.anchor = anchor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! HeaderCollectionView
        header.group = recommendViewM.anchorGroups[(indexPath as NSIndexPath).section]
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath as NSIndexPath).section == 1{
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}
