//
//  TaskDetailView.swift
//  MyTask
//
//  Created by Maulik Rajani on 10/03/24.
//

import SwiftUI

struct TaskDetailView: View {
    @ObservedObject var viewModel: TaskViewModel
    @Binding var showTaskDetailView: Bool
    @Binding var selectedTask: Task
    @Binding var refreshTaskList: Bool
    @State private var shouldShowDeleteAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Task name", text: $selectedTask.name)
                    TextEditor(text: $selectedTask.description)
                    Toggle(isOn: $selectedTask.isCompleted) {
                        Text("Mark Complete")
                    }
                } header: {
                    Text("Task Detail")
                }
                
                Section(content: {
                    DatePicker("Task Date", selection: $selectedTask.finishDate)
                }, header: {
                    Text("Task Date/ Time")
                })
                
                Section {
                    Button {
                        shouldShowDeleteAlert.toggle()
                    } label: {
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
                    }.alert("Delete Task?", isPresented: $shouldShowDeleteAlert) {
                        Button {
                            showTaskDetailView.toggle()
                        } label: {
                            Text("No")
                        }
                        
                        Button(role: .destructive) {
                            if (viewModel.deleteTask(task: selectedTask)) {
                                showTaskDetailView.toggle()
                                refreshTaskList.toggle()
                            }

                        } label: {
                            Text("Yes")
                        }

                    } message: {
                        Text("Would you like to delete the task \(selectedTask.name)?")
                    }

                }
            }
            .navigationTitle("Task Detail")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        showTaskDetailView.toggle()
                    }, label: {
                        Text("Cancel")
                    })
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        if (viewModel.updateTask(task: selectedTask)) {
                            showTaskDetailView.toggle()
                            refreshTaskList.toggle()
                        }
                    }, label: {
                        Text("Update")
                    })
                    .disabled(selectedTask.name.isEmpty)
                }
            }
        }
    }
}

#Preview {
    TaskDetailView(viewModel: TaskViewModelFactory.createTaskViewModelFactory(), 
                   showTaskDetailView: .constant(false),
                   selectedTask: .constant(Task.createEmptyTask()), refreshTaskList: .constant(false))
}
