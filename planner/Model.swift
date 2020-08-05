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
    var state: Bool
    var finishDate: Date? = nil
}


extension Date {
    var noteDate: String {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        
        let calendar = Calendar.current
        let day = calendar.component(.day, from: self)
        
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

func getNotesData() -> [Note] {
    let note1 = Note(description: "desc1", state: true)
    let note2 = Note(description: "desc2", state: false, finishDate: Date())
    let note3 = Note(description: "desc3", state: false, finishDate: Date(timeIntervalSinceNow: -80000))
    let note4 = Note(description: "deschhfjdkdkdfjjfjfd jncjkndjnsjcs dsdmkldsmcklmsdcjklsdjcnsdl4", state: true, finishDate: Date(timeIntervalSinceNow: 1000000))
//    print(note3.finishDate ?? "kek")
//    print(note4.finishDate ?? "kek")
    return [note1, note2, note3, note4]
}
