//
//  GameLogic.swift
//  ios-refactoring-rock-paper-scissors
//
//  Created by kyungmin on 2023/08/23.
//

struct GameLogic: HandShapeGameLogic {
    func randomComputerHandShape() -> HandShape {
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
    
    func compareWithRockSicissorsPaperRule(_ lhs: HandShape, _ rhs: HandShape) throws -> GameResult {
        switch (lhs, rhs) {
        case (.scissors, .scissors), (.rock, .rock), (.paper, .paper):
            return .draw
        case (.scissors, .rock), (.rock, .paper), (.paper, .scissors):
            return.lose
        case (.scissors, .paper), (.rock, .scissors), (.paper, .rock):
            return .win
        default:
            throw GameError.invalid
        }
    }
    
    func receiveValidUserInputValue(ruleMessage: String) -> HandShapeInformation {
        let isWrongInputValue = true
        
        while isWrongInputValue {
            print(ruleMessage, terminator: NameSpace.whiteSpace)

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

extension GameLogic {
    private enum NameSpace {
        static let invalidInputMessage = "잘못된 입력입니다. 다시 시도해주세요."
        static let whiteSpace = " "
    }
}
