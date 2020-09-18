//
//  ViewController.swift
//  Hyosang Ahn HI Coding Challenge
//
//  Created by Hyosang Ahn on 9/10/20.
//  Copyright © 2020 Hyosang Ahn. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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
    }
    
    var 📋 = [Event]()
    
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
}

