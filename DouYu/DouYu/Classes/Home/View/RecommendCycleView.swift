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
    var timer: NSTimer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK:懒加载属性
    var cycleModelArr: [CycleModel]? {
        didSet{
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = cycleModelArr?.count ?? 0
            //默认滚到中间的位置
            let indexPath = NSIndexPath(forItem: (cycleModelArr?.count ?? 0) * 10, inSection: 0)
            collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition: .Left, animated: false)
            removeCycleTimer()
            addCycleTimer()
        }
    }
    // MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = .None
        // 注册Cell
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(UINib(nibName: "CycleCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
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
extension RecommendCycleView: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModelArr?.count ?? 0) * 10000
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kCycleCellID, forIndexPath: indexPath) as! CycleCollectionCell
        cell.cycleModel = cycleModelArr![indexPath.item % cycleModelArr!.count]
        return cell
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(contentX / scrollView.bounds.width) % (cycleModelArr?.count ?? 1)
    }
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK: 定时器的操作方法
extension RecommendCycleView{
    private func addCycleTimer(){
        //repeats是否需要重复
        timer = NSTimer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        //加到运行循环里面
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode:NSRunLoopCommonModes)
        
    }
    private func removeCycleTimer(){
        timer?.invalidate()//从运行循环中移除
        timer = nil
    }
    @objc private func scrollToNext(){
        // 1.获取滚动的偏移量
        let currentC = collectionView.contentOffset.x + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: currentC, y: 0), animated: true)
    }
}
