//
//  HomeViewModel.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 21.01.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var categories: [Category] = []
    
    func getCategories() {
        self.isLoading = true
        CategoryManager.shared.fetchData { [weak self] categories in
            DispatchQueue.main.async {
                if let categories {
                    self?.categories = categories
                    self?.isLoading = false
                }
            }
        }
    }
}
