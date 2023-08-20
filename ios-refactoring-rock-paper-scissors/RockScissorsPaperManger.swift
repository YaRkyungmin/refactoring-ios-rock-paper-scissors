//
//  RockScissorsPaperManger.swift
//  ios-refactoring-rock-paper-scissors
//
//  Created by Kobe, kyungmin on 2023/08/20.
//

typealias HandShapeInformation = (handShape: HandShape, gameStatus: GameStatus)

enum RockScissorsPaperManger {
    static func playRockScissorsPaper() -> GameInfomation {
        var gameResult = GameStatus.execute
        
        while gameResult == .execute {
            let handSahpeInformation = inputValidUserValue()
            
            switch handSahpeInformation.gameStatus {
            case .execute:
                let computerHandShape = randomComputerHandShape()
                // 컴퓨터 랜덤 핸드쉐이프 받아서 사용자 핸드쉐이프랑 비교해준뒤 비겼는지 이겼는지 졌는지 로직이 들어감
                return (.unknown, .exit)
            case .exit:
                return (.unknown, .exit)
            }
            
        }
        
        return (.unknown, .exit)
    }
    
    private static func compareHandShape(user: HandShape, computer: HandShape) throws -> GameResult {
        switch (user, computer) {
        case (.scissors, .scissors), (.rock, .rock), (.paper, .paper):
            return .draw
        case (.scissors, .rock), (.rock, .paper), (.paper, .scissors):
            return .lose
        case (.scissors, .paper), (.rock, .scissors), (.paper, .rock):
            return .win
        default:
            throw GameError.invalid
        }
    }
    
    private static func randomComputerHandShape() -> HandShape {
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
    
    private static func inputValidUserValue() -> HandShapeInformation {
        let isWrongInputValue = true
        
        while isWrongInputValue {
            print("가위(1), 바위(2), 보(3)! <종료 : 0> :", terminator: " ")

            guard let inputValue = readLine(),
                  let inputValue = Int(inputValue),
                  (0...3).contains(inputValue) else {
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
