//
//  NoteListViewController.swift
//  planner
//
//  Created by Сергей Петров on 02.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import UIKit
import CoreData


class NoteListViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var notesTable: UITableView!
    
    var notesData: [Note] = []
    
    @IBAction func NewNoteButtonClicked(_ sender: UIBarButtonItem) {
//        Storage.shared.saveNote(note: Note(objectID: nil, description: "kek", state: true, finishDate: Date(timeIntervalSinceNow: 10000)))
    }

    @IBAction func noteDetailButtonClicked(_ sender: Any) {
        print(self.notesTable.indexPathForSelectedRow?.row ?? "no cell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.notesData = Storage.shared.loadNotes()
        self.notesTable.reloadData()
    }
}


extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        cell.index = indexPath
        cell.table = self.notesTable
        cell.setButtonImage()
        
        guard note.finishDate != nil else {
            cell.finishDateLabel.text = "No deadline"
            return cell
        }
        
        cell.finishDateLabel.text = note.finishDate?.noteDate
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            Storage.shared.deleteNote(deletedNote: notesData[indexPath.row])
            
            self.notesTable.beginUpdates()
            self.notesTable.deleteRows(at: [ indexPath ], with: .automatic)
            notesData.remove(at: indexPath.row)
            self.notesTable.endUpdates()
        }
    }
}

extension NoteListViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "NoteDetailSegue" {
            let index = self.notesTable.indexPathForSelectedRow!.row
            print(self.notesData[index])
            if let noteDetailVC = segue.destination as? NoteDetailViewController {
                noteDetailVC.note = self.notesData[index]
            }
            print(self.notesTable.indexPathForSelectedRow?.row ?? "no selected row!")
        }
    }
}
