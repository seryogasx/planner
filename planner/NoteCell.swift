//
//  NoteCell.swift
//  planner
//
//  Created by Сергей Петров on 03.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import Foundation
import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var finishDateLabel: UILabel!
    @IBOutlet weak var stateButton: UIButton!
    
    var note: Note?
//    var buttonImage = "circle"
    
    
    // UPDATE Data at DB (in future)
    @IBAction func stateButtonClicked(_ sender: Any) {
        let buttonImage = self.note?.state == true ? "circle.fill" : "circle"
        self.stateButton.setBackgroundImage(UIImage(named: buttonImage), for: .disabled)
    }
    
}
