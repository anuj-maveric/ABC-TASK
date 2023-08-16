//
//  Model.swift
//  Sample POC
//
//  Created by Anuj Kumar on 16/08/23.
//

import Foundation

struct Message: Identifiable, Codable {
    let id: Int
    var user: String
    var text: String
    
}
