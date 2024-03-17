//
//  AddTaskView.swift
//  MyTask
//
//  Created by Maulik Rajani on 28/01/24.
//

import SwiftUI

struct AddTaskView: View {
    
    @ObservedObject var viewModel: TaskViewModel
    @State private var newTask: Task = Task.createEmptyTask()
    @Binding var showAddTaskView: Bool
    @Binding var refreshTaskList: Bool
    @State private var shouldShowDirtyCheckAlert: Bool = false
    
    fileprivate func addTask() {
        if (viewModel.addNewTask(task: newTask)) {
            showAddTaskView.toggle()
            refreshTaskList.toggle()
        }
    }
    
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
                        if !newTask.name.isEmpty {
                            shouldShowDirtyCheckAlert.toggle()
                        } else {
                            showAddTaskView.toggle()
                        }
                    }, label: {
                        Text("Cancel")
                    })
                    .alert("Save Task", isPresented: $shouldShowDirtyCheckAlert) {
                        Button(action: {
                            showAddTaskView.toggle()
                        }, label: {
                            Text("Cancel")
                        })
                        Button(action: {
                            addTask()
                        }, label: {
                            Text("Save")
                        })
                    } message: {
                        Text("Would you like to save task?")
                    }

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
                    .disabled(newTask.name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: TaskViewModelFactory.createTaskViewModelFactory(), showAddTaskView: .constant(false),
                refreshTaskList: .constant(false))
}
