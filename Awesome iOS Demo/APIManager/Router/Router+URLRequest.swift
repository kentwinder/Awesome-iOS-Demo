//
//  Router+URLRequest.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import Alamofire

extension Router {
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: urlPath)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.httpBody = Data()
        setHttpHeaders(urlRequest: &urlRequest, headers: headers)
        if method == .get {
            return try Alamofire.URLEncoding.default.encode(urlRequest, with: parameters)
        } else {
            return try Alamofire.JSONEncoding.default.encode(urlRequest, with: parameters)
        }
    }
    
    func setHttpHeaders(urlRequest: inout URLRequest, headers: [String: String]?) {
        addDefaultHttpHeader(urlRequest: &urlRequest)
        if let headers = headers {
            for each in headers.keys {
                urlRequest.setValue(headers[each], forHTTPHeaderField: each)
            }
        }
    }
    
    func addDefaultHttpHeader(urlRequest: inout URLRequest) {
        urlRequest.setValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
    }
}
