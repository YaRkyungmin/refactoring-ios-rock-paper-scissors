//
//  RockScissorsPaperManger.swift
//  ios-refactoring-rock-paper-scissors
//
//  Created by Kobe, kyungmin on 2023/08/20.
//

struct RockScissorsPaperManager {
    let gameLogic: HandShapeGameLogic
    
    func playRockScissorsPaper(_ gameInformation: GameInformation) -> GameInformation {
        var gameResult = gameInformation
        
        while gameResult == (.unknown, .execute) {
            let userInformation = gameLogic.receiveValidUserInputValue(ruleMessage: NameSpace.ruleMessage)
            
            switch userInformation.gameStatus {
            case .execute:
                gameResult = applyRockScissorsPaperRule(userHandShape: userInformation.handShape,
                                                        computerHandShape: gameLogic.randomComputerHandShape())
            case .exit:
                gameResult = (.unknown, .exit)
            }
        }
        
        return gameResult
    }
    
    private func applyRockScissorsPaperRule(userHandShape: HandShape, computerHandShape: HandShape) -> GameInformation {
        do {
            let result = try gameLogic.compareWithRockSicissorsPaperRule(userHandShape, computerHandShape)
            
            try show(result)
            
            switch result {
            case .win:
                return (.user, .execute)
            case .lose:
                return (.computer, .execute)
            case .draw:
                return (.unknown, .execute)
            case .unowned:
                return (.unknown, .exit)
            }
        } catch {
            print(GameError.invalid)
            
            return (.unknown, .exit)
        }
    }
    
    private func show(_ gameResult: GameResult) throws {
        switch gameResult {
        case .win:
            print(NameSpace.win)
        case .lose:
            print(NameSpace.lose)
        case .draw:
            print(NameSpace.draw)
        case .unowned:
            throw GameError.invalid
        }
    }
}

extension RockScissorsPaperManager {
    private enum NameSpace {
        static let ruleMessage = "가위(1), 바위(2), 보(3)! <종료 : 0> :"
        static let draw = "비겼습니다!"
        static let lose = "졌습니다!"
        static let win = "이겼습니다!"
    }
}
