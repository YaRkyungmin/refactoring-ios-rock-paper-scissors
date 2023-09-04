//
//  HandshapeGameLogic.swift
//  ios-refactoring-rock-paper-scissors
//
//  Created by kyungmin on 2023/09/07.
//

protocol HandShapeGameLogic {
    func randomComputerHandShape() -> HandShape
    func compareWithRockSicissorsPaperRule(_ lhs: HandShape, _ rhs: HandShape) throws -> GameResult
    func receiveValidUserInputValue(ruleMessage: String) -> HandShapeInformation
}
