//
//  APIManager.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import Alamofire

public class APIManager {
    public static let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        
        return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: nil
        )
    }()
    
    @discardableResult
    static func request<Result: Decodable>(withRouter router: BaseRouter, responseType: Result.Type, completion: @escaping (_ result: Result) -> (), failure: @escaping (_ error: String) -> ()) -> Request? {
        return manager.request(router)
            .responseData(completionHandler: { (response) in
                switch response.result {
                case .success(let data):
                    do {
                        let resultObj = try JSONDecoder().decode(responseType, from: data)
                        if let object = resultObj as? BaseResponse {
                            if object.resultCode == 200 {
                                completion(resultObj)
                            } else {
                                failure("API is unavailable at the moment")
                            }
                        } else {
                            completion(resultObj)
                        }
                    } catch {
                        failure("Returned data is in incorrect format")
                    }
                    break
                case .failure(let error):
                    failure(error.localizedDescription)
                    break
                }
            })
    }
    
    static func validate(statusCode code: Int) -> Bool {
        if code != 200 {
            return false
        }
        
        return true
    }
}
