//
//  CountingItem.swift
//  brcount
//
//  Created by Daniel Aragon Ore on 11/23/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
struct CountingItem: Codable{
    var id: String
    var type: String
    var hour: String
    var turn: String
    var lane_id: String
}

struct Lane: Codable{
    var id: String
    var name: String
    var operador_id: String
    var session_id: String
}
