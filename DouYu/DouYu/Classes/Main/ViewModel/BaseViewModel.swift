//
//  BaseViewModel.swift
//  DouYu
//
//  Created by 田全军 on 17/1/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}
extension BaseViewModel {
    func loadAnchorData(isGroupData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters as! [String : NSString]? ) { (result) in
            // 1.对界面进行处理
            guard let resultDict = result as? [String : Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            
            // 2.判断是否分组数据
            if isGroupData {
                // 2.1.遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(AnchorGroup(dic: dict))
                }
            } else  {
                // 2.1.创建组
                let group = AnchorGroup()
                
                // 2.2.遍历dataArray的所有的字典
                for dict in dataArray {
                    group.anchors.append(AnchorModel(dict: dict as! [String : NSObject] ))
                }
                
                // 2.3.将group,添加到anchorGroups
                self.anchorGroups.append(group)
            }
            
            // 3.完成回调
            finishedCallback()
        }
    }
}
