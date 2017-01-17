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
    var timer: Timer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!

    // MARK:懒加载属性
    var cycleModelArr: [CycleModel]? {
        didSet{
            self.collectionView.reloadData()
            self.pageControl.numberOfPages = cycleModelArr?.count ?? 0
            //默认滚到中间的位置
            let indexPath = IndexPath(item: (cycleModelArr?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
            removeCycleTimer()
            addCycleTimer()
        }
    }
    // MARK: 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        // 设置该控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        // 注册Cell
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CycleCollectionCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
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
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
}

// MARK: 
extension RecommendCycleView: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (cycleModelArr?.count ?? 0) * 10000
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CycleCollectionCell
        cell.cycleModel = cycleModelArr![(indexPath as NSIndexPath).item % cycleModelArr!.count]
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        pageControl.currentPage = Int(contentX / scrollView.bounds.width) % (cycleModelArr?.count ?? 1)
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

// MARK: 定时器的操作方法
extension RecommendCycleView{
    fileprivate func addCycleTimer(){
        //repeats是否需要重复
        timer = Timer(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        //加到运行循环里面
        RunLoop.main.add(timer!, forMode:RunLoopMode.commonModes)
        
    }
    fileprivate func removeCycleTimer(){
        timer?.invalidate()//从运行循环中移除
        timer = nil
    }
    @objc fileprivate func scrollToNext(){
        // 1.获取滚动的偏移量
        let currentC = collectionView.contentOffset.x + collectionView.bounds.width
        collectionView.setContentOffset(CGPoint(x: currentC, y: 0), animated: true)
    }
}
