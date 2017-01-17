//
//  GameCollectionCell.swift
//  DouYu
//
//  Created by 田全军 on 17/1/17.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class GameCollectionCell: UICollectionViewCell {

    // MARK: 属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    

    var groupModel : AnchorGroup? {
        didSet{
            titleLabel.text = groupModel?.tag_name
            let imageUrl = NSURL(string: groupModel?.icon_url ?? "")!
            iconImageView.kf_setImageWithURL(imageUrl, placeholderImage: UIImage(named: "home_more_btn"))
        }
    }
}
