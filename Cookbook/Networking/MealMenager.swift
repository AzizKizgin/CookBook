//
//  MealMenager.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 23.01.2024.
//

import Foundation
class MealMenager{
    static let shared = MealMenager()
    private let dataManager = DataManager.shared
    private init() {}
    
    func getMealByCategory(category: String, completion: @escaping ([FilterResult]?) -> Void) {
        dataManager.fetchData(for: Endpoints.getMealsByCategory(category: category)) { (result: Result<FilterResultDataType,Error>) in
            switch result {
            case .success(let data):
                completion(data.meals)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getMealById(id: String, completion: @escaping (Meal?) -> Void) {
        dataManager.fetchData(for: Endpoints.getMealById(id: id)) { (result: Result<SearchMealDataType,Error>) in
            switch result {
            case .success(let data):
                print(data)
                completion(data.meals.first)
            case .failure:
                completion(nil)
            }
        }
    }
}
