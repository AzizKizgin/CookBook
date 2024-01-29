//
//  MealDetailView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 26.01.2024.
//

import SwiftUI

struct MealDetailView: View {
    let mealId: String
    @StateObject var mealDetailVM = MealDetailViewModel()
    var body: some View {
        VStack{
            if mealDetailVM.isLoading {
                LoadingIndicator()
            }
            else if let meal = mealDetailVM.meal{
                MealDetail(meal: meal)
            }
        }
        .onAppear{
            mealDetailVM.getMeal(id: mealId)
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    NavigationStack{
        MealDetailView(mealId: "52776")
    }
}
