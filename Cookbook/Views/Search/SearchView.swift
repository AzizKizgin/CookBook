//
//  SearchView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 26.01.2024.
//

import SwiftUI

struct SearchView: View {
    @StateObject var searchVM = SearchViewModel()
    // I'm using this state for searchbar bug which occurs with tabview
    @State var showList: Bool = false
    var body: some View {
        VStack{
            if showList {
                List{
                    ForEach(searchVM.meals, id: \.id) { meal in
                        NavigationLink(value: meal) {
                            Text(meal.name)
                        }
                    }
                }
            }
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
        .searchable(text: $searchVM.searchText,
               placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: searchVM.searchText) { _, newValue in
            if !newValue.isEmpty {
                searchVM.searchMeal()
            } else {
                searchVM.meals = []
            }
        }
        .onAppear {
            showList = true
        }
        .navigationDestination(for: Meal.self) { meal in
            MealDetailView(mealId: meal.id)
        }
    }
}

#Preview {
    NavigationStack{
        SearchView()
    }
}
