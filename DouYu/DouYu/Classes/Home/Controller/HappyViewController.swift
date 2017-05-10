//
//  HappyViewController.swift
//  DouYu
//
//  Created by 田全军 on 17/1/14.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8

class HappyViewController: BaseAnchorController {

    // MARK: 懒加载ViewModel对象
    fileprivate lazy var happyVM : HappyViewModel = HappyViewModel()

}

extension HappyViewController{
    override func onfinishInfalse() {
        super.onfinishInfalse()
        
        let flower = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flower.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsetsMake(kTopMargin, 0, kTopMargin, 0)
    }
}

extension HappyViewController{
    override func loadRequestData() {
        baseVM = happyVM
        happyVM.loadFunnyData { 
            self.collectionView.reloadData()
            self.loadDataFinished()
        }
    }
}
