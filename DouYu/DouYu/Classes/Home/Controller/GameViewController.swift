//
//  GameViewController.swift
//  DouYu
//
//  Created by 田全军 on 17/1/14.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kEdgeMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenWidth - 2 * kEdgeMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5
private let kHeaderViewH : CGFloat = 50
private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kHeaderViewID = "kHeaderViewID"

class GameViewController: UIViewController {

    // MARK: 自定义属性
    
    // MARK: 懒加载
    fileprivate lazy var gameViewModel : GameViewModel = GameViewModel()
    fileprivate lazy var collectionGameView: UICollectionView = {[unowned self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: kEdgeMargin, bottom: 0, right: kEdgeMargin)
        layout.headerReferenceSize = CGSize(width: kScreenWidth, height: kHeaderViewH)
        
        // 2.创建UICollectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionView.register(UINib(nibName: "HeaderCollectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        collectionView.dataSource = self
        
        return collectionView
    }()
    fileprivate lazy var topHeader: HeaderCollectionView = {
       let header = HeaderCollectionView.headerCollectionView()
        header.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenWidth, height: kHeaderViewH)
        header.titleLabel.text = "常用"
        header.iconImageView.image = UIImage(named: "Img_orange")
        return header
    }()
    fileprivate lazy var gameView: RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenWidth, height: kGameViewH)
        return gameView
    }()
    
    //// MARK: 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //创建界面
        onFinishInfalse()
       //加载数据
        loadRequestData()
        //设置内边距
        collectionGameView.contentInset = UIEdgeInsets(top: kHeaderViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

// MARK: 初始化界面
extension GameViewController{
    //初始化界面
    fileprivate func onFinishInfalse(){
        view.addSubview(collectionGameView)
        collectionGameView.addSubview(topHeader)
        collectionGameView.addSubview(gameView)
    }
}

// MARK: 加载数据
extension GameViewController{
    fileprivate func loadRequestData(){
        gameViewModel.loadAllGameData {
            //刷新界面
            self.collectionGameView.reloadData()
            //展示常见数据
            self.gameView.group = Array(self.gameViewModel.gameModels[0..<10])
        }
    }
}

// MARK: 代理
extension GameViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameViewModel.gameModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! GameCollectionCell
        cell.baseGames = gameViewModel.gameModels[indexPath.item]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! HeaderCollectionView
        header.titleLabel.text = "全部"
        header.iconImageView.image = UIImage(named: "Img_orange")
        return header
    }
}
