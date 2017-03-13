//
//  AppDelegate.swift
//  抽屉效果
//
//  Created by administrator on 2017/3/10.
//  Copyright © 2017年 WL. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        
        let leftVC = LeftMenuViewController()
        let tabBarVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        window?.rootViewController = DrawerViewController(mainVC: tabBarVC!, leftMenuVC: leftVC, leftWidth: 300)
        window?.makeKeyAndVisible()
        
        return true
    }


}

