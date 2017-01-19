//
//  HappyViewModel.swift
//  DouYu
//
//  Created by 田全军 on 17/1/20.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

class HappyViewModel: BaseViewModel {

}

extension HappyViewModel {
    func loadFunnyData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(isGroupData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : "30", "offset" : "0"], finishedCallback: finishedCallback)
        
    }
}
