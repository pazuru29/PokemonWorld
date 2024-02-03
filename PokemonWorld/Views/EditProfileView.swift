//
//  EditProfileView.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 30.01.2024.
//

import SwiftUI

struct EditProfileView: View, KeyboardReadable {
    @Environment(\.presentationMode) var presentationMode
    @AppConfiguration(\.isMail) var isMail
    @AppConfiguration(\.name) var name
    
    @State private var isKeyboardVisible = false
    @State var currentUsername: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Group {
                Image(isMail ? "mailAvatar" : "femailAvatar")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
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
            }
            
            Spacer()
            
            if !isKeyboardVisible {
                Button("Save") {
                    name = currentUsername
                    presentationMode.wrappedValue.dismiss()
                }
                .padding(.bottom, 24)
                .buttonStyle(MainButtonStyle())
                .disabled(currentUsername.isEmpty)
            }
        }
        .onReceive(keyboardPublisher, perform: { newIsKeyboardVisible in
            print("Is keyboard visible? ", newIsKeyboardVisible)
            isKeyboardVisible = newIsKeyboardVisible
        })
        .padding(.horizontal, 20)
        .navigationTitle("Name of charecter")
        .onAppear {
            currentUsername = name
        }
    }
}

#Preview {
    EditProfileView()
}
