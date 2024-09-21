//
//  ActionView.swift
//  TaskManagement
//
//  Created by Thuan Nguyen on 20/9/24.
//

import SwiftUI
import SwiftData

struct ActionView: View {
    @State private var taskTitle: String = ""
    @State private var taskDate: Date = .init()
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) private var context
    
    var body: some View {
            VStack(alignment: .leading, spacing: 25) {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Button("Cancel") {
                            dismiss()
                        }
                        .foregroundColor(.red)
                        
                        Spacer()
                        
                        Button {
                            let task = TaskItem(title: taskTitle, date: taskDate)
                            do {
                                context.insert(task)
                                try context.save()
                                dismiss()
                            } catch {
                                print(error.localizedDescription)
                            }
                        } label: {
                            Text("Add")
                                .foregroundColor(.primary)
                        }
                    }
                    
                    Spacer()
                    
                    Text("Title")
                        .font(.body)
                        .padding(.top, 10)
                        .foregroundColor(Color.primary)
                    
                    TextField("  Enter task title", text: $taskTitle)
                        .font(.body)
                        .frame(height: 35)
                        .background(.secondary)
                        .foregroundColor(Color.secondaryText)
                        .cornerRadius(6)
                    
                    Text("Due date")
                        .font(.body)
                        .foregroundColor(Color.primary)
                    
                    DatePicker("", selection: $taskDate)
                        .datePickerStyle(.compact)
                        .padding(.horizontal)
                }
                .padding()
                
                Spacer()
                
                Button {
                    let task = TaskItem(title: taskTitle, date: taskDate)
                    do {
                        context.insert(task)
                        try context.save()
                        dismiss()
                    } catch {
                        print(error.localizedDescription)
                    }
                } label: {
                    Text("Add")
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color.white)
                        .foregroundColor(Color.accentColor)
                        .clipShape(.rect(cornerRadius: 10))
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .ignoresSafeArea()
            .preferredColorScheme(.dark)
            .padding(.bottom)
    }
}

#Preview {
    ActionView()
}
