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
            let date = note.value(forKey: "date") as? Date
            notes.append(Note(objectID: note.objectID, description: text, state: state, date: date))
        }
        
        return notes
    }
    
    func saveNote(note: Note) {

        let entity = NSEntityDescription.entity(forEntityName: "NoteData", in: mainContext)!
        let newNote = NSManagedObject(entity: entity, insertInto: mainContext)
        
        newNote.setValue(note.description, forKey: "text")
        newNote.setValue(note.date, forKey: "date")
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
    
    func updateNote(updatedNote: Note) {
        do {
            let note = mainContext.object(with: updatedNote.objectID!)
            note.setValue(updatedNote.description, forKey: "text")
            note.setValue(updatedNote.state, forKey: "state")
            note.setValue(updatedNote.date, forKey: "date")
            
            try mainContext.save()
        } catch let error as NSError {
            print("Update note error!")
            print("Error: \(error)")
            print("Error description: \(error.description)")
            print("Error userInfo: \(error.userInfo)")
        }
    }
    
    func deleteNote(deletedNote: Note) {
        do {
            let note = mainContext.object(with: deletedNote.objectID!)
            mainContext.delete(note)
            try mainContext.save()
        } catch let error as NSError {
            print("Delete note error!")
            print("Error: \(error)")
            print("Error description: \(error.description)")
            print("Error userInfo: \(error.userInfo)")
        }
    }
}
