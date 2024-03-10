//
//  HomeView.swift
//  MyTask
//
//  Created by Maulik Rajani on 28/01/24.
//

import SwiftUI

enum TodoFilters: CaseIterable {
    case isActive
    case isCompleted
}

extension TodoFilters {
    var title: String {
        switch self {
        case .isActive:
            return "Active"
        case .isCompleted:
            return "Completed"
        }
    }
}

struct HomeView: View {
    
    @StateObject var taskViewModel: TaskViewModel = TaskViewModel()
    @State private var pickerFilters = TodoFilters.allCases
    @State private var defaultSelectedPickerItem = TodoFilters.isActive.title
    @State private var showAddTaskView: Bool = false
    @State private var showTaskDetailView: Bool = false
    @State private var selectedTask: Task = Task(id: 0, name: "test", description: "test", finishDate: Date(), isCompleted: false)
    @State private var refreshTaskList: Bool = false
    
    
    var body: some View {
        NavigationStack {
            
            Picker("Picker Filter", selection: $defaultSelectedPickerItem) {
                ForEach(pickerFilters, id: \.title) {
                    Text($0.title)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: defaultSelectedPickerItem) {
                taskViewModel.getTask(isActive: defaultSelectedPickerItem == TodoFilters.isActive.title)
            }
            
            List(taskViewModel.tasks, id: \.id) { task in
                VStack(alignment: .leading) {
                    Text(task.name)
                        .font(.title)
                    HStack {
                        Text(task.description)
                        Spacer(minLength: 10)
                        Text(task.finishDate.toString())
                    }
                    .font(.subheadline)
                }.onTapGesture {
                    selectedTask = task
                    showTaskDetailView.toggle()
                }
            }.onAppear {
                taskViewModel.getTask(isActive: true)
            }
            .onChange(of: refreshTaskList, perform: { _ in
                taskViewModel.getTask(isActive: defaultSelectedPickerItem == TodoFilters.isActive.title)
            })
            
//            .onChange(of: refreshTaskList, { _, _ in
//                taskViewModel.getTask(isActive: true)
//            })
            
            .listStyle(.plain)
            .navigationTitle("Home")
            .toolbar(content: {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        showAddTaskView.toggle()
                    }, label: {
                        Image(systemName: "plus")
                    })
                }
            })
            .sheet(isPresented: $showAddTaskView, content: {
                AddTaskView(viewModel: taskViewModel,
                            showAddTaskView: $showAddTaskView,
                            refreshTaskList: $refreshTaskList)
            })
            .sheet(isPresented: $showTaskDetailView, content: {
                TaskDetailView(viewModel: taskViewModel,
                               showTaskDetailView: $showTaskDetailView,
                               selectedTask: $selectedTask, 
                               refreshTaskList: $refreshTaskList)
            })
        }
    }
}

#Preview {
    HomeView()
}
