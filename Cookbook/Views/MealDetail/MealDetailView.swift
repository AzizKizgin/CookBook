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
                ScrollView(.horizontal){
                    HStack(spacing:20){
                        ForEach(mealDetailVM.meal?.getIngredients() ?? [],id:\.id){ ingredient in
                            FlipCard(url: "https://www.themealdb.com/images/ingredients/\(ingredient.name.uppercased()).png")
                                .width(100)
                                .height(100)
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal)
        }
        .onAppear{
            mealDetailVM.getMeal(id: mealId)
        }
        .ignoresSafeArea(edges: .top)
        
    }
}

#Preview {
    MealDetailView(mealId: "52776")
}
