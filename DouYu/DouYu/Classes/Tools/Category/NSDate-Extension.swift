//
//  NSDate-Extension.swift
//  DouYu
//
//  Created by 田全军 on 17/1/15.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

extension NSDate{
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
