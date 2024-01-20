//
//  Category.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 19.01.2024.
//

import Foundation

struct Category: Decodable {
    let id: String
    let name: String
    let image: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idCategory"
        case name = "strCategory"
        case image = "strCategoryThumb"
        case description = "strCategoryDescription"
    }
}
