//
//  ViewController.swift
//  planner
//
//  Created by Сергей Петров on 02.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var view1Button: UIBarButtonItem!
    @IBOutlet weak var view2Button: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var notesTable: UITableView!
    
    let cellReuseIdentifier = "NoteCell"
    var notesData: [Note] = getNotesData()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notesData.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoteCell = self.notesTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NoteCell
        
        cell.descriptionLabel.text = self.notesData[indexPath.row].description
        guard let finishDate = self.notesData[indexPath.row].finishDate else {
            cell.finishDateLabel.isHidden = true
            return cell
        }
        cell.finishDateLabel.text = finishDate.noteDate
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTable.delegate = self
        notesTable.dataSource = self
    }


}


func getNotesData() -> [Note] {
    let note1 = Note(description: "desc1", state: false)
    let note2 = Note(description: "desc2", state: false, finishDate: Date())
    let note3 = Note(description: "desc3", state: false, finishDate: Date(timeIntervalSinceNow: -80000))
    let note4 = Note(description: "deschhfjdkdkdfjjfjfd jncjkndjnsjcs dsdmkldsmcklmsdcjklsdjcnsdl4", state: true, finishDate: Date(timeIntervalSinceNow: 1000000))
    print(note3.finishDate ?? "kek")
    print(note4.finishDate ?? "kek")
    return [note1, note2, note3, note4]
}
