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
                        print("Save tapped")
                    }, label: {
                        Text("Save")
                    })
                }
            }
        }
    }
}

#Preview {
    AddTaskView(viewModel: TaskViewModel(), showAddTaskView: .constant(false))
}
