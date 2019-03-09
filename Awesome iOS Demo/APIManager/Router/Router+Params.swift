//
//  Router+Params.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

extension Router {
    var parameters: [String: Any]? {
        switch self {
        case .addTask(let desc):
            return [
                "task": desc
            ]
        case .deleteTask(let taskId):
            return [
                "id": taskId
            ]
        case .updateTask(let taskId, let isDone):
            return [
                "id": taskId,
                "isDone": isDone
            ]
        default:
            return nil
        }
    }
}
