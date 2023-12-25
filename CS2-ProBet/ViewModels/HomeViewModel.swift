//
//  HomeViewModel.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 08/12/2023.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published private(set) var score: Int {
        didSet {
            UserDefaults.standard.set(score, forKey: "score")
        }
    }

    @Published private(set) var isEditing: Bool = false
    
    @Published private(set) var leaderboard: [Team] = []

    let maxTeamSelection = 3
    
    init() {
        score = UserDefaults.standard.integer(forKey: "score")
        updateLeaderboard()
    }

    func toggleSelectedTeam(_ team: Team) {
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
        saveLeaderboard()
    }
    
    func saveLeaderboard() {
        do {
            let data = try JSONEncoder().encode(leaderboard)
            let url = getDocumentsDirectory().appendingPathComponent("leaderboard.json")
            try data.write(to: url)
        } catch {
            print("Unable to save leaderboard: \(error)")
        }
    }

    func loadLeaderboard() {
        let url = getDocumentsDirectory().appendingPathComponent("leaderboard.json")
        do {
            let data = try Data(contentsOf: url)
            leaderboard = try JSONDecoder().decode([Team].self, from: data)
        } catch {
            print("Unable to load leaderboard: \(error)")
        }
    }
    
    func updateLeaderboard() {
        Task {
            let fetchedLeaderboard = await NetworkManager().fetchLeaderboard()
            DispatchQueue.main.async {
                self.leaderboard = fetchedLeaderboard ?? []
            }
        }
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
