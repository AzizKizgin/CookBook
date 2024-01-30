//
//  FilteredMealsViewModel.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 26.01.2024.
//

import Foundation
class FilteredMealsViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var meals: [FilterResult] = []
    @Published var mealId: String?
    @Published var filteredMeals: [FilterResult] = []
    @Published var searchText: String = ""
    @Published var dataLoaded = false
    
    func getMealsByCategory(category: String) {
        self.isLoading = true
        MealMenager.shared.getMealsByCategory(category: category) { [weak self] meals in
            DispatchQueue.main.async {
                self?.setMeals(meals: meals)
            }
        }
    }
    
    func getMealsByArea(area: String) {
        self.isLoading = true
        MealMenager.shared.getMealsByArea(area: area) { [weak self] meals in
            DispatchQueue.main.async {
                self?.setMeals(meals: meals)
            }
        }
    }
    
    func getMealsByIngredient(ingredient: String) {
        self.isLoading = true
        MealMenager.shared.getMealsByIngredient(ingredient: ingredient) { [weak self] meals in
            DispatchQueue.main.async {
                self?.setMeals(meals: meals)
            }
        }
    }
    
    func searchMeals(){
        filteredMeals = searchText.isEmpty ? meals : meals.filter { $0.mealName.contains(searchText) }
    }
    
    func getMeals(by filterBy: String, type: FilterType) {
        if !dataLoaded {
            switch type {
            case .ingredient:
                getMealsByIngredient(ingredient: filterBy)
            case .area:
                getMealsByArea(area: filterBy)
            case .category:
                getMealsByCategory(category: filterBy)
            }
            dataLoaded = true
        }
    }
    
    private func setMeals(meals: [FilterResult]?){
        if let meals {
            self.meals = meals
            self.filteredMeals = meals
            self.isLoading = false
        }
    }
}
