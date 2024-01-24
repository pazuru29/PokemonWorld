//
//  Main.swift
//  PokemonWorld
//
//  Created by Yaroslav Chlek on 23.01.2024.
//

import SwiftUI

struct MainView: View {
    
    @State private var activeTab: Tab = .search
    
    @State private var allTabs: [AnimatedTab] = Tab.allCases.compactMap { tab -> AnimatedTab? in
        return .init(tab: tab)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                // MARK: Search
                NavigationStack {
                    SearchTab()
                }
                .setUpTab(.search)
                
                // MARK: Comparison
                NavigationStack {
                    ComparisonTab()
                }
                .setUpTab(.comparison)
                
                // MARK: Collection
                NavigationStack {
                    CollectionTab()
                }
                .setUpTab(.collection)
                
                // MARK: Settings
                NavigationStack {
                    SettingsTab()
                }
                .setUpTab(.settings)
            }
            CustomTabBar()
        }
    }
    
    @ViewBuilder
    func CustomTabBar() -> some View {
        HStack {
            ForEach($allTabs) { $animatedTab in
                let tab = animatedTab.tab
                
                VStack(spacing: 4) {
                    Image(systemName: activeTab == tab ? tab.activeIcon : tab.rawValue)
                        .font(.title2)
                        .contentTransition(.symbolEffect(.replace.downUp.byLayer))
                    
                    Text(tab.title)
                        .font(.caption)
                        .textScale(.secondary)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(activeTab == tab ? Color.appText : Color.appTextSecondary.opacity(0.5))
                }
                .frame(maxWidth: .infinity)
                .foregroundStyle(activeTab == tab ? Color.appPrimaryTapped : Color.appPrimary.opacity(0.5))
                .padding(.top, 15)
                .padding(.bottom, 10)
                .contentShape(.rect)
                .onTapGesture {
                    activeTab = tab
                }
            }
        }
        .frame(height: 72)
        .background(.bar)
    }
}

#Preview {
    MainView()
}
