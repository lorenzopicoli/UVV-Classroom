//
//  AlamofireWrapper.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 25/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

// Custom error typealias
typealias UVVNetworkResponseHandler = (JSON, UVVError?) -> Void

/*
 * This class is a wrapper around Alamofire's (get, post, put, ...) methods
 * The idea is to provide a place to handle the response, handle errors in a custom way
 * and log the requests for easier debugging
 * PS: We probably don't need all the methods for this simple app :)
 */
class AlamofireWrapper: NSObject{
    
    //MARK: Response handler
    class func handleResponse(response: DataResponse<Any>, completion: UVVNetworkResponseHandler){
        
        if let request = response.request{
            if let url = request.url{
                print("Requesting Server for: ", url.absoluteString)
            }
        }
        
        if let response = response.response{
            print("Got response: ", response.statusCode)
            
            var error = UVVError(rawValue: response.statusCode)
            
            //Error should not be nil, 200 will generate error = .NoError
            if error == nil{
                error = .unkownError
            }
            
            if error != .noError{
                completion(.null, error)
                return
            }
        }
        
        switch response.result {
        case .success(let resultData):
            print("Validation Successful")
            print("Result: ")
            
            let json = JSON(object: resultData)
            
            print(json)
            
            completion(json, nil)
            
        case .failure(let error):
            print("Failed to request")
            print(error.localizedDescription)
            completion(.null, .requestFailed)
            return
        }
    }
    
    //MARK: Method wrappers
    
    class func post(route:String,
                    headers:[String : String] = [:],
                    params:[String : Any] = [:],
                    completion: @escaping UVVNetworkResponseHandler){
        
        Alamofire.request(AlamofireWrapper.getFormatterdUrl(route: route),
                          method: .post,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON
            { response in
                
                AlamofireWrapper.handleResponse(response: response, completion: completion)
        }
    }
    
    class func get(route:String,
                   headers:[String : String] = [:],
                   params:[String : Any] = [:],
                   completion: @escaping UVVNetworkResponseHandler){
        
        Alamofire.request(AlamofireWrapper.getFormatterdUrl(route: route),
                          method: .get,
                          parameters: params,
                          encoding: URLEncoding.default,
                          headers: headers).responseJSON
            { response in
                
                AlamofireWrapper.handleResponse(response: response, completion: completion)
        }
    }
    
    class func put(route:String,
                   headers:[String : String] = [:],
                   params:[String : Any] = [:],
                   completion: @escaping UVVNetworkResponseHandler){
        
        Alamofire.request(AlamofireWrapper.getFormatterdUrl(route: route),
                          method: .put,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON
            { response in
                
                AlamofireWrapper.handleResponse(response: response, completion: completion)
        }
    }
    
    class func delete(route:String,
                      headers:[String : String] = [:],
                      params:[String : Any] = [:],
                      completion: @escaping UVVNetworkResponseHandler){
        
        Alamofire.request(AlamofireWrapper.getFormatterdUrl(route: route),
                          method: .delete,
                          parameters: params,
                          encoding: JSONEncoding.default,
                          headers: headers).responseJSON
            { response in
                
                AlamofireWrapper.handleResponse(response: response, completion: completion)
        }
    }
    
    //MARK: Helpers
    class func getFormatterdUrl(route:String) -> String{
        return "\(UVVApiManager.apiURL)/\(route)\(UVVApiManager.apiURLSuffix)"
    }
}
