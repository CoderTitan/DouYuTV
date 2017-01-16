//
//  PageContentView.swift
//  DouYu
//
//  Created by 田全军 on 17/1/12.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

// MARK: 自定义协议
protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    
    // MARK: 自定义属性
    private var childVcs: [UIViewController]
    private weak var parentViewController: UIViewController?
    weak var delegate: PageContentViewDelegate?
    private var startOffsetX : CGFloat = 0
    private var isForbidScrollDelegate : Bool = false

    // MARK: 自定义懒加载属性
    private lazy var collectionView: UICollectionView = {[weak self] in
       let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = (self?.bounds.size)!
        //设置垂直最小间隙
        flowLayout.minimumLineSpacing = 0
        //设置水平最小间隙
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .Horizontal
        
        let collectionV = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
        collectionV.showsHorizontalScrollIndicator = false
        collectionV.pagingEnabled = true
        collectionV.bounces = false
        collectionV.scrollsToTop = false
        collectionV.dataSource = self
        collectionV.delegate = self
        collectionV.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collectionV
    }()

    // MARK: 自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentViewController : UIViewController?) {
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        super.init(frame: frame)
        
        onFinishInfalce()
    }
    //自定义构造函数必须重写该方法
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

// MARK: 初始化界面布局
extension PageContentView{
    //创建界面
    private func onFinishInfalce(){
        // 1.将所有的子控制器添加父控制器中
        for viewController in childVcs{
            parentViewController?.addChildViewController(viewController)
        }
        // 2.添加UICollectionView,用于在Cell中存放控制器的View
        addSubview(collectionView)
        collectionView.frame = bounds
    }
}

// MARK: UICollectionViewDataSource
extension PageContentView: UICollectionViewDataSource{
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCellWithReuseIdentifier(ContentCellID, forIndexPath: indexPath)
        //给cell设置内容
        for view in collectionCell.contentView.subviews{
            //先移除已经存在的,避免重复添加
            view.removeFromSuperview()
        }
        let childV = childVcs[indexPath.item]
        childV.view.frame = collectionCell.contentView.bounds
        collectionCell.contentView.addSubview(childV.view)
        return collectionCell
    }
}

// MARK:- 遵守UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        
        // 1.定义获取需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        
        // 3.将progress/sourceIndex/targetIndex传递给titleView
        delegate?.pageContentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


// MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        
        // 1.记录需要进制执行代理方法
        isForbidScrollDelegate = true
        
        // 2.滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
