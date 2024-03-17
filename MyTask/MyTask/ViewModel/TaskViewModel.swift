//
//  TaskViewModel.swift
//  MyTask
//
//  Created by Maulik Rajani on 28/01/24.
//

import Foundation

final class TaskViewModel: ObservableObject {
    @Published var tasks: [Task] = []
    private let taskRepository: TaskRepositoryImplementation
    
    init(taskRepository: TaskRepositoryImplementation) {
        self.taskRepository = taskRepository
    }
    
    
    func getTask(isCompleted: Bool) {
        self.tasks = taskRepository.getTask(isCompleted: !isCompleted)
    }
    
    func addNewTask(task: Task) -> Bool {
        return taskRepository.add(task: task)
    }
    
    func updateTask(task: Task) -> Bool {
        return taskRepository.update(task: task)
    }
    
    func deleteTask(task: Task) -> Bool {
        return taskRepository.deleteTask(task: task)
    }
}
