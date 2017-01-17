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
    var group: [AnchorGroup]?{
        didSet{
            group?.removeFirst()
            group?.removeFirst()
            //添加更多组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            group?.append(moreGroup)
            //刷新
            collectionGameView.reloadData()
        }
    }
    // MARK: 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        autoresizingMask = .None
        collectionGameView.dataSource = self
        collectionGameView.registerNib(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        collectionGameView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargin, 0, kEdgeInsetMargin)
    }
    
}

// MARK: 类方法加载xib
extension RecommendGameView{
    class func recommendGameView() -> RecommendGameView{
        return NSBundle.mainBundle().loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

// MARK: 
extension RecommendGameView: UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return group?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kGameCellID, forIndexPath: indexPath) as! GameCollectionCell
        cell.groupModel = group![indexPath.item]
        return cell
    }
}
