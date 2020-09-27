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
//    @IBOutlet weak var eventLocation: UILabel!
    @IBOutlet weak var typeEmoji: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    @IBOutlet weak var eventTime: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        if traitCollection.userInterfaceStyle == .light {
            contentView.backgroundColor = UIColor(white: 1, alpha: 0.5)
        } else {
            contentView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        }
        
    }
}
