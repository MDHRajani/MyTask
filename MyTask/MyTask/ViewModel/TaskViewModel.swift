//
//  TaskViewModel.swift
//  MyTask
//
//  Created by Maulik Rajani on 28/01/24.
//

import Foundation

final class TaskViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    private var tempTasks = Task.createMockTasks()
    
    func getTask(isActive: Bool) {
        tasks = tempTasks.filter({ $0.isCompleted == !isActive})
    }
    
    func addNewTask(task: Task) -> Bool {
        
        let taskID = Int.random(in: 4...100)
        let newTask = Task(id: taskID,
                           name: task.name,
                           description: task.description,
                           finishDate: task.finishDate,
                           isCompleted: false)
        tempTasks.append(newTask)
        return true
    }
    
    func updateTask(task: Task) -> Bool {
        if let index = tempTasks.firstIndex(where: { $0.id == task.id }) {
            var taskToUpdate = tempTasks[index]
            taskToUpdate.name = task.name
            taskToUpdate.description = task.description
            taskToUpdate.finishDate = task.finishDate
            taskToUpdate.isCompleted = task.isCompleted
            tempTasks[index] = taskToUpdate
            return true
        }
        return false
    }
    
    func deleteTask(taskID: Int) -> Bool {
        if let index = tempTasks.firstIndex(where: { $0.id == taskID }) {
            tempTasks.remove(at: index)
            return true
        }
        return false
    }
}
