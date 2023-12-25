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
    let correctPredictionPoints = 15
    let wrongPredictionPoints = -5
    
    init() {
        score = UserDefaults.standard.integer(forKey: "score")
        loadLeaderboard()
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

    func editSelection() {
        isEditing = true
    }
    
    func confirmSelection() {
        isEditing = false
        saveLeaderboard()
    }
    
    private func getSelectedTeams() -> [Team] {
        return leaderboard.filter { $0.isSelected }
    }
    
    private func saveLeaderboard() {
        do {
            let data = try JSONEncoder().encode(leaderboard)
            let url = getDocumentsDirectory().appendingPathComponent("leaderboard.json")
            try data.write(to: url)
        } catch {
            print("Unable to save leaderboard: \(error)")
        }
    }

    private func loadLeaderboard() {
        leaderboard = getSavedLeaderboard() ?? []
    }
    
    private func getSavedLeaderboard() -> [Team]? {
        let url = getDocumentsDirectory().appendingPathComponent("leaderboard.json")
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Team].self, from: data)
        } catch {
            print("Unable to get leaderboard: \(error)")
            return nil
        }
    }
    
    private func updateLeaderboard() {
        Task {
            let fetchedLeaderboard = await NetworkManager().fetchLeaderboard()
            
            DispatchQueue.main.async {
                if fetchedLeaderboard == nil {
                    // TODO: Provide feedback on error
                    return
                }
                
                if !self.compareLeaderboard(with: fetchedLeaderboard!) {
                    self.updateScore(with: fetchedLeaderboard!)
                    self.leaderboard = fetchedLeaderboard!
                    self.saveLeaderboard()
                }
            }
        }
    }

    private func compareLeaderboard(with data: [Team]) -> Bool {
        return data == getSavedLeaderboard()
    }
    
    private func updateScore(with data: [Team]) {
        getSavedLeaderboard()?.filter{ $0.isSelected }.forEach { team in
            if !data.map({$0.id}).contains(team.id) {
                score += (data.count - team.place + 1) * wrongPredictionPoints
            } else {
                let teamChange = data.first(where: { $0.id == team.id })!.change
                score +=  teamChange >= 0
                    ? teamChange * correctPredictionPoints
                    : abs(teamChange) * wrongPredictionPoints
            }
        }
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
