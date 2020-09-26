//
//  ScheduleCell.swift
//  Hyosang Ahn HI Coding Challenge
//
//  Created by Hyosang Ahn on 9/18/20.
//  Copyright © 2020 Hyosang Ahn. All rights reserved.
//

import Foundation
import UIKit

class ScheduleCell: UITableViewCell {
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var typeEmoji: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
    }
}
