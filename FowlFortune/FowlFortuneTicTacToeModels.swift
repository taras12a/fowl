import Foundation

enum FowlFortuneTicTacToePlayer: String, CaseIterable {
    case chicken = "🐔"
    case egg = "🥚"
    
    var FowlFortunePlayerName: String {
        switch self {
        case .chicken:
            return "Chicken"
        case .egg:
            return "Egg"
        }
    }
}

enum FowlFortuneTicTacToeGameState {
    case playing
    case chickenWon
    case eggWon
    case draw
}

class FowlFortuneTicTacToeGame {
    private var FowlFortuneBoard: [FowlFortuneTicTacToePlayer?] = Array(repeating: nil, count: 9)
    private var FowlFortuneCurrentPlayer: FowlFortuneTicTacToePlayer = .chicken
    private var FowlFortuneGameState: FowlFortuneTicTacToeGameState = .playing
    
    var FowlFortuneCurrentGameState: FowlFortuneTicTacToeGameState {
        return FowlFortuneGameState
    }
    
    var FowlFortuneCurrentPlayerTurn: FowlFortuneTicTacToePlayer {
        return FowlFortuneCurrentPlayer
    }
    
    var FowlFortuneGameBoard: [FowlFortuneTicTacToePlayer?] {
        return FowlFortuneBoard
    }
    
    func FowlFortuneMakeMove(at index: Int) -> Bool {
        guard index >= 0 && index < 9 && FowlFortuneBoard[index] == nil && FowlFortuneGameState == .playing else {
            return false
        }
        
        FowlFortuneBoard[index] = FowlFortuneCurrentPlayer
        FowlFortuneCheckGameState()
        
        if FowlFortuneGameState == .playing {
            FowlFortuneCurrentPlayer = (FowlFortuneCurrentPlayer == .chicken) ? .egg : .chicken
        }
        
        return true
    }
    
    func FowlFortuneMakeBotMove() -> Int? {
        guard FowlFortuneGameState == .playing && FowlFortuneCurrentPlayer == .egg else {
            return nil
        }
        
        let FowlFortuneBestMove = FowlFortuneFindBestMove()
        if FowlFortuneMakeMove(at: FowlFortuneBestMove) {
            return FowlFortuneBestMove
        }
        
        return nil
    }
    
    private func FowlFortuneFindBestMove() -> Int {
        for i in 0..<9 {
            if FowlFortuneBoard[i] == nil {
                FowlFortuneBoard[i] = .egg
                if FowlFortuneCheckWin(for: .egg) {
                    FowlFortuneBoard[i] = nil
                    return i
                }
                FowlFortuneBoard[i] = nil
            }
        }
        
        for i in 0..<9 {
            if FowlFortuneBoard[i] == nil {
                FowlFortuneBoard[i] = .chicken
                if FowlFortuneCheckWin(for: .chicken) {
                    FowlFortuneBoard[i] = nil
                    return i
                }
                FowlFortuneBoard[i] = nil
            }
        }
        
        let FowlFortuneCenterIndex = 4
        if FowlFortuneBoard[FowlFortuneCenterIndex] == nil {
            return FowlFortuneCenterIndex
        }
        
        let FowlFortuneCornerIndices = [0, 2, 6, 8]
        for index in FowlFortuneCornerIndices {
            if FowlFortuneBoard[index] == nil {
                return index
            }
        }
        
        for i in 0..<9 {
            if FowlFortuneBoard[i] == nil {
                return i
            }
        }
        
        return 0
    }
    
    private func FowlFortuneCheckGameState() {
        if FowlFortuneCheckWin(for: .chicken) {
            FowlFortuneGameState = .chickenWon
        } else if FowlFortuneCheckWin(for: .egg) {
            FowlFortuneGameState = .eggWon
        } else if FowlFortuneBoard.allSatisfy({ $0 != nil }) {
            FowlFortuneGameState = .draw
        }
    }
    
    private func FowlFortuneCheckWin(for player: FowlFortuneTicTacToePlayer) -> Bool {
        let FowlFortuneWinningCombinations = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8],
            [0, 3, 6], [1, 4, 7], [2, 5, 8],
            [0, 4, 8], [2, 4, 6]
        ]
        
        for combination in FowlFortuneWinningCombinations {
            if combination.allSatisfy({ FowlFortuneBoard[$0] == player }) {
                return true
            }
        }
        
        return false
    }
    
    func FowlFortuneResetGame() {
        FowlFortuneBoard = Array(repeating: nil, count: 9)
        FowlFortuneCurrentPlayer = .chicken
        FowlFortuneGameState = .playing
    }
}
