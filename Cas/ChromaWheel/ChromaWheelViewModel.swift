import SwiftUI

class ChromaWheelViewModel: ObservableObject {
    @Published var balance: Int = UserDefaults.standard.integer(forKey: "coin")
    @Published var bet: Int = 0
    @Published var win: Int = 0
    
    func calculateWin(for winningNumber: String, placedBets: [String: Int]) {
        var totalWin = 0
        
        if let betOnNumber = placedBets[winningNumber] {
            totalWin += betOnNumber * 35
        }
        
        let redNumbers = ["1", "3", "5", "7", "9", "12", "14", "16", "18", "19", "21", "23", "25", "27", "30", "32", "34", "36"]
        let blackNumbers = ["2", "4", "6", "8", "10", "11", "13", "15", "17", "20", "22", "24", "26", "28", "29", "31", "33", "35"]
        
        if redNumbers.contains(winningNumber), let betRed = placedBets["Red"] {
            totalWin += betRed * 2
        }
        if blackNumbers.contains(winningNumber), let betBlack = placedBets["Black"] {
            totalWin += betBlack * 2
        }
        
        if let numberInt = Int(winningNumber) {
            if numberInt != 0 {
                if numberInt % 2 == 0, let betEven = placedBets["Even"] {
                    totalWin += betEven * 2
                } else if numberInt % 2 == 1, let betOdd = placedBets["Odd"] {
                    totalWin += betOdd * 2
                }
            }
        }
        
        if let numInt = Int(winningNumber) {
            if (1...12).contains(numInt), let bet1_12 = placedBets["1-12"] {
                totalWin += bet1_12 * 3
            } else if (13...24).contains(numInt), let bet13_24 = placedBets["13-24"] {
                totalWin += bet13_24 * 3
            } else if (25...36).contains(numInt), let bet25_36 = placedBets["25-35"] {
                totalWin += bet25_36 * 3
            }
        }
        
        win = totalWin
        
        let totalBet = placedBets.values.reduce(0, +)
        balance = balance - totalBet + totalWin
    }
}
