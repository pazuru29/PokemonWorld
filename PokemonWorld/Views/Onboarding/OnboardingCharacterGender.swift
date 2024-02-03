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
                ForEach(Gender.allCases, id: \.self) { item in
                    CategoryCard<Gender>(value: item, title: item.rawValue, isSelected: gender == item) { value in
                        gender = value
                    }
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            NavigationLink("Next") {
                OnboardingName(gender: gender ?? .mail)
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
