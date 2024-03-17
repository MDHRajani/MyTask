//
//  TaskRepository.swift
//  MyTask
//
//  Created by Maulik Rajani on 16/03/24.
//

import Foundation
import CoreData.NSManagedObjectContext

protocol TaskRepository {
    func getTask(isCompleted: Bool) -> [Task]
    func update(task: Task) -> Bool
    func add(task: Task) -> Bool
    func deleteTask(task: Task) -> Bool
}

final class TaskRepositoryImplementation: TaskRepository {
    
    private let managedObjectContext: NSManagedObjectContext = PersistenceController.shared.viewContext
    
    func getTask(isCompleted: Bool) -> [Task] {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "isCompleted == %@", NSNumber(value: isCompleted))
        do {
            let result = try managedObjectContext.fetch(fetchRequest)
            if !result.isEmpty {
                return result.map({Task(id: $0.id!,
                                        name: $0.name ?? "",
                                        description: $0.taskDescription ?? "",
                                        finishDate: $0.finishDate ?? Date(),
                                        isCompleted: $0.isCompleted)})
            }
        } catch {
            print("error on getTask:- \(error.localizedDescription)")
        }
        return []
    }
    
    func update(task: Task) -> Bool {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        
        do {
            if let existingTask = try managedObjectContext.fetch(fetchRequest).first {
                existingTask.name = task.name
                existingTask.taskDescription = task.description
                existingTask.finishDate = task.finishDate
                existingTask.isCompleted = task.isCompleted
                try managedObjectContext.save()
                return true
            } else {
                print("No task found with the id:\(task.id)")
                return false
            }
        } catch {
            print("error on update:- \(error.localizedDescription)")
            return false
        }
    }
    
    func add(task: Task) -> Bool {
        let taskEntity = TaskEntity(context: managedObjectContext)
        taskEntity.id = UUID()
        taskEntity.isCompleted = false
        taskEntity.name = task.name
        taskEntity.taskDescription = task.description
        taskEntity.finishDate = task.finishDate
        
        do {
            try managedObjectContext.save()
            return true
        } catch {
            print("error on add = \(error.localizedDescription)")
            return false
        }
    }
    
    func deleteTask(task: Task) -> Bool {
        let fetchRequest = TaskEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        do {
            if let existingTask = try managedObjectContext.fetch(fetchRequest).first {
                managedObjectContext.delete(existingTask)
                try managedObjectContext.save()
                return true
            } else {
                print("Delete: no task found to delete.")
                return false
            }
        } catch {
            print("error on delete = \(error.localizedDescription)")
            return false
        }
    }
}
