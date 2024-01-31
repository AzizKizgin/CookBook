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
    @Published var dataLoaded: Bool = false
    
    func getRandomMeal() {
        if !dataLoaded {
            self.isLoading = true
            MealMenager.shared.getRandomMeal() { [weak self] meal in
                DispatchQueue.main.async {
                    if let meal {
                        self?.meal = meal
                        self?.isLoading = false
                        self?.dataLoaded = true
                    }
                }
            }
        }
    }
    
    func refresh(){
        self.dataLoaded = false
        self.getRandomMeal()
    }
}
