//
//  GameViewModel.swift
//  DouYu
//
//  Created by 田全军 on 17/1/18.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit


class GameViewModel {
    lazy var gameModels : [GameModel] = [GameModel]()

}
extension GameViewModel{
    func loadAllGameData(finishedCallback: @escaping () -> ()) {
        
//        http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            //获取到数据
            guard let dict = result as? [String : Any] else {return}
            guard let dataArray = dict["data"] as? [[String : Any]] else {return}
            //字典转模型
            for dic in dataArray{
                self.gameModels.append(GameModel(dic: dic))
            }
            finishedCallback()
        }
    }
}
