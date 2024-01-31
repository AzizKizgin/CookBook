//
//  TabbedItems.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 29.01.2024.
//

import Foundation
enum TabbedItems: Int, CaseIterable{
    case home = 0
    case search
    case random
    case settings
    
    func getIcon(isActive: Bool) -> String {
        switch self {
        case .home:
            return isActive ? "house.fill": "house"
        case .search:
            return "magnifyingglass"
        case .random:
            return isActive ? "dice.fill": "dice"
        case .settings:
            return "gear"
        }
    }
    
    func getLabel() -> String {
        switch self {
        case .home:
            return "Home"
        case .search:
            return "Search"
        case .random:
            return "Random"
        case .settings:
            return "Settings"
        }
    }
}
