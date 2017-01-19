//
//  AmuseViewModel.swift
//  DouYu
//
//  Created by 田全军 on 17/1/19.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseViewModel {

}

// MARK: 请求
extension AmuseViewModel{
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: true, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", finishedCallback: finishedCallback)
    }
}
