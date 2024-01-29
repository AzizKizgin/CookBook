//
//  RandomViewModel.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 26.01.2024.
//

import Foundation
class RandomViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var meal: Meal?
    
    func getRandomMeal() {
        self.isLoading = true
        MealMenager.shared.getRandomMeal() { [weak self] meal in
            DispatchQueue.main.async {
                if let meal {
                    self?.meal = meal
                    self?.isLoading = false
                }
            }
        }
    }
}
