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
    @IBOutlet weak var bottomLine: UIView!
    

    var baseGames : BaseGameModel? {
        didSet{
            titleLabel.text = baseGames?.tag_name
            
            if let imageUrl = URL(string: baseGames?.icon_url ?? "") {
                iconImageView.kf.setImage(with: imageUrl)
            }else{
                iconImageView.image = UIImage(named: "home_more_btn")
            }
         }
    }
}
