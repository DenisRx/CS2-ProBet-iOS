//
//  ContentView.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 19/12/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        TabView {
            Group {
                HomeView(viewModel: viewModel)
                    .tabItem {
                        Image(systemName: "trophy.fill")
                        Text("Ranking")
                    }
                AboutView()
                    .tabItem {
                        Image(systemName: "info.circle")
                        Text("About")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
