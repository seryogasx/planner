//
//  NoteCell.swift
//  planner
//
//  Created by Сергей Петров on 21.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import UIKit

class NoteCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(color: UIColor) {
        backgroundColor = color
        print("kek")
    }
}
