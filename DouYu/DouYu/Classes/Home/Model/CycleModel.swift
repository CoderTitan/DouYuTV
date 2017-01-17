//
//  CycleModel.swift
//  DouYu
//
//  Created by 田全军 on 17/1/17.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class CycleModel: NSObject {
    // 标题
    var title : String = ""
    // 展示的图片地址
    var pic_url : String = ""
    
    // 主播信息对应的模型对象
    var anchor : AnchorModel?
    // 主播信息对应的字典
    var room: [String : NSObject]?{
        didSet{
            guard let room = room else {
                return
            }
            anchor = AnchorModel(dict: room)
        }
    }
    
    // MARK: 定义构造函数
    init(dict: [String : NSObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
}
