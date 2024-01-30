//
//  MealDetail.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 29.01.2024.
//

import SwiftUI

struct MealDetail: View {
    @State private var selectedIngredient: String?
    let meal: Meal
    var body: some View {
        ScrollView{
            AsyncImage(url: URL(string: meal.image ?? "")){ image in
                image
                    .resizable()
                    .scaledToFill()
                    .overlay(alignment: .bottom){
                        Text(meal.name)
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
                VStack{
                    VStack(spacing: 20){
                        VStack(spacing: 10){
                            Text("Instructions")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity,alignment: .leading)
                            Text(meal.instructions ?? "")
                        }
                        VStack(spacing: 10){
                            Text("Ingredient")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .frame(maxWidth: .infinity,alignment: .leading)
                            ForEach(meal.getIngredients(),id:\.id){ ingredient in
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
                            ForEach(meal.getIngredients(),id:\.id){ ingredient in
                                FlipCard(url: Endpoints.getIngredientImage(name: ingredient.name.uppercased()))
                                    .width(100)
                                    .height(100)
                                    .onCardPress {
                                        selectedIngredient = ingredient.name
                                    }
                            }
                        }
                        .padding()
                    }
                }
                .padding(.bottom, 100)
            }
        }
        .navigationDestination(item: $selectedIngredient){ ingredient in
            FilteredMealsView(filterBy: ingredient, type: .ingredient)
        }
    }
}

#Preview {
    NavigationStack{
        MealDetail(meal: fakeMeal)
    }
}
