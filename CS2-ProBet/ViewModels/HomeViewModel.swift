//
//  HomeViewModel.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 08/12/2023.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var score = 0
    @Published var isEditing: Bool = false
    
    @Published var leaderboard: [Team] = [
        Team(points: 985, place: 1, name: "FaZe", id: 6667, change: 0, isNew: false, isSelected: true),
        Team(points: 776, place: 2, name: "Vitality", id: 9565, change: 0, isNew: false, isSelected: false),
        Team(points: 600, place: 3, name: "MOUZ", id: 4494, change: 0, isNew: false, isSelected: false),
        Team(points: 551, place: 4, name: "ENCE", id: 4869, change: 0, isNew: false, isSelected: false),
        Team(points: 496, place: 5, name: "G2", id: 5995, change: 1, isNew: false, isSelected: false),
        Team(points: 475, place: 6, name: "Complexity", id: 5005, change: -1, isNew: false, isSelected: false),
        Team(points: 439, place: 7, name: "Monte", id: 11811, change: 0, isNew: false, isSelected: false),
        Team(points: 365, place: 8, name: "Natus Vincere", id: 4608, change: 0, isNew: false, isSelected: false),
        Team(points: 340, place: 9, name: "FURIA", id: 8297, change: 7, isNew: false, isSelected: false),
        Team(points: 317, place: 10, name: "Cloud9", id: 5752, change: -1, isNew: false, isSelected: false),
        Team(points: 255, place: 11, name: "Apeks", id: 9806, change: 8, isNew: false, isSelected: false),
        Team(points: 249, place: 12, name: "Virtus.pro", id: 5378, change: -2, isNew: false, isSelected: false),
        Team(points: 209, place: 13, name: "GamerLegion", id: 9928, change: -1, isNew: false, isSelected: false),
        Team(points: 204, place: 14, name: "Eternal Fire", id: 11251, change: -3, isNew: false, isSelected: false),
        Team(points: 155, place: 15, name: "Astralis", id: 6665, change: -2, isNew: false, isSelected: false),
        Team(points: 154, place: 16, name: "BetBoom", id: 12394, change: -2, isNew: false, isSelected: false),
        Team(points: 148, place: 17, name: "BIG", id: 7532, change: -2, isNew: false, isSelected: false),
        Team(points: 122, place: 18, name: "Spirit", id: 7020, change: -1, isNew: false, isSelected: false),
        Team(points: 122, place: 19, name: "MIBR", id: 9215, change: -1, isNew: false, isSelected: false),
        Team(points: 100, place: 20, name: "HAVU", id: 7865, change: 107, isNew: false, isSelected: false),
        Team(points: 100, place: 21, name: "9 Pandas", id: 11883, change: 0, isNew: false, isSelected: false),
        Team(points: 86, place: 22, name: "Heroic", id: 7175, change: 1, isNew: false, isSelected: false),
        Team(points: 82, place: 23, name: "Movistar Riders", id: 7718, change: -3, isNew: false, isSelected: false),
        Team(points: 81, place: 24, name: "Ninjas in Pyjamas", id: 4411, change: -2, isNew: false, isSelected: false),
        Team(points: 61, place: 25, name: "Aurora", id: 11861, change: 0, isNew: false, isSelected: false),
        Team(points: 60, place: 26, name: "Lynn Vision", id: 8840, change: -2, isNew: false, isSelected: false),
        Team(points: 53, place: 27, name: "9INE", id: 10278, change: -1, isNew: false, isSelected: false),
        Team(points: 52, place: 28, name: "9z", id: 9996, change: -1, isNew: false, isSelected: false),
        Team(points: 50, place: 29, name: "3DMAX", id: 4914, change: -1, isNew: false, isSelected: false),
        Team(points: 49, place: 30, name: "TYLOO", id: 4863, change: -1, isNew: false, isSelected: false),
    ]
    
    let maxTeamSelection = 3
        
    func toggleSelectedTeam(_ team: Team) {
        if isEditing == false {
            return
        }

        if let index = leaderboard.firstIndex(of: team) {
            if leaderboard[index].isSelected == false && getSelectedTeams().count == maxTeamSelection {
                return
            }
            leaderboard[index].isSelected.toggle()
        }
    }
    
    private func getSelectedTeams() -> [Team] {
        return leaderboard.filter { $0.isSelected }
    }
    
    func editSelection() {
        isEditing = true
    }
    
    func confirmSelection() {
        isEditing = false
        // TODO: Save selection
    }
}
