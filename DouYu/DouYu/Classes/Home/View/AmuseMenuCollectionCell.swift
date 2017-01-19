//
//  AmuseMenuCollectionCell.swift
//  DouYu
//
//  Created by 田全军 on 17/1/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class AmuseMenuCollectionCell: UICollectionViewCell {

    // MARK: 数组模型
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }

    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: 从Xib中加载
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "GameCollectionCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}

// MARK: UICollectionViewDataSource
extension AmuseMenuCollectionCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.求出Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! GameCollectionCell
        
        // 2.给Cell设置数据
        cell.baseGames = groups![indexPath.item]
        cell.bottomLine.isHidden = true
        return cell
    }
}
