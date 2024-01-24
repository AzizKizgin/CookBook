//
//  HomeView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 21.01.2024.
//

import SwiftUI

struct HomeView: View {
    @State private var category: String?
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
                            FlipCard(url: category.image, showButton: true, buttonTitle: "See Meals", onButtonPress: {goCategoryPage(for: category)}, backText: category.description, title: category.name)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderless)
                .scrollContentBackground(.hidden)
                .navigationDestination(item: $category){ item in
                    Text(item)
                }
            }
            
        }
        .onAppear{
            homeVM.getCategories()
        }
    }
}

extension HomeView {
    private func goCategoryPage(for category: Category) {
        self.category = category.name
    }
}

#Preview {
    NavigationStack{
        HomeView()
    }
}
