import SwiftUI

class CrimsonDreamsViewModel: ObservableObject {
    @Published var board: [[String]] = Array(repeating: Array(repeating: "crimson1", count: 5), count: 3)
    @Published var isSpinning = false
    @Published var isStopSpininng = false
    
    @Published var winningPositions: [(row: Int, col: Int)] = []
    @Published var activeLinesCount = 10
    @Published var balance: Int = UserDefaults.standard.integer(forKey: "coin")
    @Published var bet: Int = 100
    @Published var win: Int = 0

    let arrayOfImage = ["crimson1","crimson2","crimson3","crimson4","crimson5","crimson6","crimson7","crimson8","crimson9"]
    
    init() {
        for row in 0..<3 {
            for col in 0..<5 {
                self.board[row][col] = self.arrayOfImage.randomElement()!
            }
        }
    }
    
    let allPayLines = [
        [(0,0), (0,1), (0,2), (0,3), (0,4)],
        [(1,0), (1,1), (1,2), (1,3), (1,4)],
        [(2,0), (2,1), (2,2), (2,3), (2,4)],
        [(0,0), (1,1), (2,2), (1,3), (0,4)],
        [(2,0), (1,1), (0,2), (1,3), (2,4)],
        [(1,0), (0,1), (0,2), (0,3), (1,4)],
        [(1,0), (2,1), (2,2), (2,3), (1,4)],
        [(0,0), (0,1), (1,2), (2,3), (2,4)],
        [(2,0), (2,1), (1,2), (0,3), (0,4)],
        [(1,0), (2,1), (1,2), (0,3), (1,4)]
    ]
    
    func spin() {
        isSpinning = true

        balance -= bet
        UserDefaults.standard.set(balance, forKey: "coin")
        isStopSpininng = false

        let timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            for row in 0..<3 {
                for col in 0..<5 {
                    self.board[row][col] = self.arrayOfImage.randomElement()!
                }
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            timer.invalidate()
            self.isSpinning = false
            self.isStopSpininng = true
            self.checkWin()
        }
    }
    
    func checkWin() {
        winningPositions.removeAll()
        var totalWin = 0
        
        let payLines = Array(allPayLines.prefix(activeLinesCount))
        
        lineLoop: for line in payLines {
            let symbolsOnLine = line.map { board[$0.0][$0.1] }
            
            var currentSymbol = symbolsOnLine[0]
            var currentCount = 1
            
            var lineIsWinning = true
            var lineWin = 0
            
            for i in 1..<symbolsOnLine.count {
                if symbolsOnLine[i] == currentSymbol {
                    currentCount += 1
                } else {
                    if let multipliersForSymbol = multipliers[currentSymbol],
                       let minCount = multipliersForSymbol.keys.min() {
                        if currentCount < minCount {
                            lineIsWinning = false
                            break
                        } else if let multiplier = multipliersForSymbol[currentCount] {
                            lineWin += multiplier * bet * activeLinesCount
                        } else {
                            lineIsWinning = false
                            break
                        }
                    } else {
                        lineIsWinning = false
                        break
                    }
                    currentSymbol = symbolsOnLine[i]
                    currentCount = 1
                }
            }
            
            if lineIsWinning {
                if let multipliersForSymbol = multipliers[currentSymbol],
                   let minCount = multipliersForSymbol.keys.min() {
                    if currentCount < minCount {
                        lineIsWinning = false
                    } else if let multiplier = multipliersForSymbol[currentCount], lineIsWinning {
                        lineWin += multiplier * bet
                    } else {
                        lineIsWinning = false
                    }
                } else {
                    lineIsWinning = false
                }
            }
            
            if lineIsWinning {
                winningPositions.append(contentsOf: line)
                totalWin += lineWin
                break lineLoop
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.win = totalWin
        }
    }
    
    let multipliers: [String: [Int: Int]] = [
        "crimson1": [2: 10, 3: 100, 4: 1000, 5: 5000],
        "crimson2": [2: 5, 3: 40, 4: 400, 5: 2000],
        "crimson3": [2: 5, 3: 30, 4: 100, 5: 750],
        "crimson4": [2: 5, 3: 30, 4: 100, 5: 750],
        "crimson5": [3: 5, 4: 40, 5: 250],
        "crimson6": [3: 5, 4: 40, 5: 250],
        "crimson7": [3: 5, 4: 40, 5: 150],
        "crimson8": [3: 5, 4: 40, 5: 150],
        "crimson9": [3: 5, 4: 40, 5: 100]
    ]
}
