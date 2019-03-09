//
//  TasksResponse.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import UIKit

class TasksResponse: BaseResponse {
    var tasks = [Task]()
    
    private enum DataKeys: String, CodingKey {
        case data
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        if let dataContainer = try? decoder.container(keyedBy: DataKeys.self), !dataContainer.allKeys.isEmpty {
            tasks = try dataContainer.decode([Task].self, forKey: .data)
        }
    }
}
