//
//  ContentView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 18.01.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Int = 0
    var body: some View {
        TabView(selection: $selection){
            HomeView()
                .tag(0)
                .tabItem {
                    Image(systemName: "house")
                }
            SearchView()
                .tag(1)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            RandomView()
                .tag(2)
                .tabItem {
                    Image(systemName: "dice")
                }
            SavedView()
                .tag(3)
                .tabItem {
                    Image(systemName: "bookmark")
                }
            SettingsView()
                .tag(3)
                .tabItem {
                    Image(systemName: "gear")
                }
        }
    }
}

#Preview {
    ContentView()
}
