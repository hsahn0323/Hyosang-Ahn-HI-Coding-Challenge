//
//  Event.swift
//  Hyosang Ahn HI Coding Challenge
//
//  Created by Hyosang Ahn on 9/16/20.
//  Copyright © 2020 Hyosang Ahn. All rights reserved.
//

import Foundation

struct Event: Codable {
    var id: Int
    var name: String
    var description: String
    var startTime: Int
    var endTime: Int
    var locations: [String]
    var sponsor: String
    var eventType: String
}
