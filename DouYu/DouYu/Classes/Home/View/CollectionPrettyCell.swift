//
//  CollectionPrettyCell.swift
//  DouYu
//
//  Created by 田全军 on 17/1/15.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class CollectionPrettyCell: BaseCollectionCell {

    // MARK:- 控件属性
    @IBOutlet weak var cityBtn: UIButton!
    
    // MARK:- 定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            // 1.将属性传递给父类
            super.anchor = anchor
            
            // 2.所在的城市
            cityBtn.setTitle(anchor?.anchor_city, for: UIControlState())
        }
    }

}
