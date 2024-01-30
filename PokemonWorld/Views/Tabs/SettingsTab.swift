//
//  Settings.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct SettingsTab: View {
    @AppConfiguration(\.isMail) var isMail
    @AppConfiguration(\.name) var name
    
    var body: some View {
        ScrollView {
            VStack {
                profile()
                
                Spacer()
            }
            .padding(.vertical, 16)
        }
        .padding(.horizontal, 20)
        .navigationTitle("Settings")
    }
    
    @ViewBuilder
    func profile() -> some View {
        HStack(spacing: 16) {
            Image(isMail ? "mailAvatar" : "femailAvatar")
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(radius: 2)
            
            Text(name)
                .font(.title3)
                .fontWeight(.semibold)
            
            Spacer()
            
            NavigationLink(destination: {
                EditProfileView()
            }, label: {
                Image(systemName: "rectangle.and.pencil.and.ellipsis")
            })
            .buttonStyle(IconButtonStyle())
            .padding(.leading, 8)
        }
        .padding(.all, 8)
        .addBorder(.appPrimary, width: 2, cornerRadius: 25)
    }
}

#Preview {
    SettingsTab()
}
