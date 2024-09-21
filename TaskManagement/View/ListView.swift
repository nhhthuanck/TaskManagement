//
//  ListView.swift
//  TaskManagement
//
//  Created by Thuan Nguyen on 20/9/24.
//

import SwiftUI
import SwiftData

struct ListView: View {
    @Binding var date: Date
    @Query private var tasks: [TaskItem]
    
    init(date: Binding<Date>) {
        self._date = date
        
        let calendar = Calendar.current
        let startDate = calendar.startOfDay(for: date.wrappedValue)
        let endOfDate = calendar.date(byAdding: .day, value: 1, to: startDate)!
        let predicate = #Predicate<TaskItem> {
            return $0.date >= startDate && $0.date < endOfDate
        }
        
        let sortDescriptor = [
            SortDescriptor(\TaskItem.date, order: .forward)
        ]
        self._tasks = Query(filter: predicate, sort: sortDescriptor, animation: .snappy)
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(tasks) { task in
                    ItemView(task: task)
                        .background(alignment: .leading) {
                            if tasks.last?.id != task.id {
                                Rectangle()
                                    .frame(width: 1)
                                    .foregroundColor(Color.theme.secondaryText)
                                    .offset(x: 35, y: 38)
                            }
                        }
                }
            }
            .padding(.top, 20)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ListView(date: .constant(Date()))
        .modelContainer(for: TaskItem.self)
}
