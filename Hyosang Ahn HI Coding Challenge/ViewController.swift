//
//  ViewController.swift
//  Hyosang Ahn HI Coding Challenge
//
//  Created by Hyosang Ahn on 9/10/20.
//  Copyright © 2020 Hyosang Ahn. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
                      , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    
    
    var 📋 = [Event]()
    let cellReuseIdentifier = "cell"
    var selectedDate: String?
    var dateList = [String]()
    
    @IBOutlet weak var ScheduleTableView: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var dateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Untitled_Artwork.png")!)
        
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
        createPickerView()
        dismissPickerView()
        
        ScheduleTableView.layoutIfNeeded()
        tableViewHeightConstraint.constant = ScheduleTableView.contentSize.height
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 📋.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ScheduleCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! ScheduleCell

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
            if event.name.range(of: "ceremony", options: .caseInsensitive) != nil {
                cell.typeEmoji.text = "🎉"
            } else if event.name.range(of: "begins", options: .caseInsensitive) != nil
                        || event.name.range(of: "ends", options: .caseInsensitive) != nil {
                cell.typeEmoji.text = "🏁"
            } else if event.name.range(of: "challenge", options: .caseInsensitive) != nil {
                cell.typeEmoji.text = "🏆"
            } else {
                cell.typeEmoji.text = "📅"
            }
        }
        
        return cell
    }
   
    // Reference: https://www.hackingwithswift.com/read/7/3/parsing-json-using-the-codable-protocol
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonEvents = try? decoder.decode(Events.self, from: json) {
            📋 = [Event]()
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            if selectedDate == nil {
                selectedDate = formatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(jsonEvents.events[0].startTime)) as Date)
            }
            for event in jsonEvents.events {
                if formatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(event.startTime)) as Date) == selectedDate {
                    📋.append(event)
                }
            }
            dump(📋)
        } else {
            print("error")
        }
    }
    
    func parseWhole(json: Data) -> [Event]? {
        let decoder = JSONDecoder()
        
        if let jsonEvents = try? decoder.decode(Events.self, from: json) {
            let temp = jsonEvents.events
            dump(temp)
            return temp
        } else {
            print("error")
            return nil
        }
    }
    
    func setDatePicker() {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        let urlString = "https://api.hackillinois.org/event/"
        var temp📋 = [Event]()

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                temp📋 = parseWhole(json: data)!
            }
        }
        temp📋.sort(by: {$0.startTime < $1.startTime})
        for event in temp📋 {
            if !dateList.contains(formatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(event.startTime)) as Date)) {
                dateList.append(formatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(event.startTime)) as Date))
            }
        }
    }
    
//     Reference: https://medium.com/@raj.amsarajm93/create-dropdown-using-uipickerview-4471e5c7d898
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dateList[row] // dropdown item
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDate = dateList[row] // selected item
        dateTextField.text = selectedDate
        let urlString = "https://api.hackillinois.org/event/"

        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                ScheduleTableView.reloadData()
                ScheduleTableView.layoutIfNeeded()
                tableViewHeightConstraint.constant = ScheduleTableView.contentSize.height
            }
        }
    }
    
    @IBAction func dateButtonTapped(_ sender: Any) {
        createPickerView()
    }
    func createPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        dateTextField.inputView = pickerView
        if dateTextField.text!.isEmpty {
            dateTextField.text = dateList[0]
        }
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        dateTextField.inputAccessoryView = toolBar
    }
    
    @objc func action() {
          view.endEditing(true)
    }
}
