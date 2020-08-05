//
//  Storage.swift
//  planner
//
//  Created by Сергей Петров on 05.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Storage {
    
    static var shared = Storage()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "planner")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
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
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    
    private init() {
        
    }
}

extension Storage {
    
    func loadNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NoteData")
        var dryNotes: [NSManagedObject] = []
        
        do {
            dryNotes = try mainContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Load note error!")
            print("Error: \(error)")
            print("Error description: \(error.description)")
            print("Error userInfo: \(error.userInfo)")
            return []
        }
        
        var notes: [Note] = []
        for note in dryNotes {
            let text = note.value(forKey: "text") as! String
            let state = note.value(forKey: "state") as! Bool
            let finishDate = note.value(forKey: "finishDate") as? Date
            notes.append(Note(description: text, state: state, finishDate: finishDate))
        }
        
        return notes
    }
    
    func saveNote(note: Note) {

        let entity = NSEntityDescription.entity(forEntityName: "NoteData", in: mainContext)!
        let newNote = NSManagedObject(entity: entity, insertInto: mainContext)
        
        newNote.setValue(note.description, forKey: "text")
        newNote.setValue(note.finishDate, forKey: "finishDate")
        newNote.setValue(note.state, forKey: "state")
        
        do {
            try mainContext.save()
        } catch let error as NSError {
            print("Save note error!")
            print("Error: \(error)")
            print("Error description: \(error.description)")
            print("Error userInfo: \(error.userInfo)")
        }
    }
}
