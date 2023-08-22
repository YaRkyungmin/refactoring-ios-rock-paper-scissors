//
//  RockScissorsPaperManger.swift
//  ios-refactoring-rock-paper-scissors
//
//  Created by Kobe, kyungmin on 2023/08/20.
//

typealias HandShapeInformation = (handShape: HandShape, gameStatus: GameStatus)

struct RockScissorsPaperManger {
    func playRockScissorsPaper() -> GameInformation {
        var gameResult: GameInformation = (.unknown, .execute)
        
        while gameResult == (.unknown, .execute) {
            let handSahpeInformation = inputValidUserValue()
            
            switch handSahpeInformation.gameStatus {
            case .execute:
                gameResult = gameInformation(userHandShape: handSahpeInformation.handShape,
                                            computerHandShape: randomComputerHandShape())
            case .exit:
                gameResult = (.unknown, .exit)
            }
        }
        
        return gameResult
    }
    
    private func gameInformation(userHandShape: HandShape, computerHandShape: HandShape) -> GameInformation {
        do {
            let result = try compareHandShape(user: userHandShape, computer: computerHandShape)
            
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
    
    private func compareHandShape(user: HandShape, computer: HandShape) throws -> GameResult {
        switch (user, computer) {
        case (.scissors, .scissors), (.rock, .rock), (.paper, .paper):
            print(NameSpace.draw)
            
            return .draw
        case (.scissors, .rock), (.rock, .paper), (.paper, .scissors):
            print(NameSpace.lose)
            
            return .lose
        case (.scissors, .paper), (.rock, .scissors), (.paper, .rock):
            print(NameSpace.win)
            
            return .win
        default:
            throw GameError.invalid
        }
    }
    
    private func randomComputerHandShape() -> HandShape {
        let randomIntValue = Int.random(in: 1...3)
        
        switch randomIntValue {
        case 1:
            return .scissors
        case 2:
            return .rock
        case 3:
            return .paper
        default:
            return .unowned
        }
    }
    
    private func inputValidUserValue() -> HandShapeInformation {
        let isWrongInputValue = true
        
        while isWrongInputValue {
            print(NameSpace.inputInformationMessage, terminator: NameSpace.whiteSpace)

            guard let inputValue = readLine(),
                  let inputValue = Int(inputValue),
                  (0...3).contains(inputValue) else {
                print(NameSpace.invalidInputMessage)
                
                continue
            }

            switch inputValue {
            case 1:
                return (.scissors, .execute)
            case 2:
                return (.rock, .execute)
            case 3:
                return (.paper, .execute)
            default:
                return (.unowned, .exit)
            }
        }
    }
}

extension RockScissorsPaperManger {
    private enum NameSpace {
        static let inputInformationMessage = "가위(1), 바위(2), 보(3)! <종료 : 0> :"
        static let invalidInputMessage = "잘못된 입력입니다. 다시 시도해주세요."
        static let draw = "비겼습니다!"
        static let lose = "졌습니다!"
        static let win = "이겼습니다!"
        static let whiteSpace = " "
    }
}
