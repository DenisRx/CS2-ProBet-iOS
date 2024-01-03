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
                .foregroundColor(Color("BlazeOrange"))
            
            Text("\(formatScoreEvolution(viewModel.scoreEvolution)) points this week")
                .padding(.top, -16)
                .font(.title3)
                .foregroundColor(.white)
            
            LeaderboardView(viewModel: viewModel)
            
            Spacer(minLength: 32)
            
            if !viewModel.isEditing {
                Button(action: viewModel.editSelection) {
                    Text("Edit")
                        .padding()
                        .padding(.horizontal, 56)
                        .background(Color("BlazeOrange"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                Button(action: viewModel.confirmSelection) {
                    Text("Confirm")
                        .padding()
                        .padding(.horizontal, 56)
                        .background(.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            
            Spacer(minLength: 32)
        }
    }
}

func formatScoreEvolution(_ value: Int) -> String {
    if value >= 0 {
        return "+\(value)"
    } else {
        return String(value)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
