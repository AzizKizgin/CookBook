//
//  FlipCard.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 21.01.2024.
//

import Foundation
import SwiftUI

private struct CardFront : View {
    @Binding var degree : Double
    let width: CGFloat
    let height: CGFloat
    let imageHeight: CGFloat
    let url: String
    let showButton: Bool
    let buttonTitle: String?
    let onButtonPress: () -> Void
    
    init(degree: Binding<Double>, width: CGFloat, height: CGFloat, url: String, showButton: Bool = false, buttonTitle: String? = nil, onButtonPress: @escaping () -> Void = {}) {
        self._degree = degree
        self.width = width
        self.height = height
        self.url = url
        self.showButton = showButton
        self.buttonTitle = buttonTitle
        self.imageHeight = showButton ? height - 50: height
        self.onButtonPress = onButtonPress
    }

    var body: some View {
            VStack(spacing:0){
                AsyncImage(url: URL(string: url)){ image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .controlSize(.large)
                }
                .frame(width: width, height: imageHeight)
                .clipShape(
                    UnevenRoundedRectangle(
                        topLeadingRadius: 20,
                        bottomLeadingRadius: showButton ? 0 : 20,
                        bottomTrailingRadius: showButton ? 0 : 20,
                        topTrailingRadius: 20
                    )
                )
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
                
                if showButton {
                    Button(action: onButtonPress, label: {
                        Text(buttonTitle ?? "See All")
                            .frame(height: 50)
                            .frame(maxWidth: .infinity)
                    })
                }
            }
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.background)
                    .frame(width: width, height: height)
                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
            )
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

private struct CardBack : View {
    @Binding var degree : Double
    let width : CGFloat
    let height : CGFloat
    let text: String

    var body: some View {
            ScrollView{
                Text(text)
                    .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.background)
                    .frame(width: width, height: height)
                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
            )
            .frame(width: width, height: height)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct FlipCard: View {
    //MARK: Variables
    let url: String
    let showButton: Bool
    let buttonTitle: String?
    let onButtonPress: () -> Void
    let backText: String
    let width : CGFloat
    let height : CGFloat
    let durationAndDelay : CGFloat
    let title: String?
    
    init(url: String, showButton: Bool = false, buttonTitle: String? = nil, onButtonPress: @escaping () -> Void = {}, backText: String = "", width: CGFloat = 300, height: CGFloat = 300, delay: CGFloat = 0.3, title: String? = nil) {
        self.url = url
        self.showButton = showButton
        self.buttonTitle = buttonTitle
        self.onButtonPress = onButtonPress
        self.backText = backText
        self.width = width
        self.height = height
        self.durationAndDelay = delay
        self.title = title
    }
    
    // if numbers here are 0.00 and 90.0 it causes "ignoring singular matrix" error. so i used this weird numbers
    @State private var frontDegree = 0.00001
    @State private var backDegree = -89.999
    @State private var isFlipped = false

    //MARK: Flip Card Function
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = 89.999
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0.00001
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = -89.999
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0.00001
            }
        }
    }
    
    //MARK: View Body
    var body: some View {
        VStack {
            if let title{
                HStack{
                    Text(title)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .frame(alignment: .leading)
                        .foregroundStyle(.accent)
                    Spacer()
                }
                .frame(width: width)
            }
            ZStack {
                CardFront(degree: $frontDegree, width: width, height: height, url: url, showButton: showButton, buttonTitle: buttonTitle, onButtonPress: onButtonPress)
                CardBack(degree: $backDegree, width: width, height: height, text: backText)
            }
            .onTapGesture {
                flipCard()
            }
        }
    }
}

#Preview{
    FlipCard(url: "https://www.themealdb.com/images/category/vegan.png", showButton: true, buttonTitle: "See Meals", onButtonPress: {print("dddd")}, backText: "Veganism is both the practice of abstaining from the use of animal products, particularly in diet, and an associated philosophy that rejects the commodity status of animals.[b] A follower of either the diet or the philosophy is known as a vegan (pronounced /ˈviːɡən/ VEE-gən). Distinctions are sometimes made between several categories of veganism. Dietary vegans (or strict vegetarians) refrain from consuming animal products, not only meat but also eggs, dairy products and other animal-derived substances.[c] The term ethical vegan is often applied to those who not only follow a vegan diet but extend the philosophy into other areas of their lives, and oppose the use of animals for any purpose.[d] Another term is environmental veganism, which refers to the avoidance of animal products on the premise that the harvesting or industrial farming of animals is environmentally damaging and unsustainable.")
}
