//
//  SearchViewModel.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 26.01.2024.
//

import Foundation
class SearchViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var meals: [Meal] = []
    @Published var searchText: String = ""
    @Published var selectedMeal: Meal?
    
    func searchMeal() {
        self.isLoading = true
        MealMenager.shared.getMealsByName(name: searchText) { [weak self] meals in
            DispatchQueue.main.async {
                if let meals {
                    self?.meals = meals
                    self?.isLoading = false
                }
            }
        }
    }
}
