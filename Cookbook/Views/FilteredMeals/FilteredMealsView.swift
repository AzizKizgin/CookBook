//
//  FilteredMealsView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 26.01.2024.
//

import SwiftUI

struct FilteredMealsView: View {
    let filterBy: String
    let type: FilterType
    @StateObject var filteredMealsVM = FilteredMealsViewModel()
    let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    var body: some View {
        VStack{
            if filteredMealsVM.isLoading {
                LoadingIndicator()
            } else {
                ScrollView {
                    SearchBar(text: $filteredMealsVM.searchText)
                    LazyVGrid(columns: columns,spacing: 50){
                        ForEach(filteredMealsVM.filteredMeals, id: \.id) { meal in
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
                .navigationDestination(item: $filteredMealsVM.mealId){ item in
                    MealDetailView(mealId: item)
                }
                .onChange(of: filteredMealsVM.searchText, { _, _ in
                    filteredMealsVM.searchMeals()
                })
            }
        }
        .onAppear{
            filteredMealsVM.getMeals(by: filterBy, type: type)
        }
        .navigationTitle(filterBy)
    }
}

extension FilteredMealsView {
    private func goMealRecipe(for meal: FilterResult) {
        self.filteredMealsVM.mealId = meal.id
    }
}

#Preview {
    NavigationStack{
        FilteredMealsView(filterBy: "Lemon",type: .ingredient)
    }
}
