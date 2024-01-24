//
//  CategoryCard.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct CategoryCard<T>: View {
    var value: T
    var title: String
    var isSelected: Bool
    var onPressed: (T) -> Void
    
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .foregroundStyle(isSelected ? .appText : .appTextSecondary.opacity(0.7))
            .font(.title2.bold())
            .background(isSelected ? .appPrimaryTapped : .appBackground)
            .addBorder(isSelected ? .appPrimaryTapped : .appTextSecondary.opacity(0.7), width: 1, cornerRadius: 25)
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .onTapGesture {
                onPressed(value)
            }
    }
}

#Preview {
    Group{
        CategoryCard<String>(value: "", title: "Mail", isSelected: true) { value in
        }
        CategoryCard<String>(value: "", title: "Femail", isSelected: false) { value in
        }
    }
}
