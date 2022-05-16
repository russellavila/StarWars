//
//  Characters.swift
//  StarWars
//
//  Created by Consultant on 5/16/22.
//

import Foundation

struct Characters: Decodable {
    var results: [Character]
}

struct Character: Decodable {
    var name: String
    var eye_color: String
    var hair_color: String
    var homeworld: String
}

struct Planet: Decodable {
    var name: String
}
