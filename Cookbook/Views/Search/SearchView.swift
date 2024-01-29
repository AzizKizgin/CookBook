//
//  SearchView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 26.01.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchVM = SearchViewModel()
    var body: some View {
        VStack{
            SearchBar(text: $searchVM.searchText)
            List{
                ForEach(searchVM.meals, id: \.id) { meal in
                    NavigationLink(value: meal) {
                        Text(meal.name)
                    }
                }
            }
            .safeAreaPadding(.bottom,100)
      
        }
        .overlay{
            if searchVM.meals.isEmpty {
                VStack{
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 150))
                    Text("Search Meal")
                        .font(.system(size: 30))
                        .bold()
                }
                .foregroundStyle(.accent)
            }
        }
        .onChange(of: searchVM.searchText) { _, newValue in
            if !newValue.isEmpty {
                searchVM.searchMeal()
            } else {
                searchVM.meals = []
            }
        }
        .navigationDestination(for: Meal.self) { meal in
            MealDetail(meal: meal)
        }
    }
}

#Preview {
    NavigationStack{
        SearchView()
    }
}
