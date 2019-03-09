//
//  Router.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import Alamofire

protocol BaseRouter: URLRequestConvertible {
    var apiUrl: String { get }
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var headers: [String: String]? { get }
}

enum Router: BaseRouter {
    case addTask(desc: String)
    case deleteTask(taskId: String)
    case getTasks
    case updateTask(taskId: String, isDone: Bool)
}

extension Router {
    var headers: [String: String]? {
        return nil
    }
    
    var apiUrl: String {
        return Constants.apiEndPoint
    }
    
    var urlPath: String {
        return apiUrl + path
    }
}
