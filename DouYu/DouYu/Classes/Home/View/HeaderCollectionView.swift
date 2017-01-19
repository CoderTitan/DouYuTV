//
//  HeaderCollectionView.swift
//  DouYu
//
//  Created by 田全军 on 17/1/15.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class HeaderCollectionView: UICollectionReusableView {

    // MARK: xib属性
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    // MARK: 属性赋值
    var group : AnchorGroup?{
        didSet{
            titleLabel.text = group?.tag_name
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
}

// MARK: xib创建
extension HeaderCollectionView{
    class func headerCollectionView() -> HeaderCollectionView{
        return Bundle.main.loadNibNamed("HeaderCollectionView", owner: nil, options: nil)?.first as! HeaderCollectionView
    }
}
