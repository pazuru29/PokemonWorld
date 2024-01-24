//
//  OnboardingCharacterGender.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct OnboardingCharacterGender: View {
    @AppConfiguration(\.isFirstTime) var isFirstTime
    @AppConfiguration(\.isMail) var isMail
    
    @State var gender: Gender?
    
    var body: some View {
        VStack(alignment: .leading) {
            Image("onBoarding1")
                .resizable()
                .scaledToFit()
            
            HStack {
                CategoryCard<Gender>(value: .mail, title: Gender.mail.rawValue, isSelected: gender == .mail) { value in
                    gender = value
                }
                CategoryCard<Gender>(value: .femail, title: Gender.femail.rawValue, isSelected: gender == .femail) {value in
                    gender = value
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            Button("Save") {
                isFirstTime = false
                isMail = gender == .mail
            }
            .buttonStyle(MainButtonStyle())
            .padding(.horizontal, 20)
            .disabled(gender == nil)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle("Character gender")
    }
}

#Preview {
    OnboardingCharacterGender()
}
