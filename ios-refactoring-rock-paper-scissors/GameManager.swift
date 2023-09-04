//
//  GameManager.swift
//  ios-refactoring-rock-paper-scissors
//
//  Created by Kobe, kyungmin on 2023/08/20.
//

typealias GameInformation = (gameTurn: GameTurn, gameStatus: GameStatus)
typealias HandShapeInformation = (handShape: HandShape, gameStatus: GameStatus)

struct GameManager {
    let gameLogic: HandShapeGameLogic
    
    func playGame() {
        var gameInformation: GameInformation = (.unknown, .execute)
        
        gameInformation = RockScissorsPaper(gameInformation)
        gameInformation = MuckJjiBba(gameInformation)
        
        show(gameInformation)
    }
    
    private func RockScissorsPaper(_ gameInformation: GameInformation) -> GameInformation {
        let rockScissorsPaperManager = RockScissorsPaperManager(gameLogic: gameLogic)
        
        return rockScissorsPaperManager.playRockScissorsPaper(gameInformation)
    }
    
    private func MuckJjiBba(_ gameInformation: GameInformation) -> GameInformation {
        let mukJjiBbaManager = MukJjiBbaManager(gameLogic: gameLogic)
        
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
