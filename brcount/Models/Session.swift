//
//  Session.swift
//  brcount
//
//  Created by Daniel Aragon Ore on 11/10/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
struct SessionResponse: Codable{
    var sessions: [Session]?
    var code: String?
    var message: String?
}
enum SessionStatus: String{
    case realizado = "rea"
    case pendiente = "pen"
}
struct Session: Codable{
    var id: String?
    var date: String?
    var started_at: String?
    var finished_at: String?
    var avenue_first: String?
    var avenue_second: String?
    var status: String?
    var project_id: String?
}
