import SwiftUI

class AzureEnigmaViewModel: ObservableObject {
    @Published var board: [[String]] = Array(repeating: Array(repeating: "enigma1", count: 5), count: 3)
    @Published var isSpinning = false
    @Published var isStopSpininng = false
    
    @Published var winningPositions: [(row: Int, col: Int)] = []
    @Published var activeLinesCount = 10
    @Published var balance: Int = UserDefaults.standard.integer(forKey: "coin")
    @Published var bet: Int = 100
    @Published var win: Int = 0
    
//    let arrayOfImage = ["enigma1","enigma2"]
    let arrayOfImage = ["enigma1","enigma2","enigma3","enigma4","enigma5","enigma6","enigma7","enigma8","enigma9", "enigma10"]
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

        DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
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
        "enigma1": [2: 10, 3: 100, 4: 1000, 5: 5000],
        "enigma2": [2: 5, 3: 40, 4: 400, 5: 2000],
        "enigma3": [2: 5, 3: 30, 4: 100, 5: 750],
        "enigma4": [2: 5, 3: 30, 4: 100, 5: 750],
        "enigma5": [3: 5, 4: 40, 5: 250],
        "enigma6": [3: 5, 4: 40, 5: 250],
        "enigma7": [3: 5, 4: 40, 5: 150],
        "enigma8": [3: 5, 4: 40, 5: 150],
        "enigma9": [3: 5, 4: 40, 5: 100],
        "enigma10": [3: 5, 4: 40, 5: 100]
    ]
}
