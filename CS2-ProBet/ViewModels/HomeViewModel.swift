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
    
    @Published private(set) var scoreEvolution: Int {
        didSet {
            UserDefaults.standard.set(scoreEvolution, forKey: "scoreEvolution")
        }
    }

    @Published private(set) var isEditing: Bool = false
    
    @Published private(set) var leaderboard: [Team] = []
    
    @Published var fetchError: String?

    let maxTeamSelection = 3
    let correctPredictionPoints = 15
    let wrongPredictionPoints = -5
    
    init() {
        score = UserDefaults.standard.integer(forKey: "score")
        scoreEvolution = UserDefaults.standard.integer(forKey: "scoreEvolution")
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
    
    func updateLeaderboard() {
        Task {
            let result = await NetworkManager().fetchLeaderboard()
            
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedLeaderboard):
                    if !self.compareLeaderboard(with: fetchedLeaderboard) {
                        self.updateScore(with: fetchedLeaderboard)
                        self.leaderboard = fetchedLeaderboard
                        self.saveLeaderboard()
                    }
                case .failure(let error):
                    self.fetchError = error.localizedDescription
                }
            }
        }
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
            return nil
        }
    }

    private func compareLeaderboard(with data: [Team]) -> Bool {
        return data == getSavedLeaderboard()
    }
    
    private func updateScore(with data: [Team]) {
        scoreEvolution = 0
        getSavedLeaderboard()?.filter{ $0.isSelected }.forEach { team in
            if !data.map({$0.id}).contains(team.id) {
                scoreEvolution += (data.count - team.place + 1) * wrongPredictionPoints
            } else {
                let teamChange = data.first(where: { $0.id == team.id })!.change
                scoreEvolution += teamChange >= 0
                    ? teamChange * correctPredictionPoints
                    : abs(teamChange) * wrongPredictionPoints
            }
            score += scoreEvolution
        }
    }

    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
