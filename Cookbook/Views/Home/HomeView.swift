//
//  HomeView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 21.01.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(spacing: 50){
                    ForEach(0...10, id: \.self) { item in
                        FlipCard()
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    HomeView()
}
