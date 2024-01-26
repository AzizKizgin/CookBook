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
            else{
                ScrollView{
                    AsyncImage(url: URL(string: mealDetailVM.meal?.image ?? "")){ image in
                        image
                            .resizable()
                            .scaledToFill()
                            .overlay(alignment: .bottom){
                                Text(mealDetailVM.meal?.name ?? "")
                                    .font(.title)
                                    .frame(maxWidth: .infinity)
                                    .foregroundStyle(.white)
                                    .padding(5)
                                    .background(.black.opacity(0.4))
                                    .shadow(radius: 10)
                            }
                    } placeholder: {
                        ProgressView()
                            .controlSize(.large)
                    }
                    .frame(maxWidth: .infinity)
                    VStack(spacing: 20){
                        Group{
                            VStack(spacing: 10){
                                Text("Instructions")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                Text(mealDetailVM.meal?.instructions ?? "")
                            }
                            VStack(spacing: 10){
                                Text("Ingredient")
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity,alignment: .leading)
                                ForEach(mealDetailVM.meal?.getIngredients() ?? [],id:\.id){ ingredient in
                                    HStack(spacing: 10){
                                        Image(systemName: "checkmark.circle.fill")
                                            .foregroundStyle(.orange)
                                        Text(ingredient.quantity)
                                            .bold()
                                            .foregroundStyle(.orange)
                                        Text(ingredient.name.capitalized)
                                        
                                    }
                                    .textInputAutocapitalization(.words)
                                    .frame(maxWidth: .infinity,alignment:.leading)
                                }
                            }
                        }
                        .padding(.horizontal)
                        ScrollView(.horizontal){
                            HStack(spacing:20){
                                ForEach(mealDetailVM.meal?.getIngredients() ?? [],id:\.id){ ingredient in
                                    FlipCard(url: Endpoints.getIngredientImage(name: ingredient.name.uppercased()))
                                        .width(100)
                                        .height(100)
                                        .onCardPress {
                                            mealDetailVM.goIngredientDetail(ingredient: ingredient.name)
                                        }
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .onAppear{
            mealDetailVM.getMeal(id: mealId)
        }
        .navigationDestination(item: $mealDetailVM.ingredient){ ingredient in
            FilteredMealsView(filterBy: ingredient, type: .ingredient)
        }
        .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    NavigationStack{
        MealDetailView(mealId: "52776")
    }
}
