//
//  HomeView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 21.01.2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var homeVM = HomeViewModel()
    let columns = [
        GridItem(.adaptive(minimum: 300))
    ]
    var body: some View {
        NavigationStack{
            if homeVM.isLoading {
                LoadingIndicator()
            } else {
                List {
                    LazyVGrid(columns: columns,spacing: 50){
                        ForEach(homeVM.categories, id: \.id) { category in
                            FlipCard(url: category.image)
                                .showButton()
                                .buttonTitle("See Meals")
                                .onButtonPress {
                                    goCategoryPage(for: category)
                                }
                                .backText(category.description)
                                .title(category.name)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderless)
                .scrollContentBackground(.hidden)
                .navigationDestination(item: $homeVM.category){ item in
                    FilteredMealsView(filterBy: item, type: .category)
                }
            }
        }
        .navigationTitle("Categories")
        .onAppear{
            homeVM.getCategories()
        }
    }
}

extension HomeView {
    private func goCategoryPage(for category: Category) {
        self.homeVM.category = category.name
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
