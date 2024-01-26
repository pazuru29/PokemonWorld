//
//  OnboardingName.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct OnboardingName: View, KeyboardReadable {
    @AppConfiguration(\.isFirstTime) var isFirstTime
    @AppConfiguration(\.isMail) var isMail
    @AppConfiguration(\.name) var name
    
    var gender: Gender
    
    @State private var isKeyboardVisible = false
    @State var currentUsername: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("What's your name, young catcher?")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Image(gender == .mail ? "mailAvatar" : "femailAvatar")
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .addBorder(.appPrimaryTapped, width: 2, cornerRadius: 16)
                .shadow(radius: 4, x: 0, y: 2)
                .padding(.top, 24)
            
            TextField("Username", text: $currentUsername)
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .padding(.horizontal, 16)
                .presentationCornerRadius(25)
                .background(.white)
                .addBorder(.appPrimaryTapped, cornerRadius: 12)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.top, 36)
            
            Spacer()
            
            if !isKeyboardVisible {
                Button("Save") {
                    isFirstTime = false
                    isMail = gender == .mail
                    name = currentUsername
                }
                .buttonStyle(MainButtonStyle())
                .disabled(currentUsername.isEmpty)
            }
            
            Spacer()
        }
        .onReceive(keyboardPublisher, perform: { newIsKeyboardVisible in
            print("Is keyboard visible? ", newIsKeyboardVisible)
            isKeyboardVisible = newIsKeyboardVisible
        })
        .padding(.horizontal, 20)
        .navigationTitle("Name of charecter")
    }
}

#Preview {
    OnboardingName(gender: .mail)
}
