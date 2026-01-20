//
//  Date+Extensions.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 20/01/26.
//

import Foundation

extension Date {
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }

    var isTomorrow: Bool {
        Calendar.current.isDateInTomorrow(self)
    }

    func formattedTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
