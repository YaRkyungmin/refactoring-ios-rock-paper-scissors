//
//  GameManager.swift
//  ios-refactoring-rock-paper-scissors
//
//  Created by Kobe, kyungmin on 2023/08/20.
//

typealias GameInformation = (gameTurn: GameTurn, gameStatus: GameStatus)
typealias HandShapeInformation = (handShape: HandShape, gameStatus: GameStatus)

struct GameManager {
    func playGame() {
        var gameInformation: GameInformation = (.unknown, .execute)
        
        gameInformation = RockScissorsPaper(gameInformation)
        gameInformation = MuckJjiBbaManager(gameInformation)
        
        show(gameInformation)
    }
    
    private func RockScissorsPaper(_ gameInformation: GameInformation) -> GameInformation {
        let rockScissorsPaperManager = RockScissorsPaperManager()
        
        return rockScissorsPaperManager.playRockScissorsPaper(gameInformation)
    }
    
    private func MuckJjiBbaManager(_ gameInformation: GameInformation) -> GameInformation {
        let mukJjiBbaManager = MukJjiBbaManager()
        
        return mukJjiBbaManager.playMukJjiBba(gameInformation)
    }
    
    private func show(_ gameInformation: GameInformation) {
        switch gameInformation.gameTurn {
        case .unknown:
            print(NameSpace.endMessage)
        default:
            print(String(format: NameSpace.resultMessage, gameInformation.gameTurn.description))
        }
    }
}

extension GameManager {
    private enum NameSpace {
        static let endMessage = "게임 종료"
        static let resultMessage = "%@의 승리!"
    }
}
