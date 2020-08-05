//
//  CoreData.swift
//  planner
//
//  Created by Сергей Петров on 05.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class DataStorage {
    
    var notes: [Note]
    static var shared = DataStorage()
    
    var persistentContainer: NSPersistentContainer {
        let container = NSPersistentContainer(name: "planner")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    private init() {
        notes = getNotesData()
    }
    
    func saveNote() {
//        let managedContext =
    }
    
    func loadAllNotes() -> [Note] {
        return notes
    }
}


func getNotesData() -> [Note] {
    let note1 = Note(description: "desc1", state: true)
    let note2 = Note(description: "desc2", state: false, finishDate: Date())
    let note3 = Note(description: "desc3", state: false, finishDate: Date(timeIntervalSinceNow: -80000))
    let note4 = Note(description: "deschhfjdkdkdfjjfjfd jncjkndjnsjcs dsdmkldsmcklmsdcjklsdjcnsdl4", state: true, finishDate: Date(timeIntervalSinceNow: 1000000))
    return [note1, note2, note3, note4]
}
