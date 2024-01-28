//
//  TaskViewModel.swift
//  MyTask
//
//  Created by Maulik Rajani on 28/01/24.
//

import Foundation

final class TaskViewModel: ObservableObject {
    
    @Published var tasks: [Task] = []
    
    func getTask(isActive: Bool) {
        tasks = Task.createMockTasks().filter({ $0.isActive == isActive})
    }
}
