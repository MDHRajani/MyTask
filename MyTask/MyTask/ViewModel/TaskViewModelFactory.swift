//
//  TaskViewModelFactory.swift
//  MyTask
//
//  Created by Maulik Rajani on 16/03/24.
//

import Foundation

final class TaskViewModelFactory {
    static func createTaskViewModelFactory() -> TaskViewModel {
        return TaskViewModel(taskRepository: TaskRepositoryImplementation())
    }
}
