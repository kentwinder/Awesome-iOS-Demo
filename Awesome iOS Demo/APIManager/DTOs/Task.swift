//
//  Task.swift
//  Awesome iOS Demo
//
//  Created by Kent Winder on 2/19/19.
//  Copyright © 2019 Kent Winder. All rights reserved.
//

import UIKit

class Task: Decodable {
    var id: String?
    var desc: String?
    var isDone: Bool! = false
    var createdAt: String?
    
    private enum DataKeys: String, CodingKey {
        case desc = "task"
        case id, isDone, createdAt
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DataKeys.self)
        id = try? container.decode(String.self, forKey: .id)
        isDone = try? container.decode(Bool.self, forKey: .isDone)
        createdAt = try? container.decode(String.self, forKey: .createdAt)
        desc = try? container.decode(String.self, forKey: .desc)
    }
}
