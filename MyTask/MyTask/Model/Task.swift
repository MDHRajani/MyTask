//
//  Task.swift
//  MyTask
//
//  Created by Maulik Rajani on 28/01/24.
//

import Foundation

struct Task {
    let id: Int
    var name: String
    var description: String
    var finishDate: Date
    var isCompleted: Bool
    
    static func createMockTasks() -> [Task] {
        return [Task(id: 1, name: "go to gym", description: "back workout", finishDate: Date(), isCompleted: false),
                Task(id: 2, name: "car wash", description: "carzz care", finishDate: Date(), isCompleted: false),
                 Task(id: 3, name: "Office work", description: "PR reviews", finishDate: Date(), isCompleted: true)]
    }
}
