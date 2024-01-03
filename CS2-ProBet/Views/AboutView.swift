//
//  AboutView.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 18/12/2023.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()

                Text("🔫 CS2-ProBet 🔫")
                    .font(.title)
                Image("Icon")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.5)
                    .shadow(color: .white, radius: 2)

                Spacer()

                LazyVStack {
                    Text("This is CS2-ProBet, a game where you can bet on professional Counter-Strike2 teams ranking.\n\nEach week, you can select at most 3 teams, and when the world ranking updates, you win points whether your selected teams goes up or scoreboard.\n\nThe update usally takes place on Monday evening. Throughout the week, you are free to change your picks as much as you want.")
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    AboutView()
}
