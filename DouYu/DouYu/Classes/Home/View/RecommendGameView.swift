//
//  RecommendGameView.swift
//  DouYu
//
//  Created by 田全军 on 17/1/17.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"
private let kEdgeInsetMargin : CGFloat = 10

class RecommendGameView: UIView {

    // MARK: 属性
    @IBOutlet weak var collectionGameView: UICollectionView!
    
    // MARK: 定义数据的属性
    var group: [BaseGameModel]?{
        didSet{
            
            //刷新
            collectionGameView.reloadData()
        }
    }
    // MARK: 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = UIViewAutoresizing()
        collectionGameView.dataSource = self
        collectionGameView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionGameView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargin, 0, kEdgeInsetMargin)
    }
    
}

// MARK: 类方法加载xib
extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

// MARK: 
extension RecommendGameView: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! GameCollectionCell
        cell.bottomLine.isHidden = true
        cell.baseGames = group![(indexPath as NSIndexPath).item]
        return cell
    }
}
