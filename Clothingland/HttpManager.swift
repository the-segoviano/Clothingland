//
//  HttpManager.swift
//  Clothingland
//
//  Created by Luis Segoviano on 23/03/20.
//  Copyright © 2020 Luis Segoviano. All rights reserved.
//

import Foundation
import Alamofire

class HttpManager {
    
    private static let scheme = "https://"
    private static var host   = "private-anon-82100d67b3-gocco.apiary-mock.com" // "polls.apiblueprint.org"
    private static let path   = ""
    
    /**
     * Retorna la URL base para hacer el request
     *
     */
    class func baseUrl() -> String {
        return scheme + host + path
    }
    
    class func getRequest(segment: String!, context: UIViewController,
                          completionHandler: @escaping (_ responseData: Any?,
                          _ errorMessage: String?) -> ()) {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let fullUrl = baseUrl() + segment
        AF.request(fullUrl, method: .get,
                          parameters: nil,
                          encoding: URLEncoding.default).validate(statusCode: 200..<300).responseJSON { response in
                            //print("Request: \(response.request)")
                            //print("Response: \(response.response)")
                            //print("Error: \(response.error)")
                            UIApplication.shared.isNetworkActivityIndicatorVisible = false
                            switch response.result {
                            case .success:
                                if let data = response.data {
                                    let resultRequest = try! JSONSerialization.jsonObject(with: data, options: [])
                                    completionHandler(resultRequest, "")
                                }
                            case .failure:
                                Alerts.showSimpleAlert(message: response.description,
                                                       context: context, success: nil)
                                
                            }
        }
        
    } // Request
    
    
} // HttpManager
