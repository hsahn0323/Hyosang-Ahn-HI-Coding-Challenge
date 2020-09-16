//
//  ViewController.swift
//  Hyosang Ahn HI Coding Challenge
//
//  Created by Hyosang Ahn on 9/10/20.
//  Copyright © 2020 Hyosang Ahn. All rights reserved.
//

import UIKit

var eventList = [Event]()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // JSON data parsing
        let urlString = "https://api.hackillinois.org/event/"
//        let parser = JSONParser()
        
//        parser.loadFromURL(fromURLString: urlString) {
//            (result) in
//            switch result {
//            case .success(let data):
//                parser.parse(jsonData: data)
//            case .failure(let error):
//                print(error)
//            }
//        }
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
            }
        }
    }
    
    
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonEvents = try? decoder.decode(Events.self, from: json) {
            eventList = jsonEvents.events
//            tableView.reloadData()
            print(eventList)
        } else {
            print("error")
        }
    }

    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "defaultvalue")
        } catch let myJSONError {
            print(myJSONError)
        }

    }
}

