//
//  ItemView.swift
//  TaskManagement
//
//  Created by Thuan Nguyen on 20/9/24.
//

import SwiftUI
import SwiftData

struct ItemView: View {
    @Bindable var task: TaskItem
    @Environment(\.modelContext) private var context
    
    @State private var offset = CGSize.zero
    @State private var isSwipingToDelete = false
    
    var body: some View {
        HStack(spacing: 5) {
            Circle()
                .fill(Color.theme.ocean)
                .frame(width: 8, height: 8)
                .padding(.horizontal, 15)
            VStack(alignment: .leading, spacing: 10) {
                if task.isCompleted {
                    Text(task.title)
                        .font(.headline)
                        .strikethrough()
                    Label("\(task.date.format("hh:mm a"))", systemImage: "clock")
                        .font(.subheadline)
                        .strikethrough()
                } else {
                    Text(task.title)
                        .font(.headline)
                    Label("\(task.date.format("hh:mm a"))", systemImage: "clock")
                        .font(.subheadline)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 35, alignment: .leading)
            .padding()
            .background(isSwipingToDelete ? Color.red.opacity(0.7) : Color.theme.darkBackground)
            .clipShape(.rect(cornerRadius: 15))
            .onTapGesture {
                withAnimation(.snappy) {
                    task.isCompleted.toggle()
                }
            }
            .opacity(2 - Double(abs(offset.width / 90)))
            .gesture(
                DragGesture(minimumDistance: 10)
                .onChanged { gesture in
                    offset = gesture.translation
                    isSwipingToDelete = true
                }
                .onEnded { gesture in
                    isSwipingToDelete = false
                    
                    if gesture.translation.width < -100 {
                        context.delete(task)
                    }
                })
        }
        .padding(.horizontal)
        .padding(.bottom, 25)
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: TaskItem.self, configurations: config)
    
    let task = TaskItem(title: "Example Task", date: Date())
    
    return ItemView(task: task)
        .modelContainer(container)
}
