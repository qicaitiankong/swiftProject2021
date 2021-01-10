//
//  PersonalPageViewController.swift
//  tabbarExercises
//
//  Created by Lizihao Li on 2021/1/5.
//  Copyright © 2021 Lizihao Li. All rights reserved.
//

import UIKit

class PersonalPageViewController: UIViewController {
    var imageView: UIImageView?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        // 只接受MainPageViewController发出的通知，若为nil,则对通知发送者不做筛选
        NotificationCenter.default.addObserver(self, selector: #selector(notificationCome(noti:)), name: Notification.Name("setImageNoti"), object:MainPageViewController())
        
        imageView = UIImageView.init()
        imageView!.backgroundColor = UIColor.white
        self.view.addSubview(imageView!)
        imageView!.mas_makeConstraints { (make) in
            make?.left.mas_equalTo()(20)
            make?.top.mas_equalTo()(GET_NAVGATION_HEIGHT() + 50)
            make?.width.mas_equalTo()(50)
            make?.height.mas_equalTo()(50)
            
        }
        
    }
    @objc func notificationCome(noti:NSNotification)
    {
        
        if let image = noti.userInfo?["imageName"]{
            self.imageView!.image = image as? UIImage
        }
    }
    

    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }

}
