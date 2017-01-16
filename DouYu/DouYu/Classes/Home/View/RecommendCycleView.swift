//
//  RecommendCycleView.swift
//  DouYu
//
//  Created by 田全军 on 17/1/17.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kCycleCellID = "kCycleCellID"

class RecommendCycleView: UIView {
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK:懒加载属性
    var cycleModelArr: [CycleModel]? {
        didSet{
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = cycleModelArr?.count ?? 0
            
            
        }
    }
    // MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = .None
        // 注册Cell
        collectionView.dataSource = self
        collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: kCycleCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let flowout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowout.itemSize = collectionView.bounds.size
    }
    
}

// MARK:- 提供一个快速创建View的类方法
extension RecommendCycleView{
    class func recommendCycleView() -> RecommendCycleView{
        return NSBundle.mainBundle().loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK: 
extension RecommendCycleView: UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cycleModelArr?.count ?? 0
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCycleCellID, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}
