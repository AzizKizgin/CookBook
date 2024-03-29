//
//  CategoryManager.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 21.01.2024.
//

import Foundation

class CategoryManager {
    
    static let shared = CategoryManager()
    
    private init() {}
    
    func fetchData(completion: @escaping ([Category]?) -> Void) {
        DataManager.shared.fetchData(for: Endpoints.categories) { (result: Result<CategoryDataType,Error>) in
            switch result {
            case .success(let data):
                completion(data.categories)
            case .failure:
                completion(nil)
            }
        }
    }
}
