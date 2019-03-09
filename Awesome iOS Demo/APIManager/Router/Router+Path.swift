//
//  Router+Path.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

extension Router {
    
    var path: String {
        switch self {
        case .addTask:
            return "/task"
        case .deleteTask(let taskId):
            return "/task/\(taskId)"
        case .getTasks:
            return "/task"
        case .updateTask(let params):
            return "/task/\(params.taskId)"
        }
    }
}
