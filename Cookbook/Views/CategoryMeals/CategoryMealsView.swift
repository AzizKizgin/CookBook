//
//  CategoryMealsView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 24.01.2024.
//

import SwiftUI

struct CategoryMealsView: View {
    let category: String
    @StateObject var categoryMealsVM = CategoryMealsViewModel()
    let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    var body: some View {
        NavigationStack{
            if categoryMealsVM.isLoading {
                LoadingIndicator()
            } else {
                ScrollView {
                    LazyVGrid(columns: columns,spacing: 50){
                        ForEach(categoryMealsVM.meals, id: \.id) { meal in
                            FlipCard(url: meal.image)
                                .onButtonPress {
                                    goMealRecipe(for: meal)
                                }
                                .title(meal.mealName)
                                .onCardPress {
                                    goMealRecipe(for: meal)
                                }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .navigationDestination(item: $categoryMealsVM.mealId){ item in
                    Text(item)
                }
            }
        }
        .onAppear{
            categoryMealsVM.getCategoryMeals(category: category)
        }
    }
}

extension CategoryMealsView {
    private func goMealRecipe(for meal: FilterResult) {
        self.categoryMealsVM.mealId = meal.id
    }
}

#Preview {
    CategoryMealsView(category: "Beef")
}
