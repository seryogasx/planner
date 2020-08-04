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
            return cell
        }
        cell.finishDateLabel.text = finishDate.description
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notesTable.delegate = self
        notesTable.dataSource = self
    }


}


func getNotesData() -> [Note] {
    return [Note(description: "desc1", state: false), Note(description: "desc2", state: false), Note(description: "desc3", state: false)]
}
