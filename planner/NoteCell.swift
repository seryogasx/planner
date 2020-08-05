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
        self.note?.state.toggle()
        self.setButtonImage()
    }
    
    func setButtonImage() {
//        let buttonImage = self.note?.state == true ? UIImage(named: "finished_mark") : UIImage(named: "unfinished_mark")
//        self.stateButton.setImage(buttonImage, for: .normal)
    }
    
}
