//
//  TaskManagementApp.swift
//  TaskManagement
//
//  Created by Thuan Nguyen on 20/9/24.
//

import SwiftUI
import SwiftData

@main
struct TaskManagementApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: TaskItem.self)
    }
    
}
