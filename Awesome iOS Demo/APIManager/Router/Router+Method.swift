//
//  Router+Method.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import Alamofire

extension Router {
    var method: Alamofire.HTTPMethod {
        switch self {
        case .addTask:
            return .post
        case .deleteTask:
            return .delete
        case .updateTask:
            return .put
        default:
            return .get
        }
    }
}
