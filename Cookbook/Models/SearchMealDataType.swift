//
//  SearchMealDataType.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 23.01.2024.
//

import Foundation
// This model is for searching meal by its fullname, first letter and id.
struct SearchMealDataType: Decodable {
    let meals: [Meal]
}
