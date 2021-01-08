//
//  NetWorkManager.swift
//  tabbarExercises
//
//  Created by Lizihao Li on 2021/1/8.
//  Copyright © 2021 Lizihao Li. All rights reserved.
//

import UIKit

class NetWorkManager: NSObject
{
    
    /// post 请求数据  参数拼接在query中
    /// - Parameters:
    ///   - urlStr: 请求url
    ///   - paraDict: 请求参数字典
    ///   - completeHandler: 网络完成闭包函数
    /// - Returns: void
    func acquirDataByPostRequest(urlStr:String,paraDict:Dictionary<String, Any>,completeHandler:@escaping(Data?,URLResponse?,Error?) -> Void) -> Void
    {
       var localUrlStr = urlStr
       localUrlStr.getQueryUrlStrZH(paraDict: paraDict)
       var myUrl: NSURL!
       myUrl = NSURL(string:localUrlStr)
       let request = NSMutableURLRequest(url:myUrl as URL)
       request.httpMethod = "POST"
       request.timeoutInterval = 15
       let task = URLSession.shared.dataTask(with: request as URLRequest) { (data, response, err) in
            DispatchQueue.main.async {
                completeHandler(data,response,err)
           }
       }
       task.resume()
    }

}
