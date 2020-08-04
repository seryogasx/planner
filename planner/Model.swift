//
//  Model.swift
//  planner
//
//  Created by Сергей Петров on 02.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import Foundation

struct Note {
    let description: String
    let state: Bool
    var startDate: Date? = nil
    var finishDate: Date? = nil
}


extension Date {
    var noteDate: String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
//        let month = calendar.component(.month, from: self)
        
        if (day - calendar.component(.day, from: now)) == -1 {
            return "Yesterday"
        }
        else if (day - calendar.component(.day, from: now)) == 0 {
            return "Today"
        }
        else if (day - calendar.component(.day, from: now)) == 1 {
            return "Tomorrow"
        }
        return dateFormatter.string(from: self)
    }
}
