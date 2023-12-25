//
//  TeamResponse.swift
//  CS2-ProBet
//
//  Created by Denis Roux on 25/12/2023.
//

import Foundation

struct TeamResponse: Decodable {
    var points: Int
    var place: Int
    var team: TeamInfo
    var change: Int
    var isNew: Bool

    struct TeamInfo: Decodable {
        var name: String
        var id: Int
    }
}
