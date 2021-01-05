//
//  ViewController.swift
//  tabbarExercises
//
//  Created by Lizihao Li on 2021/1/4.
//  Copyright © 2021 Lizihao Li. All rights reserved.
//

import UIKit
//import swiftJson

class ViewController: UIViewController,UITabBarDelegate
{
    
    var tabbar: UITabBar!
    var tabs = ["公开课","全栈课","设置"]
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        //addTabbar()
        //testJsonData()
        //swiftJson()
       //getDataBySwiftJson()
        //testPostRequest()
        testGetRequest2()
    }
    
    func testPostRequest()
    {
        let urlString = "http://47.104.255.147:8089/SMBMS/wallet/myWallets?userId=162&status=0"
        var myUrl: NSURL!
        myUrl = NSURL(string:urlString)
        let request = NSMutableURLRequest(url:myUrl as URL)
        request.httpMethod = "POST"
        //weak var weakSelf: ViewController? = self
        let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, err) in
             DispatchQueue.main.async {
                if let targetData = data
                {
                    if let jsonObj = try? JSON.init(data: targetData){
                        
                        print(jsonObj)
                    }
                    
                }
            }
        }
        task.resume()
    }
     func testGetRequest2()
        {
            let urlString = "http://47.104.255.147:8089/LinPic/userPic/166/2e916952-6029-43bb-b868-a47803417dee.o6zAJszNwPS00IesFkn79wg-n95k.YuOuivovKZ9p021925d37b7b1aa13827dd47e49c8754.png"
                    var myUrl: NSURL!
                   myUrl = NSURL(string:urlString)
                   let request = NSMutableURLRequest(url:myUrl as URL)
                   request.httpMethod = "GET"
                   //weak var weakSelf: ViewController? = self
                   let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, err) in
                    //这是一个新线程，默认不是主线程！
                    //print(Thread.current)
                    
                    DispatchQueue.main.async {
                        print("回到主线程")
                        if let targetData = data
                                               {
                        //                           if let jsonObj = try? JSON.init(data: targetData){
                        //                               print(jsonObj)
                        //                           }
                                                   
                                               }
                                           }
                    }
                       
                   task.resume()
            
        }
    
    
    
    //swiftJson 与URLSession结合
    func getDataBySwiftJson()
    {
        
        //此网络地址已经失效
        let url = URL(string: "http://www.hangge.com/getJsonData.php")
        //创建请求对象
        let request = URLRequest(url: url!)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("error")
            }else
            {
                print("解析正确： data=\(data!)")
                if let responseData = data
                {
                    
                     if let jsonObject = try? JSON(data: responseData)
                     {
                        if let number = jsonObject[0]["phones"][0]["number"].string
                        {
                            print("第一个人的电话：\(number)")
                        }else
                        {
                            print("解析出错：\(jsonObject[0]["phones"][0]["number"].string!)")
                        }
                    }else
                     {
                        print("对象转化失败")
                    }
                }else
                {
                    print("data 为空")
                }
            }
        }
        dataTask.resume()
    }
    
    
    /// 使用swiftJson 快速解析
    func swiftJson(){
        /*
         同 JSONSerialization  相比，在获取多层次结构的JSON数据时。SwiftyJSON不需要一直判断这个节点是否存在，是不是我们想要的class，下一个节点是否存在，是不是我们想要的class…。同时，SwiftyJSON内部会自动对optional（可选类型）进行拆包（Wrapping ），大大简化了代码。
         */
        
        
        
        let jsonStr = "[{\"name\": \"hangge\", \"age\": 100, \"phones\": [{\"name\": \"公司\",\"number\": \"123456\"}, {\"name\": \"家庭\",\"number\": \"001\"}]}, {\"name\": \"big boss\",\"age\": 1,\"phones\": [{ \"name\": \"公司\",\"number\": \"111111\"}]}]"
        
         print("对象：\(getObjectFromJsonStrZH(dataInfo: jsonStr)!)")
        
        if let jsonData = getDataFromJsonStrZH(jsonStr: jsonStr)
        {
            if let jsonObject = try? JSON(data: jsonData)
            {
                 /*下标访问方式三种
                 1、let number = json[0]["phones"][0]["number"].stringValue
                 2.通过数组访问  jsonObject[0,"phones",0,"number"]
                 3、let keys:[JSONSubscriptType] = [0,"phones",0,"number"]
                 let number = json[keys].stringValue
                 */
                //
                if let number = jsonObject[0]["phones"][0]["number"].string
                {
                    print("第一个人的第一个电话：\(number)")
                }else
                {//如果没取到值，还可以走到错误处理来了，打印一下看看错在哪：
                    //print("swift json 解析出错：\(jsonObject[0]["phones22"][0]["number"])")
                }
                    //json对象 -> json字符串
                 //jsonObject.rawString()
                    //json对象 -> 字典
                //jsonObject.dictionaryObject
                //json对象 -> 数组
                //jsonObject.arrayObject
                
            }
        }
        
        
    }
    
    /// 系统方法测试json 和对象相互转化
    func testJsonData() {
         /*
        JSONSerialization能将JSON转换成Foundation对象，也能将Foundation对象转换成JSON，但转换成JSON的对象必须具有如下属性：
                       1，顶层对象必须是Array或者Dictionary
                       2，所有的对象必须是String、Number、Array、Dictionary、Null的实例
                       3，所有Dictionary的key必须是String类型
                       4，数字对象不能是非数值或无穷
                       注意：尽量使用JSONSerialization.isValidJSONObject先判断能否转换成功。

                       原文出自：www.hangge.com  转载请保留原文链接：https://www.hangge.com/blog/cache/detail_647.html
                       */
         let testDict: [String: Any] = [
                    "uname": "张三",
                    "tel": ["mobile": "138", "home": "010"]
                ]
                
        //        let testDict = [
        //                   "张三",
        //                   "tel"
        //               ]
               
               
                
                //判断是否合法
                if JSONSerialization.isValidJSONObject(testDict)
                {
                        if let jsonData = getDataFromObjectZH(obj: testDict)
                        {
                            print("data 转化为的json字符串为 \(getJsonStrFromDataZH(dataInfo: jsonData)!)")
                            if let dataDict = getObjectFromDataZH(dataInfo: jsonData)
                            {
                                print("dataDict为 \(dataDict)")
                                if let localDataDict = dataDict as? Dictionary<String,Any>{
                                    let name = localDataDict["uname"]
                                    print("\(dataDict) \n \(name!)")
                                    
                                }
                                
                            }
                        }else
                        {
                        }
                }
    }
    
    
   func addTabbar()
    {
           tabbar = UITabBar(frame: CGRect(x: 0, y: self.view.bounds.height - 49, width: self.view.bounds.size.width, height: 49))
           
           var items: [UITabBarItem] = []
           for tab in self.tabs
           {
               let tabItem = UITabBarItem()
               tabItem.title = tab
               items.append(tabItem)
           }
           tabbar.setItems(items, animated: true)
           tabbar.delegate = self
           self.view.addSubview(tabbar)
    }
       
   func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem)
   {
       print("\(item.title)")
   }
    
    override func didReceiveMemoryWarning()
    {
        
    }
    
}
