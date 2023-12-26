//
//  NetworkManager.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 25/12/2023.
//

import Foundation

final class NetworkManager {
    
    let baseUrl = "http://localhost:3000"
    
    func fetchLeaderboard() async -> Result<[Team], Error> {
        let url = URL(string: baseUrl + "/leaderboard")!
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            return .success(decodeTeamResponse(from: data) ?? [])
        } catch {
            print("Error while fetching leaderboard: \(error)")
            return .failure(error)
        }
    }
    
    private func decodeTeamResponse(from jsonData: Data) -> [Team]? {
        do {
            let decodedData = try JSONDecoder().decode([TeamResponse].self, from: jsonData)
            let teams = decodedData.map { decodedData -> Team in
                Team(points: decodedData.points,
                     place: decodedData.place,
                     name: decodedData.team.name,
                     id: decodedData.team.id,
                     change: decodedData.change,
                     isNew: decodedData.isNew,
                     isSelected: false)
            }
            
            return teams
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}
