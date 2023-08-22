//
//  GameTurn.swift
//  ios-refactoring-rock-paper-scissors
//
//  Created by Kobe, kyungmin on 2023/08/20.
//

enum GameTurn {
    case user
    case computer
    case unknown
    
    var description: String {
        switch self {
        case .user:
            return "사용자"
        case .computer:
            return "컴퓨터"
        case .unknown:
            return "알 수 없음"
        }
    }
}
