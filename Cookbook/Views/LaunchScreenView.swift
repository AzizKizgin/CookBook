//
//  LaunchScreenView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 1.02.2024.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        VStack{
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.accent)
    }
}

#Preview {
    LaunchScreenView()
}
