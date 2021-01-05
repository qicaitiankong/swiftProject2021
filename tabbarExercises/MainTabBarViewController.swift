//
//  MainTabBarViewController.swift
//  tabbarExercises
//
//  Created by Lizihao Li on 2021/1/5.
//  Copyright © 2021 Lizihao Li. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let mainVC = MainPageViewController()
        mainVC.title = "首页"
        let mainNav = UINavigationController(rootViewController: mainVC)
        mainNav.tabBarItem.image = UIImage(named: "icon_tab_01")
        mainNav.tabBarItem.selectedImage = UIImage(named: "icon_tab_01_sel")
        
        
        let middleVC = ViewController()
        middleVC.title = "课程"
        let middleNav = UINavigationController(rootViewController: middleVC)
        middleNav.tabBarItem.image = UIImage(named: "icon_tab_02")
        middleNav.tabBarItem.selectedImage = UIImage(named: "icon_tab_02_sel")
        
        let personalVC = PersonalPageViewController()
        personalVC.title = "个人中心"
        let personalNav = UINavigationController(rootViewController: personalVC)
        personalNav.tabBarItem.image = UIImage(named: "icon_tab_03")
        personalNav.tabBarItem.selectedImage = UIImage(named: "icon_tab_03_sel")
        
        self.viewControllers = [mainNav,middleNav,personalNav]
        self.selectedIndex = 0
    }
    


}
