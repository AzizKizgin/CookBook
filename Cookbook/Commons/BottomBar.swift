//
//  BottomBar.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 29.01.2024.
//

import SwiftUI

struct BottomBar: View {
    @Binding var selectedTab: Int
    var body: some View {
        ZStack{
            HStack{
                ForEach((TabbedItems.allCases), id: \.self){ item in
                    let isActive = selectedTab == item.rawValue
                    Button{
                        selectedTab = item.rawValue
                    } label: {
                        BarItem(imageName: item.getIcon(isActive: isActive), isActive: isActive)
                    }
                    
                }
            }
            .padding(6)
        }
        .frame(height: 70)
        .background(.orange)
        .cornerRadius(35)
        .padding(.horizontal, 10)
        .animation(.easeInOut, value: selectedTab)
    }
}

private struct BarItem: View {
    let imageName: String
    let isActive: Bool
    var body: some View {
        HStack(spacing: 10){
            Spacer()
            VStack{
                Image(systemName: imageName)
                    .font(isActive ? .title : .title3)
            }
            .foregroundColor(isActive ? .white : .black)
            Spacer()
        }
        .cornerRadius(30)
    }
}

#Preview {
    struct BottomBarPreview: View {
        @State var selectedTab: Int = 0
        
        var body: some View {
            BottomBar(selectedTab: $selectedTab)
        }
    }
    return BottomBarPreview()
}
