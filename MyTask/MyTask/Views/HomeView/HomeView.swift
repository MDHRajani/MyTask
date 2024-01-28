//
//  HomeView.swift
//  MyTask
//
//  Created by Maulik Rajani on 28/01/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var taskViewModel: TaskViewModel = TaskViewModel()
    
    var body: some View {
        NavigationStack {
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
                }
            }.onAppear {
                taskViewModel.getTask(isActive: true)
            }
        .listStyle(.grouped)
        .navigationTitle("Home")
        }
    }
}

#Preview {
    HomeView()
}
