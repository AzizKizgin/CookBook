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
    
    func getMealsByCategory(category: String, completion: @escaping ([FilterResult]?) -> Void) {
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
                completion(data.meals.first)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getMealsByIngredient(ingredient: String, completion: @escaping ([FilterResult]?) -> Void) {
        dataManager.fetchData(for: Endpoints.getMealsByIngredient(ingredient: ingredient)){ (result: Result<FilterResultDataType,Error>) in
            switch result {
            case .success(let data):
                completion(data.meals)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getMealsByArea(area: String, completion: @escaping ([FilterResult]?) -> Void) {
        dataManager.fetchData(for: Endpoints.getMealsByArea(area: area)){ (result: Result<FilterResultDataType,Error>) in
            switch result {
            case .success(let data):
                completion(data.meals)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getMealsByName(name: String, completion: @escaping ([Meal]?) -> Void) {
        dataManager.fetchData(for: Endpoints.searchMealByName(name: name)) { (result: Result<SearchMealDataType,Error>) in
            switch result {
            case .success(let data):
                completion(data.meals)
            case .failure:
                completion(nil)
            }
        }
    }
    
    func getRandomMeal(completion: @escaping (Meal?) -> Void){
        dataManager.fetchData(for: Endpoints.getRandomMeal) { (result: Result<SearchMealDataType,Error>) in
            switch result {
            case .success(let data):
                completion(data.meals.first)
            case .failure:
                completion(nil)
            }
        }
    }
}
