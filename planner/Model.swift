//
//  Model.swift
//  planner
//
//  Created by Сергей Петров on 02.08.2020.
//  Copyright © 2020 SergioPetrovx. All rights reserved.
//

import Foundation

struct Note {
    let description: String
    let state: Bool
    let startDate: Date? = nil
    let finishDate: Date? = nil
}
