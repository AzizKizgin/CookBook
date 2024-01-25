//
//  FilterResult.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 23.01.2024.
//

import Foundation
struct FilterResult: Decodable {
    let mealName: String
    let image: String
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case image = "strMealThumb"
        case id = "idMeal"
    }
}
