//
//  ViewController.swift
//  Hyosang Ahn HI Coding Challenge
//
//  Created by Hyosang Ahn on 9/10/20.
//  Copyright © 2020 Hyosang Ahn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var 📋 = [Event]()
    let cellReuseIdentifier = "cell"
    @IBOutlet weak var ScheduleTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // JSON data parsing
        let urlString = "https://api.hackillinois.org/event/"

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
        
        // Implementing data into table
        ScheduleTableView.delegate = self
        ScheduleTableView.dataSource = self
        setDatePicker()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 📋.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScheduleCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ScheduleCell
//
        let event = self.📋[indexPath.row]
        cell.eventName.text = event.name
        
        if event.locations.count != 0 {
            for location in event.locations {
                cell.eventLocation.text! += location
                if location != event.locations[event.locations.count - 1] {
                    cell.eventLocation.text! += ", "
                }
            }
        }
        
        cell.eventDescription.text = event.description
        
        switch event.eventType {
        case "WORKSHOP":
            cell.typeEmoji.text = "✏️"
        case "MINIEVENT":
            cell.typeEmoji.text = "🤝"
        case "SPEAKER":
            cell.typeEmoji.text = "🎤"
        case "MEAL":
            cell.typeEmoji.text = "🍽"
        default:
            cell.typeEmoji.text = "❤️"
        }
        
        return cell
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        tableViewHeightConstraint.constant = ScheduleTableView.contentSize.height
    }
    
    // Reference: https://www.hackingwithswift.com/read/7/3/parsing-json-using-the-codable-protocol
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonEvents = try? decoder.decode(Events.self, from: json) {
            📋 = jsonEvents.events
//            tableView.reloadData()
            dump(📋)
        } else {
            print("error")
        }
    }
    
    func setDatePicker() {
//        datePicker.minimumDate = NSDate(timeIntervalSince1970: TimeInterval(📋[0].startTime)) as Date
//        datePicker.maximumDate = NSDate(timeIntervalSince1970: TimeInterval(📋[📋.count - 1].startTime)) as Date
    }
}



//class ScheduleTableViewController: UITableViewController {
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! ScheduleCell
//
//        let event = 📋[indexPath.row]
//        cell.eventName?.text = event.name
////        cell.eventLocation?.text = event.locations
//        cell.eventDescription?.text = event.description
//        return cell
//    }
//}
