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
        
        cell.descriptionTextField.text = self.notesData[indexPath.row].description
        
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
