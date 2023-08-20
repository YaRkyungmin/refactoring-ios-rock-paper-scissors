//
//  GameError.swift
//  ios-refactoring-rock-paper-scissors
//
//  Created by kyungmin on 2023/08/20.
//

import Foundation

enum GameError: LocalizedError {
    case invalid
    
    var errorDescription: String? {
        switch self {
        case .invalid:
            return "invalid error"
        }
    }
}
