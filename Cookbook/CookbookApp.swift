//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 18.01.2024.
//

import SwiftUI

@main
struct CookbookApp: App {
    @State private var showLaunch: Bool = true
    var body: some Scene {
        WindowGroup {
            if showLaunch {
                LaunchScreenView()
                    .onAppear{
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                            withAnimation {
                                showLaunch.toggle()
                            }
                        }
                    }
            } else {
                ContentView()
            }
        }
    }
}
