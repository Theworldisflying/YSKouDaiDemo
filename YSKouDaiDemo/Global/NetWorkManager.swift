//
//  NetWorkManager.swift
//  YSKouDaiDemo
//
//  Created by guangwei li on 2018/6/19.
//  Copyright © 2018年 guangwei li. All rights reserved.
//

import UIKit

import Moya
import SwiftyJSON


public enum NetWorkManager {
    case list
    
}

extension NetWorkManager:TargetType{
    public var baseURL: URL {
        switch self {
        case .list:
            return URL.init(string: "http://static.youshikoudai.com")!
            
        }
    }
    
    public var path: String {
        switch self {
        case .list:
            return "/mockapi/data"
            
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .list:
            return .get
            
        }
    }
    
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    public var task: Task {
        switch self {
        case .list:
            return .requestPlain
            
            
        }
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    
    
}


/*******************封装请求/结果的适配器*****************************/

struct Network {
    static let provider = MoyaProvider<NetWorkManager>()
    
    static func request(_ target:NetWorkManager,success successCallback:@escaping(JSON) -> Void,error errorCallback:@escaping(Int) ->Void,failure failureCallback:@escaping(MoyaError) -> Void){
        
        provider.request(target, completion: {(result) in
            switch result {
                
            case let .success(response):
                do{
                    //如果数据返回成功则直接将结果转为JSON
                    let res = try response.filterSuccessfulStatusCodes()
                    let json = try JSON.init(res.mapJSON())
                    successCallback(json)
                }catch let error{
                    //如果数据获取失败，则返回错误状态码
                    errorCallback((error as! MoyaError).response!.statusCode)
                }
                break
                
            case let .failure(error):
                //如果连接异常，则返沪错误信息（必要时还可以将尝试重新发起请求）
                //if target.shouldRetry {
                //    retryWhenReachable(target, successCallback, errorCallback,
                //      failureCallback)
                //}
                //else {
                failureCallback(error)
                //}
                break
                
            }
        })
    }
    
}

