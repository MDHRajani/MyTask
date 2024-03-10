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
                        print("delet tapped")
                    } label: {
                        Text("Delete")
                            .fontWeight(.bold)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity)
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
                        print("Update tapped")
                    }, label: {
                        Text("Update")
                    })
                }
            }
        }
    }
}

#Preview {
    TaskDetailView(viewModel: TaskViewModel(), 
                   showTaskDetailView: .constant(false),
                   selectedTask: .constant(Task.createMockTasks().first!))
}
