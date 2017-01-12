//
//  PageTitleView.swift
//  DouYu
//
//  Created by 田全军 on 17/1/12.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit


// MARK: 定义常量
private let kScrollLineH : CGFloat = 2


class PageTitleView: UIView {

    //MARK:定义属性
    var titles : [String]
    
    // MARK: 懒加载属性
    private lazy var titleLables : [UILabel] = [UILabel]()
    private lazy var titleScroll : UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false  //分页效果
        scrollView.scrollsToTop = false   //false后,点击可以回到顶部
        return scrollView
    }()
    private lazy var ScrollLine : UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orangeColor()
        return scrollLine
    }()
    
    // MARK: 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles
        
        super.init(frame: frame)
        
        //设置界面
        onFinishView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: 设置界面
extension PageTitleView{
    
    //设置界面
    private func onFinishView(){
        // 1.添加UIScrollView
        addSubview(titleScroll)
        titleScroll.frame = bounds
        
        // 2.添加title对应的Label
        setupTitleLables()
        
        // 3.设置底线和滚动的滑块
        setupBottomLineAndScrollLine()
    }
    
    //创建标题Lable
    private func setupTitleLables(){
        let lableW : CGFloat = frame.size.width / CGFloat(titles.count)
        let lableH : CGFloat = frame.size.height - kScrollLineH
        let lableY : CGFloat = 0
        
        for (index, title) in titles.enumerate(){
            let lable = UILabel()
            
            lable.text = title
            lable.textAlignment = .Center
            lable.tag = index
            lable.font = UIFont.systemFontOfSize(16)
            
            let lableX = lableW * CGFloat(index)
            lable.frame = CGRectMake(lableX, lableY, lableW, lableH)
            titleScroll.addSubview(lable)
            
            titleLables.append(lable)
        }
    }
    
    // 3.设置底线和滚动的滑块
    private func setupBottomLineAndScrollLine(){
        //1,添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGrayColor()
        let bottomLineH : CGFloat = 0.5
        bottomLine.frame = CGRectMake(0, frame.size.height - bottomLineH, frame.size.width, bottomLineH)
        addSubview(bottomLine)
        
        //2,添加滑块
        //2-1获得第一个lable的frame
        guard let firstLable = titleLables.first else {return}
        firstLable.textColor = UIColor.orangeColor()
        //2-2设置scrollLine的属性
        titleScroll.addSubview(ScrollLine)
        ScrollLine.frame = CGRectMake(firstLable.frame.origin.x, frame.size.height - kScrollLineH, firstLable.frame.size.width, kScrollLineH)
    }
}