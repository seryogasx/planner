//
//  ViewController.swift
//  planner
//
//  Created by Сергей Петров on 02.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import UIKit
import CoreData


func loadFromStorage() -> [NSManagedObject] {
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
        return []
    }
    
    let managedContext =
      appDelegate.persistentContainer.viewContext
    
    //2
    let fetchRequest =
      NSFetchRequest<NSManagedObject>(entityName: "NoteData")
    
    var notes: [NSManagedObject] = []
    do {
        notes = try managedContext.fetch(fetchRequest)
    } catch let error as NSError {
        print("Some problems with load data! -> \(error) ; \(error.userInfo) ; \(error.description)")
    }
    return notes
}


class ViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var notesTable: UITableView!
    
    var notesData: [NSManagedObject] = []
    
    @IBAction func NewNoteButtonClicked(_ sender: UIBarButtonItem) {
        save(newNote: Note(description: "keks", state: true))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notesData = loadFromStorage()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    var cellReuseIdentifier: String {
        return "NoteCell"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notesData.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notesData[indexPath.row]
        let text = note.value(forKey: "text") as! String
        let state = note.value(forKey: "state") as! Bool
        let finishDate = note.value(forKey: "finishDate") as? Date
        
        let cell: NoteCell = self.notesTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NoteCell
        
        cell.descriptionTextField.text = text
        cell.note = Note(description: text, state: state, finishDate: finishDate)
        cell.setButtonImage()
        
        guard finishDate != nil else {
            cell.finishDateLabel.isHidden = true
            return cell
        }
        
        cell.finishDateLabel.text = finishDate?.noteDate
        return cell
    }
}


func save(newNote: Note) {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let entity = NSEntityDescription.entity(forEntityName: "NoteData", in: managedContext)!
    
    let note = NSManagedObject(entity: entity, insertInto: managedContext)
    
    note.setValue(newNote.description, forKey: "text")
    note.setValue(newNote.finishDate, forKey: "finishDate")
    note.setValue(newNote.state, forKey: "state")
    
    do {
        try managedContext.save()
    } catch let error as NSError {
        print("Some problems with save data! -> \(error) ; \(error.userInfo) ; \(error.description)")
    }
}
