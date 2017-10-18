//
//  AppDelegate.swift
//  DouYu
//
//  Created by 田全军 on 17/1/10.
//  Copyright © 2017年 Quanjun. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UITabBar.appearance().tintColor = UIColor.orange
        
        //3D Touch
        let homeIcon = UIApplicationShortcutIcon(type: .add)
        let homeItem = UIApplicationShortcutItem(type: "homeAnchor", localizedTitle: "首页", localizedSubtitle: "点击进入首页", icon: homeIcon, userInfo: nil)
        let playIcon = UIApplicationShortcutIcon(type: .play)
        let playItem = UIApplicationShortcutItem(type: "play", localizedTitle: "播放", localizedSubtitle: "", icon: playIcon, userInfo: nil)
        let userIcon = UIApplicationShortcutIcon(type: .search)
        let userItem = UIApplicationShortcutItem(type: "username", localizedTitle: "用户名", localizedSubtitle: "", icon: userIcon, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [homeItem, playItem, userItem]
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

