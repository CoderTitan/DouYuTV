//
//  AnchorGroup.swift
//  DouYu
//
//  Created by 田全军 on 17/1/15.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class AnchorGroup :BaseGameModel{
    
    // MARK: 定义属性
    /// 组显示的图标
    var icon_name : String = "home_header_normal"
    /// 定义主播的模型对象数组
    lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    /// 该组中对应的房间信息
    var room_list: [[String: NSObject]]? {
        didSet{//属性监听器,监听属性的改变
            guard let room_list = room_list else {return}
            for dic in room_list{
                anchors.append(AnchorModel.init(dict: dic))
            }
        }
    }

}
