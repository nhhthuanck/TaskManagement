//
//  ContentView.swift
//  TaskManagement
//
//  Created by Thuan Nguyen on 20/9/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var viewModel = ItemViewModel()
    @State private var createNewTask: Bool = false
    @State var currentDate: Date = .init()
        
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text(self.viewModel.currentDate.formatted(.dateTime.year().month(.wide).day().weekday(.wide)))
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.theme.secondaryText)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    CalendarHeaderView(viewModel: viewModel)
                        .frame(height: 89)
                    
                    ScrollView(.vertical) {
                        ListView(date: $viewModel.currentDate)
                    }
                    .scrollIndicators(.hidden)
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        HStack {
                            Text(self.viewModel.currentDate.formatted(.dateTime.month(.wide)))
                                .font(.largeTitle)
                                .fontWeight(.bold)
                            Text(self.viewModel.currentDate.formatted(.dateTime.year()))
                                .foregroundColor(Color.theme.secondaryText)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            createNewTask = true
                        }, label: {
                            Image(systemName: "plus")
                                .foregroundColor(.primary)
                        })
                            .sheet(isPresented: $createNewTask) {
                                ActionView()
                                    .presentationDetents([.height(380)])
                                    .presentationBackground(.thinMaterial)
                            }
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: TaskItem.self, inMemory: true)
}
