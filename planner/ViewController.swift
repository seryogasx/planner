//
//  ViewController.swift
//  planner
//
//  Created by Сергей Петров on 02.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var view2Button: UIBarButtonItem!
    @IBOutlet weak var view1Button: UIBarButtonItem!
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var notesTable: UITableView!
    
    let cellReuseIdentifier = "NoteCell"
    var notesData: [Note] = getNotesData()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notesData.count
    }
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: NoteCell = self.notesTable.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! NoteCell
//        cell.descLabel?.text = self.notesData[indexPath.row].description
        cell.textLabel?.text = self.notesData[indexPath.row].description
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notesTable.register(NoteCell.self, forCellReuseIdentifier: cellReuseIdentifier)
//        notesTable.delegate = self
//        notesTable.dataSource = self
        // Do any additional setup after loading the view.
    }


}


func getNotesData() -> [Note] {
    return [Note(description: "desc1", state: false), Note(description: "desc2", state: false), Note(description: "desc3", state: false)]
}
