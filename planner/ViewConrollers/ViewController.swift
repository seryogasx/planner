//
//  ViewController.swift
//  planner
//
//  Created by Сергей Петров on 02.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var notesTable: UITableView!
    
    var notesData: [Note] = []
    
    @IBAction func NewNoteButtonClicked(_ sender: UIBarButtonItem) {
        Storage.shared.saveNote(note: Note(description: "kek", state: true))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notesData = Storage.shared.loadNotes()
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
        
        let cell: NoteCell = self.notesTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NoteCell
        
        cell.note = note
        cell.descriptionTextField.text = note.description
        cell.setButtonImage()
        
        guard note.finishDate != nil else {
            cell.finishDateLabel.isHidden = true
            return cell
        }
        
        cell.finishDateLabel.text = note.finishDate?.noteDate
        return cell
    }
}
