//
//  APIClient.swift
//  RxSwift MVVM Currency
//
//  Created by JETS Mobile Lab - 9 on 5/29/19.
//  Copyright © 2019 Abd elrhman. All rights reserved.
//

import Foundation
import Alamofire
public enum HTTpServerMethod : String {
    case options = "OPTIONS"
    case get     = "GET"
    case head    = "HEAD"
    case post    = "POST"
    case put     = "PUT"
    case patch   = "PATCH"
    case delete  = "DELETE"
    case trace   = "TRACE"
    case connect = "CONNECT"
}
class APIClient: NSObject
{
    func executeDataAPICall(urlString : String , httpMethod : HTTpServerMethod ,
     paramates : [String:Any]? , header : [String:String]? , sucessHandler :
        @escaping(Data)-> Void , failureHandler : @escaping(Error)->Void){
        guard let apiURL = URL (string : urlString)
            else {return}
        if let isReachable = NetworkReachabilityManager(host: apiURL.host ?? "")?.isReachable , isReachable == true{
        
            Alamofire.request(apiURL, method: HTTPMethod(rawValue : httpMethod.rawValue) ?? .get, parameters: paramates, headers: header)
                .responseData{ (dataResponse) in
                    if let error = dataResponse.error {
                        failureHandler(error)
                    }
                    else if let data = dataResponse.data{
                        sucessHandler(data)
                    }
            }
        }
        else{
            let error = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil) as Error
            failureHandler(error)
            }
    } // end of executeDataAPICall
    //****************************************************************************************************************************
    func executejsonAPICall(urlString : String , httpMethod : HTTpServerMethod ,
                            paramates : [String:Any]? , header : [String:String]? , sucessHandler :
        @escaping([String:Any])-> Void , failureHandler : @escaping(Error)->Void){
        guard let apiURL = URL (string : urlString)
            else {return}
        if let isReachable = NetworkReachabilityManager(host: apiURL.host ?? "")?.isReachable , isReachable == true{
            
            Alamofire.request(apiURL, method: HTTPMethod(rawValue : httpMethod.rawValue) ?? .get, parameters: paramates, headers: header)
                .responseJSON(completionHandler:{ (jsonResponse) in
                    if let error = jsonResponse.error {
                        failureHandler(error)
                    }
                    else if let json : [String : Any] = jsonResponse.result.value as? [String : Any]
                    {
                        sucessHandler(json)
                    }
            })
        }
        else{
            let error = NSError(domain: NSURLErrorDomain, code: URLError.notConnectedToInternet.rawValue, userInfo: nil) as Error
            failureHandler(error)
        }
    } // end of executejsonAPICall
}
