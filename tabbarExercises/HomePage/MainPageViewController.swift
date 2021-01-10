//
//  MainPageViewController.swift
//  tabbarExercises
//
//  Created by Lizihao Li on 2021/1/5.
//  Copyright © 2021 Lizihao Li. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        let testButton = UIButton.init(type: .custom)
        testButton.frame = CGRect(x: 10, y: 200, width: 100, height: 50)
        testButton.backgroundColor = UIColor.green
        self.view.addSubview(testButton)
        testButton.addTarget(self, action: #selector(clickButton(b:)), for: .touchUpInside)
        // 测试通知
        let button = UIButton.init(type: .custom)
        self.view.addSubview(button)
        button.setTitle("给个人中心页面设置头像", for: .normal)
        button.backgroundColor = UIColor.gray
        button.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(testButton)
            make?.width.mas_equalTo()(150)
            make?.top.mas_equalTo()(testButton.mas_bottom)?.offset()(20)
            make?.height.mas_equalTo()(50)
        }
        button.addTarget(self, action: #selector(clickButton(butt:)), for: .touchUpInside)
    }
    
    @objc func clickButton(butt:UIButton){
        if let image = UIImage.init(named: "icon_tab_02"){
            // object:指定该通知是谁发送的，如果设为nil,那你接收通知时也要设为nil
            NotificationCenter.default.post(name: NSNotification.Name("setImageNoti"), object: MainPageViewController(), userInfo:["imageName":image])
        }
        
    }
    
    @objc func clickButton(b:UIButton){
        //使用oc 控制器
        let targetVC = TestOcViewController()
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
}
