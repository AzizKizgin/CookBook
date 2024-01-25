//
//  CategoryMealsViewModel.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 24.01.2024.
//

import Foundation
class CategoryMealsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var meals: [FilterResult] = []
    @Published var mealId: String?
    @Published var filteredMeals: [FilterResult] = []
    @Published var searchText: String = ""
    
    func getCategoryMeals(category: String) {
        self.isLoading = true
        MealMenager.shared.getMealByCategory(category: category) { [weak self] meals in
            DispatchQueue.main.async {
                if let meals {
                    self?.meals = meals
                    self?.filteredMeals = meals
                    self?.isLoading = false
                }
            }
        }
    }
    
    func searchMeals(){
        filteredMeals = searchText.isEmpty ? meals : meals.filter { $0.mealName.contains(searchText) }
    }
}
