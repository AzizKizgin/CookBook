//
//  BottomBar.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 29.01.2024.
//

import SwiftUI

struct BottomBar: View {
    @Binding var selectedTab: Int
    @State private var showInfo: Bool = false
    @State private var infoText: String = ""
    var body: some View {
        ZStack{
            HStack{
                ForEach((TabbedItems.allCases), id: \.self){ item in
                    let isActive = selectedTab == item.rawValue
                    Button{
                        selectedTab = item.rawValue
                        showInfo = true
                        infoText = TabbedItems(rawValue: selectedTab)!.getLabel()
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
        .overlay(alignment: .bottom) {
            if showInfo {
                VStack{
                    Text(infoText)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
                .background(.accent)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(height: 180)
            }
        }
        .onChange(of: showInfo) { _, _ in
            if showInfo {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                    showInfo.toggle()
                    infoText = ""
                }
            }
        }
        .animation(.easeInOut, value: selectedTab)
        .animation(.easeInOut, value: showInfo)
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
