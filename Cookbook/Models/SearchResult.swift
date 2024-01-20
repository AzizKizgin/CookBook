//
//  SearchResult.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 20.01.2024.
//

import Foundation
struct SearchResult: Codable {
    let meal: String
    let image: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case meal = "strMeal"
        case image = "strMealThumb"
        case id = "idMeal"
    }
}
