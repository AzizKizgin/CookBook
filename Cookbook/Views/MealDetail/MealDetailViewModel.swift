//
//  MealDetailViewModel.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 26.01.2024.
//

import Foundation
class MealDetailViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var meal: Meal?
    @Published var ingredient: String?
    
    func getMeal(id: String) {
        self.isLoading = true
        MealMenager.shared.getMealById(id: id) { [weak self] result in
            DispatchQueue.main.async {
                if let result {
                    self?.meal = result
                    self?.isLoading = false
                }
            }
        }
    }
    
    func goIngredientDetail(ingredient: String){
        self.ingredient = ingredient
    }
}
