//
//  Task.swift
//  MyTask
//
//  Created by Maulik Rajani on 28/01/24.
//

import Foundation

struct Task {
    let id: UUID
    var name: String
    var description: String
    var finishDate: Date
    var isCompleted: Bool
    
    static func createEmptyTask() -> Task {
        return Task(id: UUID(), name: "", description: "", finishDate: Date(), isCompleted: false)
    }
}
