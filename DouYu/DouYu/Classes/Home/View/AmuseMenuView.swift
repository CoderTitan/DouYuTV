//
//  AmuseMenuView.swift
//  DouYu
//
//  Created by 田全军 on 17/1/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {

    // MARK: 定义属性
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: 从Xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "AmuseMenuCollectionCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }

}

// MARK: 类方法加载
extension AmuseMenuView{
    class func amuseMenuView() -> AmuseMenuView{
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

// MARK: UICollectionViewDataSource
extension AmuseMenuView: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if groups == nil { return 0 }
        let pageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuCollectionCell
        
        // 2.给cell设置数据
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        return cell
    }
    private func setupCellDataWithCell(cell : AmuseMenuCollectionCell, indexPath : IndexPath) {
        // 0页: 0 ~ 7
        // 1页: 8 ~ 15
        // 2也: 16 ~ 23
        // 1.取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        // 2.判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        // 3.取出数据,并且赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
    }
}
