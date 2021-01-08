//
//  ViewController.swift
//  tabbarExercises
//
//  Created by Lizihao Li on 2021/1/4.
//  Copyright © 2021 Lizihao Li. All rights reserved.
//

import UIKit
import MJRefresh

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,MakeDetailPageWorkSomethingProtocol
{
    var pageNumber = 1
    var isRefresh = true
    var tableView: UITableView?
    lazy var modelArr: [MiddleListPageDataModel] = []
    // delegate实现
    var testStr = "测试代理属性"
    var num: Int{
        get{
            return 100
        }
    }
    var num2: String{
        get{
            return testStr
        }
        set
        {
            testStr = "测试代理属性!"
        }
    }
    // delegate
    func giveValue() {
          print("详情页面安排我去做事情")
        startRefresh()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
        addTableView()
        self.tableView?.mj_header?.beginRefreshing()
        
    }
    func addTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: GET_NAVGATION_HEIGHT(), width: SCREEN_WIDTH, height: IPHONE_CENTER_VIEW_HEIGHT), style: .plain)
        self.tableView?.backgroundColor = UIColor.white
        self.tableView?.tableFooterView = UIView.init(frame: CGRect.zero)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.view.addSubview(self.tableView!)
        
        let refreshHeader = MJRefreshNormalHeader()
        refreshHeader.setRefreshingTarget(self, refreshingAction: #selector(self.startRefresh))
        self.tableView?.mj_header = refreshHeader
       
        let refreshFooter = MJRefreshAutoNormalFooter()
        refreshFooter.setRefreshingTarget(self, refreshingAction: #selector(self.startLoading))
        self.tableView?.mj_footer = refreshFooter
        
    }
    
    @objc func startRefresh() {
        pageNumber = 1
        isRefresh = true
        requestData(page: pageNumber)
    }
    @objc func startLoading() {
        pageNumber += 1
        isRefresh = false
        requestData(page: pageNumber)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.modelArr.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row < self.modelArr.count{
            let model = self.modelArr[indexPath.row]
            return model.cellHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellFlag = "cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellFlag)
        {
            let targetCell: MiddleListTableViewCell = cell as! MiddleListTableViewCell
            if indexPath.row < self.modelArr.count
            {
                targetCell.model = self.modelArr[indexPath.row]
                targetCell.setDataToView()
            }
            return cell
        }else
        {
            let cell = MiddleListTableViewCell.init(style: .default, reuseIdentifier: cellFlag)
            cell.selectionStyle = .none
            if indexPath.row < self.modelArr.count
            {
                cell.model = self.modelArr[indexPath.row]
                cell.setDataToView()
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let detailVC = MiddleDetailViewController()
        detailVC.myDelagate = self
        //将函数地址赋给闭包变量
        detailVC.refreshPageListClosure = startRefresh
        
        detailVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func requestData(page:Int)
    {
        let urlString = "http://47.104.255.147:8089/SMBMS/marry/myCollects"
        let netManager = NetWorkManager()
        netManager.acquirDataByPostRequest(urlStr: urlString, paraDict: ["userId":162,"page":page,"type":1]) { (data, response, err) in
            self.dealData(data: data, err: err)
            
            print(Thread.current)
            
        }
    }
    
    func dealData(data: Data?,err: Error?) ->Void {
        
        if isRefresh {
            self.tableView?.mj_footer?.resetNoMoreData()
            self.tableView?.mj_header?.endRefreshing()
        }
        if let error = err
        {
            print(error.localizedDescription)
            
            if isRefresh == false
            {
                self.tableView?.mj_footer?.endRefreshing()
            }
        }else
        {
            if isRefresh
            {
                self.modelArr.removeAll()
            }
            
                if let targetData = data
                {
                    if let jsonObj = try? JSON.init(data: targetData){
                        
                        let status = jsonObj["status"].intValue
                        if status == 0
                        {
                            let listArr = jsonObj["data"]["list"].arrayValue
                            for dataDict:JSON in listArr
                            {
                                let model = MiddleListPageDataModel(dict: dataDict)
                                self.modelArr.append(model)
                            }
                            if listArr.isEmpty{
                                if isRefresh == false
                                {
                                    self.tableView?.mj_footer?.endRefreshingWithNoMoreData()
                                    if self.pageNumber > 1{
                                         self.pageNumber -= 1
                                    }
                                   
                                }else{
                                    self.tableView?.reloadData()
                                }
                            }else
                            {
                                if isRefresh == false
                                           {
                                               self.tableView?.mj_footer?.endRefreshing()
                                           }
                                self.tableView?.reloadData()
                            }
                            
                            
                        }else
                        {
                            if isRefresh == false && self.pageNumber > 1
                            {
                                self.pageNumber -= 1
                            }
                            self.tableView?.reloadData()
                        }
                        
                    }
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
    
        
    
    
    
    override func didReceiveMemoryWarning()
    {
        
    }
    
}
