//
//  Team.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 08/12/2023.
//

import Foundation

struct Team: Identifiable, Hashable, Equatable {
    var points: Int
    var place: Int
    var name: String
    var id: Int
    var change: Int
    var isNew: Bool
    var isSelected: Bool
}
