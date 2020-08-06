//
//  NewNoteViewController.swift
//  planner
//
//  Created by Сергей Петров on 06.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import Foundation
import UIKit

let animDuration = 0.5

class NewNoteViewController: UIViewController {
    
    @IBOutlet weak var noteDiscription: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var note: Note?
    var noteIdentifier = "NewNoteCell"
    
    
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        
        let text = self.noteDiscription.text ?? ""
        if self.datePicker.isHidden == false {
            Storage.shared.saveNote(note: Note(objectID: nil, description: text, state: false))
        }
        else {
            let date = self.datePicker.date
            Storage.shared.saveNote(note: Note(objectID: nil, description: text, state: false, finishDate: date))
        }
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func finishDateButtonClicked(_ sender: UIButton) {
        UIView.animate(withDuration: animDuration, animations: { self.datePicker.isHidden.toggle() })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.datePicker.date = Date() // set current date to picker
    }
}
