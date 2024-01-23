//
//  FilterResultDataType.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 23.01.2024.
//

import Foundation
// This model is for fetching meals with filtering by category, ingredient and area.
struct FilterResultDataType: Decodable {
    let meals: [FilterResult]
}
