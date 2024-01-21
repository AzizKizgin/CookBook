//
//  Endpoints.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 18.01.2024.
//

import Foundation

enum Endpoints {
    
    // MARK: - Base Url
    private static let baseURL = URL(string: "https://www.themealdb.com/api/json/v1/1")!
    
    // MARK: - Helper function to construct URLs
    private static func makeURL(path: String, queryItem: URLQueryItem) -> URL {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: true)!
        components.queryItems = [queryItem]
        return components.url!
    }
    
    // MARK: - All Categories
    static let categories = baseURL.appendingPathComponent("categories.php")
    
    // MARK: - Meals Based On Category
    static func getMealsByCategory(category: String) -> URL {
        makeURL(path: "filter.php", queryItem: URLQueryItem(name: "c", value: category))
    }
    
    // MARK: - Search Meal By Name
    static func searchMealByName(name: String) -> URL {
        makeURL(path: "search.php", queryItem: URLQueryItem(name: "s", value: name))
    }
    
    // MARK: - Get Meal By Id
    static func getMealById(id: String) -> URL {
        makeURL(path: "lookup.php", queryItem: URLQueryItem(name: "i", value: id))
    }
    
    // MARK: - Get Random Meal
    static let getRandomMeal = baseURL.appendingPathComponent("random.php")
    
    // MARK: - Get Meal By Ingredient
    static func getMealsByIngredient(ingredient: String) -> URL {
        makeURL(path: "filter.php", queryItem: URLQueryItem(name: "i", value: ingredient))
    }
    
    // MARK: - Get Meals By Area
    static func getMealsByArea(area: String) -> URL {
        makeURL(path: "filter.php", queryItem: URLQueryItem(name: "a", value: area))
    }
    
    // MARK: - Get Ingredient Image
    static func getIngredientImage(name: String, smallImage: Bool = false) -> URL {
        let size = smallImage ? "-Small": ""
        return URL(string: "www.themealdb.com/images/ingredients/\(name+size).png")!
    }
}
