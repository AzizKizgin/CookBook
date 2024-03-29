//
//  ContentView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 18.01.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var selectedTab = 0
    @AppStorage("isDark") private var isDark: Bool = false
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom){
                TabView(selection: $selectedTab) {
                    HomeView()
                        .tag(0)
                        .toolbar(.hidden, for: .tabBar)
            
                    SearchView()
                        .tag(1)
                        .toolbar(.hidden, for: .tabBar)
                    
                    RandomView()
                        .tag(2)
                        .toolbar(.hidden, for: .tabBar)
                    
                    SettingsView()
                        .tag(3)
                        .toolbar(.hidden, for: .tabBar)
                }
                BottomBar(selectedTab: $selectedTab)
            }
        }
        .preferredColorScheme(isDark ? .dark: .light)
    }
}

#Preview {
    NavigationStack{
        ContentView()
    }
        
}
