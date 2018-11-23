//
//  User.swift
//  brcount
//
//  Created by Daniel Aragon Ore on 11/21/18.
//  Copyright © 2018 UPC. All rights reserved.
//

import Foundation
struct OperatorResponse: Codable{
    var data: Operator?
    var code: String?
    var message: String?
}
struct Operator: Codable {
    var id: String?
    var name: String?
    var last_name: String?
    var email: String?
    var username: String?
    var password: String?
    var organization_id: String?
    var role: String?
    var gender: String?
    var photo: String?
}

