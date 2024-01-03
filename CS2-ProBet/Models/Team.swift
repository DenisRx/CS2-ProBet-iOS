//
//  Team.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 08/12/2023.
//

import Foundation

struct Team: Identifiable, Hashable, Equatable, Codable {
    var points: Int
    var place: Int
    var name: String
    var id: Int
    var change: Int
    var isNew: Bool
    var isSelected: Bool
    
    static func ==(lhs: Team, rhs: Team) -> Bool {
        return lhs.points == rhs.points
            && lhs.place == rhs.place
            && lhs.name == rhs.name
            && lhs.id == rhs.id
            && lhs.change == rhs.change
            && lhs.isNew == rhs.isNew
    }
}
