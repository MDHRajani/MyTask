//
//  AddTaskView.swift
//  MyTask
//
//  Created by Maulik Rajani on 28/01/24.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var viewModel: TaskViewModel
    @State private var newTask: Task = Task(id: 0, name: "", description: "", finishDate: Date(), isCompleted: true)
    @Binding var showAddTaskView: Bool
    @Binding var refreshTaskList: Bool
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Task name", text: $newTask.name)
                    TextEditor(text: $newTask.description)
                } header: {
                    Text("Task Detail")
                }
                
                Section(content: {
                    DatePicker("Task Date", selection: $newTask.finishDate)
                }, header: {
                    Text("Task Date/ Time")
                })
            }
            .navigationTitle("Add Task")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showAddTaskView.toggle()
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        print("Add tapped")
                        if (viewModel.addNewTask(task: newTask)) {
                            showAddTaskView.toggle()
                            refreshTaskList.toggle()
                        }
                        
                    }, label: {
                        Text("Add")
                    })
                }
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: TaskViewModel(), showAddTaskView: .constant(false), refreshTaskList: .constant(false))
}
