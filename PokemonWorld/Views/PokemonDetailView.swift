//
//  PokemonDetailView.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 24.01.2024.
//

import SwiftUI

struct PokemonDetailView: View {
    @StateObject var pokemonDetailViewModel: PokemonDetailViewModel = PokemonDetailViewModel()
    
    let pokemon: Pokemon
    
    var body: some View {
        GeometryReader { proxy in
            if pokemonDetailViewModel.currentPokemonDetail != nil {
                ScrollView {
                    VStack(spacing: 0) {
                        ZStack {
                            Image("pokemonBg")
                                .resizable()
                                .scaledToFill()
                                .frame(width: proxy.size.width)
                                .clipped()
                            
                            imagePokemon(proxy: proxy)
                        }
                        .frame(height: proxy.size.width)
                        
                        typeView()
                            .padding(.top, 36)
                            .padding(.horizontal, 20)
                        
                        informationView()
                            .padding(.top, 24)
                            .padding(.horizontal, 20)
                        
                        statisticView()
                            .padding(.top, 24)
                            .padding(.horizontal, 20)
                        
                        Spacer()
                    }
                    .padding(.bottom, 16)
                }
            } else {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            
        }
        .navigationTitle(pokemon.name?.uppercased() ?? "Unknown")
        .onAppear {
            //Find detail by pokemon
            pokemonDetailViewModel.getDetailByPokemon(stringUrl: pokemon.url)
        }
        .onDisappear {
            pokemonDetailViewModel.currentPokemonDetail = nil
        }
    }
    
    @ViewBuilder
    func imagePokemon(proxy: GeometryProxy) -> some View {
        let size = proxy.size.width / 2.5
        
        if let image = pokemonDetailViewModel.image {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(height: size)
        } else {
            ProgressView()
                .frame(height: size)
        }
    }
    
    @ViewBuilder
    func typeView() -> some View {
        HStack(spacing: 16) {
            ForEach(pokemonDetailViewModel.currentPokemonDetail?.types ?? [], id: \.self) { type in
                VStack {
                    Image(type.type?.name ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                    
                    Text(type.type?.name?.uppercased() ?? "")
                        .font(.caption)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    @ViewBuilder
    func informationView() -> some View {
        HStack(spacing: 24) {
            if pokemonDetailViewModel.currentPokemonDetail?.baseExperience != nil {
                VStack {
                    Text("EX")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundStyle(.appPrimary)
                    Text("\(pokemonDetailViewModel.currentPokemonDetail?.baseExperience ?? 0)")
                        .font(.body)
                        .fontWeight(.bold)
                }
            }
            
            if pokemonDetailViewModel.currentPokemonDetail?.height != nil {
                VStack {
                    Text("Height")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundStyle(.appPrimary)
                    Text("\(pokemonDetailViewModel.currentPokemonDetail?.height ?? 0) dm")
                        .font(.body)
                        .fontWeight(.bold)
                }
            }
            
            if pokemonDetailViewModel.currentPokemonDetail?.weight != nil {
                VStack {
                    Text("Weight")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundStyle(.appPrimary)
                    Text("\(pokemonDetailViewModel.currentPokemonDetail?.weight ?? 0) hg")
                        .font(.body)
                        .fontWeight(.bold)
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .addBorder(.appPrimary, width: 2, cornerRadius: 16)
    }
    
    @ViewBuilder
    func statisticView() -> some View {
        VStack(spacing: 10) {
            ForEach(pokemonDetailViewModel.currentPokemonDetail?.stats ?? [], id: \.self) { stat in
                HStack {
                    Text(stat.stat?.name?.uppercased() ?? "?")
                        .font(.body)
                        .fontWeight(.bold)
                        .foregroundStyle(.appPrimary)
                    
                    Spacer()
                    
                    Text("\(stat.base_stat ?? 0)")
                        .font(.body)
                        .fontWeight(.bold)
                    
                    if stat.stat?.name != nil {
                        Image("\(stat.stat?.name ?? "")")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                    }
                }
            }
        }
    }
}
