//
//  TaskManager.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import Foundation
import Alamofire

class TaskManager {
    init() {}
    
    func addTask(desc: String, completion: @escaping (BaseResponse) -> (), failure: @escaping (String) -> ()) {
        let router = Router.addTask(desc: desc)
        APIManager.request(withRouter: router, responseType: BaseResponse.self, completion: { (response) in
            completion(response)
        }) { (error) in
            failure(error)
        }
    }
    
    func deleteTask(taskId: String, completion: @escaping (BaseResponse) -> (), failure: @escaping (String) -> ()) {
        let router = Router.deleteTask(taskId: taskId)
        APIManager.request(withRouter: router, responseType: BaseResponse.self, completion: { (response) in
            completion(response)
        }) { (error) in
            failure(error)
        }
    }
    
    func getTasks(completion: @escaping ([Task]) -> (), failure: @escaping (String) -> ()) {
        APIManager.request(withRouter: Router.getTasks, responseType: TasksResponse.self, completion: { (response) in
            completion(response.tasks)
        }) { (error) in
            failure(error)
        }
    }
    
    func updateTask(taskId: String, isDone: Bool, completion: @escaping (BaseResponse) -> (), failure: @escaping (String) -> ()) {
        let router = Router.updateTask(taskId: taskId, isDone: isDone)
        APIManager.request(withRouter: router, responseType: BaseResponse.self, completion: { (response) in
            completion(response)
        }) { (error) in
            failure(error)
        }
    }
}
