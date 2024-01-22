//
//  FlipCard.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 21.01.2024.
//

import Foundation
import SwiftUI

struct CardBack : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double

    var body: some View {
            VStack(spacing:0){
                AsyncImage(url: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg/300px-Good_Food_Display_-_NCI_Visuals_Online.jpg")){ image in
                    image
                        .resizable()
                        .frame(width: width, height: height - 40)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(UnevenRoundedRectangle(topLeadingRadius: 20, topTrailingRadius: 20))
                } placeholder: {
                    ProgressView()
                        .controlSize(.large)
                        .frame(width: width, height: height - 40)
                }
                Button(action: {}, label: {
                    Text("See Meals")
                        .frame(height: 40)
                        .frame(maxWidth: .infinity)
                })
            }
            .frame(width: width, height: height)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: width, height: height)
                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
            )
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardFront : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double

    var body: some View {
            ScrollView{
                Text("Vegetarianism is the practice of abstaining from the consumption of meat (red meat, poultry, seafood, and the flesh of any other animal), and may also include abstention from by-products of animal slaughter. Vegetarianism may be adopted for various reasons. Many people object to eating meat out of respect for sentient life. Such ethical motivations have been codified under various religious beliefs, as well as animal rights advocacy. Other motivations for vegetarianism are health-related, political, environmental, cultural, aesthetic, economic, or personal preference. There are variations of the diet as well: an ovo-lacto vegetarian diet includes both eggs and dairy products, an ovo-vegetarian diet includes eggs but not dairy products, and a lacto-vegetarian diet includes dairy products but not eggs. A vegan diet excludes all animal products, including eggs and dairy. Some vegans also avoid other animal products such as beeswax, leather or silk clothing, and goose-fat shoe polish.")
                    .padding()
            }
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(width: width, height: height)
                    .shadow(color: .gray, radius: 2, x: 0, y: 0)
            )
            .frame(width: width, height: height)
            .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct FlipCard: View {
    //MARK: Variables
    // if numbers here are 0.00 and 90.0 it causes "ignoring singular matrix" error. so i used this weird numbers
    @State private var backDegree = 0.00001
    @State private var frontDegree = -89.999
    @State private var isFlipped = false

    let width : CGFloat = 300
    let height : CGFloat = 375
    let durationAndDelay : CGFloat = 0.3

    //MARK: Flip Card Function
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 89.999
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0.00001
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -89.999
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0.00001
            }
        }
    }
    
    //MARK: View Body
    var body: some View {
        ZStack {
            CardFront(width: width, height: height, degree: $frontDegree)
            CardBack(width: width, height: height, degree: $backDegree)
        }
        .onTapGesture {
            flipCard()
        }
    }
}

#Preview{
    FlipCard()
}
