//
//  SettingsView.swift
//  Cookbook
//
//  Created by Aziz Kızgın on 26.01.2024.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDark") private var isDark: Bool = false
    var body: some View {
        List{
            Toggle(isOn: $isDark, label: {
                Text("Dark Mode")
            })
        }
    }
}

#Preview {
    SettingsView()
}
