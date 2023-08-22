//
//  MukJjiBbaManager.swift
//  ios-refactoring-rock-paper-scissors
//
//  Created by Kobe, kyungmin on 2023/08/20.
//

struct MukJjiBbaManager {
    func playMukJjiBba(_ gameInformation: GameInformation) -> GameInformation {
        var gameResult = gameInformation
        
        while gameResult.gameStatus == .execute {
            let handSahpeInformation = GameLogic.receiveValidUserInputValue(ruleMessage: String(format: NameSpace.ruleMessage, gameResult.gameTurn.description))
            
            switch handSahpeInformation.gameStatus {
            case .execute:
                gameResult = applyMukJjiBbaRule(gameTurn: gameResult.gameTurn, userHandShape: handSahpeInformation.handShape,
                                                computerHandShape: GameLogic.randomComputerHandShape())
            case .exit:
                gameResult = (.unknown, .exit)
            }
        }
        
        return gameResult
    }
    
    private func applyMukJjiBbaRule(gameTurn: GameTurn, userHandShape: HandShape, computerHandShape: HandShape) -> GameInformation {
        do {
            let result = try GameLogic.compareWithRockSicissorsPaperRule(userHandShape, computerHandShape)
            
            try show(result)
            
            switch result {
            case .win:
                return (.user, .execute)
            case .lose:
                return (.computer, .execute)
            case .draw:
                return (gameTurn, .exit)
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
            print(NameSpace.userTurn)
        case .lose:
            print(NameSpace.computerTurn)
        case .draw:
            return
        case .unowned:
            throw GameError.invalid
        }
    }
}

extension MukJjiBbaManager {
    private enum NameSpace {
        static let ruleMessage = "[%@ 턴] 가위(1), 바위(2), 보(3)! <종료 : 0> :"
        static let userTurn = "사용자의 턴입니다."
        static let computerTurn = "컴퓨터의 턴입니다."
    }
}
