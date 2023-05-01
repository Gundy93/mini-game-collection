//
//  Player.swift
//  MiniGameCollection
//
//  Created by Gundy on 2023/04/17.
//

enum Player: CustomStringConvertible {

    case user
    case computer

    var description: String {
        switch self {
        case .user:
            return "User"
        case .computer:
            return "Computer"
        }
    }
}
