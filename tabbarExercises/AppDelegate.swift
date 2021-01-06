//
//  AppDelegate.swift
//  tabbarExercises
//
//  Created by Lizihao Li on 2021/1/4.
//  Copyright © 2021 Lizihao Li. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        
        self.window = UIWindow(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        let rootVC = MainTabBarViewController()
        self.window?.rootViewController = rootVC
        self.window?.makeKeyAndVisible()
        
        return true
    }


}

