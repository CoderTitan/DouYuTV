//
//  BaseGameModel.swift
//  DouYu
//
//  Created by 田全军 on 17/1/18.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {

    // MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""

    // MARK: 自定义构造函数
    override init() {
        
    }
    init(dic: [String: Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
}
