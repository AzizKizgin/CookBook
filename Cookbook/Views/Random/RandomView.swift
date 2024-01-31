//
//  RandomView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 26.01.2024.
//

import SwiftUI

struct RandomView: View {
    @StateObject var randomVM = RandomViewModel()
    var body: some View {
        VStack{
            if randomVM.isLoading {
                LoadingIndicator()
            }
            else if let meal = randomVM.meal {
                MealDetail(meal: meal)
                    .refreshable {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                            randomVM.refresh()
                        }
                    }
            }
        }
        .onAppear{
            randomVM.getRandomMeal()
        }
    }
}

#Preview {
    NavigationStack{
        RandomView()
    }
}
