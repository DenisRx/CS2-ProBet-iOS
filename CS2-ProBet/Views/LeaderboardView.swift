//
//  LeaderboardView.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 09/12/2023.
//

import SwiftUI

struct LeaderboardView: View {
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        List(viewModel.leaderboard) { team in
            HStack {
                VStack {
                    Text("#\(team.place)")
                }
                VStack(alignment: .trailing) {
                    Text(formatRankChange(team.change)).foregroundColor(determineRankChangeColor(team.change))
                }
                VStack {
                    Text(team.name)
                }

                Spacer()
                
                Image(systemName: team.isSelected ? "checkmark.circle.fill" : "circle")
                    .foregroundColor(team.isSelected ? Color(UIColor.systemBlue) : .gray)
                    .onTapGesture {
                        viewModel.toggleSelectedTeam(team)
                    }
            }.font(.title3)
        }
    }
}

func formatRankChange(_ value: Int) -> String {
    if value > 0 {
        return "+\(value)"
    } else {
        return String(value)
    }
}

func determineRankChangeColor(_ value: Int) -> Color {
    if value > 0 {
        return .green
    } else if value < 0 {
        return .red
    } else {
        return .gray
    }
}

struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView(viewModel: HomeViewModel())
    }
}
