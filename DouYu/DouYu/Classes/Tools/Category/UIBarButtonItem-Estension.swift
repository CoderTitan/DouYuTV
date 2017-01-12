//
//  UIBarButtonItem-Estension.swift
//  DouYu
//
//  Created by 田全军 on 17/1/11.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    
    /*/**
     类方法创建
     - parameter itemSize:    控件的尺寸
     */
    class func creatBarButtonItem(norImage : String, selectImage : String, itemSize : CGSize) -> UIBarButtonItem {
        
        let button = UIButton()
        button.frame = CGRect(origin: CGPointZero, size: itemSize)
        button.setImage(UIImage(named: norImage), forState: UIControlState.Normal)
        button.setImage(UIImage(named: selectImage), forState: UIControlState.Selected)
        
        return UIBarButtonItem(customView: button)
    }
*/
    
    // 便利构造函数: 1> convenience开头 2> 在构造函数中必须明确调用一个设计的构造函数(self)
    convenience init(norImage : String, selectImage : String = "", itemSize : CGSize = CGSizeZero) {
        
        let button = UIButton()
        button.setImage(UIImage(named: norImage), forState: UIControlState.Normal)
        
        if selectImage != ""{
            button.setImage(UIImage(named: selectImage), forState: .Highlighted)
        }
        
        if itemSize == CGSizeZero{
            button.sizeToFit()
        }else{
            button.frame = CGRect(origin: CGPointZero, size: itemSize)
        }
        
        self.init(customView : button)
    }
}
