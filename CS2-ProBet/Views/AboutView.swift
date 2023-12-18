//
//  AboutView.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 18/12/2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack() {
            Text("🔫 CS2-ProBet 🔫")
            Text("This is CS2-ProBet, a game where you can bet on professional Counter-Strike2 teams ranking.")
            Text("Each week, you can select at most 3 teams, and when the world ranking updates, you win points whether your selected teams goes up or scoreboard.")
            Text("The update usally takes place on Monday evening.")
            Text("Throughout the week, you are free to change your picks as much as you want.")
        }
        .padding()
        .multilineTextAlignment(.center)
    }
}

#Preview {
    AboutView()
}
