//
//  CycleCollectionCell.swift
//  DouYu
//
//  Created by 田全军 on 17/1/17.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit
import Kingfisher

class CycleCollectionCell: UICollectionViewCell {

    // MARK: 属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

    // MARK: 模型属性
    var cycleModel: CycleModel?{
        didSet{
            titleLabel.text = cycleModel?.title
            let url = NSURL(string: cycleModel?.pic_url ?? "")!
            iconImageView.kf_setImageWithURL(url)
        }
    }
}
