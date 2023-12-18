//
//  HomeView.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 08/12/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            Text("Score: \(viewModel.score)")
                .padding()
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(viewModel.orange)
            LeaderboardView(viewModel: HomeViewModel())
        }.background(viewModel.blue)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
