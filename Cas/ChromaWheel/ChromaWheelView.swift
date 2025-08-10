import SwiftUI

struct RouletteNumber: Identifiable {
    let id = UUID()
    let number: String
    let color: Color
}

struct ChromaWheelView: View {
    @StateObject var chromaWheelModel =  ChromaWheelViewModel()
    @State private var wheelRotation: Double = 0
    @State private var showWinPopup = false
    @ObservedObject private var soundManager = SoundManager.shared
    
    let numbers: [RouletteNumber] = [
        RouletteNumber(number: "3", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "6", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "9", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "12", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "15", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "18", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "21", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "24", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "27", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "30", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "33", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "-", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "3st", color: .clear),
        
        RouletteNumber(number: "2", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "5", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "8", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "11", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "13", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "17", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "20", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "23", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "26", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "29", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "32", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "35", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "2st", color: .clear),
        
        RouletteNumber(number: "1", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "4", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "7", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "10", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "13", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "16", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "19", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "22", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "25", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "28", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "31", color: Color(red: 43/255, green: 42/255, blue: 42/255)),
        RouletteNumber(number: "34", color: Color(red: 174/255, green: 40/255, blue: 45/255)),
        RouletteNumber(number: "1st", color: .clear),
    ]
    
    let betItems = [["1-12", "13-24", "25-35"], ["1-18", "Even", "Red", "Black", "Odd", "19-35"]]
    @State private var selectedBet: Int? = nil
    @State private var placedBets: [String: Int] = [:]
    
    private var rows: [[RouletteNumber]] {
        stride(from: 0, to: numbers.count, by: 13).map { start in
            Array(numbers[start..<min(start+13, numbers.count)])
        }
    }
    
    @State private var undoStack: [[String: Int]] = []
    @State private var redoStack: [[String: Int]] = []
    
    @State private var isSpinning = false
    @State private var stoppedSector: Int? = nil
    
    private let sectorCount = 37
    private let sectorDegree = 360.0 / 37.0
    
    @State private var isMenu = false
    @State private var info = false
    @State var music: Bool {
        didSet {
            UserDefaults.standard.set(music, forKey: "wheel")
            soundManager.toggleMusic()
        }
    }

    init() {
        self.music = UserDefaults.standard.bool(forKey: "wheel")
    }
    
    func placeBet(on field: String, amount: Int) {
        guard !placedBets.values.contains(amount) else { return }
        
        undoStack.append(placedBets)
        
        redoStack.removeAll()
        
        placedBets[field] = amount
    }
    
    func undo() {
        guard let lastState = undoStack.popLast() else { return }
        redoStack.append(placedBets)
        placedBets = lastState
    }
    
    func redo() {
        guard let redoState = redoStack.popLast() else { return }
        undoStack.append(placedBets)
        placedBets = redoState
    }
    
    func clearAll() {
        undoStack.append(placedBets)
        placedBets.removeAll()
        redoStack.removeAll()
    }
    
    var totalBet: Int {
        placedBets.values.reduce(0, +)
    }
    
    let sectors = [
        "0", "18", "31", "10", "20", "2", "26", "13", "22", "30", "15", "4", "24", "8",
        "33", "17", "34", "11", "3", "23", "16", "32", "27", "6", "12", "29", "1", "19",
        "9", "28", "35", "21", "7", "5", "25", "14"
    ]
    
    @State private var stoppedSectorNumber: String? = nil
    
    var body: some View {
        ZStack {
            Image(.wheelBg)
                .resizable()
                .ignoresSafeArea()
            
            Color(red: 125/255, green: 8/255, blue: 167/255).opacity(0.4)
                .ignoresSafeArea()
            
            Image(.topWheel)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width > 1150 ? 150 : 80)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.33,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 48 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 72 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 24 : UIScreen.main.bounds.width / 22)
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width > 1150 ? 150 : 80)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.33,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 48 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 72 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 24 : UIScreen.main.bounds.width / 22)
            
            VStack {
                HStack {
                    Button(action: {
                        info = true
                    }) {
                        Circle()
                            .fill(Color(red: 241/255, green: 89/255, blue: 219/255))
                            .frame(width: 47, height: 47)
                            .overlay {
                                Text("Info")
                                    .One(size: 10, color: .black)
                                    .multilineTextAlignment(.center)
                            }
                    }
                    
//                    Button(action: {
//                        music.toggle()
//                    }) {
//                        Circle()
//                            .fill(Color(red: 241/255, green: 89/255, blue: 219/255))
//                            .frame(width: 47, height: 47)
//                            .overlay {
//                                Image(systemName: music ? "speaker.wave.3.fill" : "speaker.slash.fill")
//                                    .foregroundStyle(.black)
//                                    .font(.system(size: 24))
//                            }
//                    }
                    
                    Button(action: {
                        isMenu = true
                    }) {
                        Circle()
                            .fill(Color(red: 241/255, green: 89/255, blue: 219/255))
                            .frame(width: 47, height: 47)
                            .overlay {
                                Image("home")
                                    .resizable()
                                    .frame(width: 29, height: 24)
                            }
                    }
                    
                    Spacer()
                    
                    HStack(spacing: 15) {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 180, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(LinearGradient(colors: [Color(red: 251/255, green: 242/255, blue: 146/255),
                                                                    Color(red: 252/255, green: 255/255, blue: 193/255),
                                                                    Color(red: 245/255, green: 219/255, blue: 102/255),
                                                                    Color(red: 200/255, green: 142/255, blue: 77/255),
                                                                    Color(red: 183/255, green: 97/255, blue: 69/255)], startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                                    .overlay {
                                        HStack {
                                            Text("BET")
                                                .One(size: 12, color:  Color(red: 252/255, green: 255/255, blue: 193/255))
                                            
                                            Spacer()
                                            
                                            HStack(spacing: 5) {
                                                Text("\(chromaWheelModel.bet)")
                                                    .One(size: 12, color:  Color(red: 252/255, green: 255/255, blue: 193/255))
                                                
                                                Image(.coin)
                                                    .resizable()
                                                    .frame(width: 15, height: 15)
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                    }
                            }
                        
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 180, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(LinearGradient(colors: [Color(red: 251/255, green: 242/255, blue: 146/255),
                                                                    Color(red: 252/255, green: 255/255, blue: 193/255),
                                                                    Color(red: 245/255, green: 219/255, blue: 102/255),
                                                                    Color(red: 200/255, green: 142/255, blue: 77/255),
                                                                    Color(red: 183/255, green: 97/255, blue: 69/255)], startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                                    .overlay {
                                        HStack {
                                            Text("WIN")
                                                .One(size: 12, color:  Color(red: 252/255, green: 255/255, blue: 193/255))
                                            
                                            Spacer()
                                            
                                            HStack(spacing: 5) {
                                                Text("\(chromaWheelModel.win)")
                                                    .One(size: 12, color:  Color(red: 252/255, green: 255/255, blue: 193/255))
                                                
                                                Image(.coin)
                                                    .resizable()
                                                    .frame(width: 15, height: 15)
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                    }
                            }
                        
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 180, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(LinearGradient(colors: [Color(red: 251/255, green: 242/255, blue: 146/255),
                                                                    Color(red: 252/255, green: 255/255, blue: 193/255),
                                                                    Color(red: 245/255, green: 219/255, blue: 102/255),
                                                                    Color(red: 200/255, green: 142/255, blue: 77/255),
                                                                    Color(red: 183/255, green: 97/255, blue: 69/255)], startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                                    .overlay {
                                        HStack {
                                            Text("BALANCE")
                                                .One(size: 12, color:  Color(red: 252/255, green: 255/255, blue: 193/255))
                                            
                                            Spacer()
                                            
                                            HStack(spacing: 5) {
                                                Text("\(chromaWheelModel.balance)")
                                                    .One(size: 12, color:  Color(red: 252/255, green: 255/255, blue: 193/255))
                                                
                                                Image(.coin)
                                                    .resizable()
                                                    .frame(width: 15, height: 15)
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                    }
                            }
                    }
                }
                .padding(.top)
                .padding(.horizontal, UIScreen.main.bounds.width > 1150 ? 20 : 0)
                
                Spacer()
                
                Rectangle()
                    .fill(Color(red: 87/255, green: 12/255, blue: 134/255).opacity(0.5))
                    .frame(width: UIScreen.main.bounds.width > 1350 ? 917 : UIScreen.main.bounds.width > 1210 ? 717 : UIScreen.main.bounds.width > 1150 ? 797 : UIScreen.main.bounds.width > 430 ? 717 : 717,
                           height: UIScreen.main.bounds.width > 1350 ? 483 : UIScreen.main.bounds.width > 1210 ? 283 : UIScreen.main.bounds.width > 1150 ? 383 : UIScreen.main.bounds.width > 430 ? 288 : 288)
                    .overlay {
                        RoundedRectangle(cornerRadius: 24)
                            .stroke(.white, lineWidth: 4)
                            .overlay {
                                HStack(spacing: 60) {
                                    VStack(spacing: UIScreen.main.bounds.width > 1350 ? 30 : 10) {
                                        ZStack {
                                            Image(.wheel)
                                                .resizable()
                                                .rotationEffect(Angle(degrees: wheelRotation))
                                                .frame(width: UIScreen.main.bounds.width > 1350 ? 320 : UIScreen.main.bounds.width > 1210 ? 220 : UIScreen.main.bounds.width > 1150 ? 260 : UIScreen.main.bounds.width > 430 ? 220 : 220,
                                                       height: UIScreen.main.bounds.width > 1350 ? 320 : UIScreen.main.bounds.width > 1210 ? 220 : UIScreen.main.bounds.width > 1150 ? 260 : UIScreen.main.bounds.width > 430 ? 220 : 220)
                                            
                                            Image(.ball)
                                                .resizable()
                                                .frame(width: 15, height: 18)
                                                .offset(x: 0, y: UIScreen.main.bounds.width > 1350 ? -102 : UIScreen.main.bounds.width > 1210 ? -72 : UIScreen.main.bounds.width > 1150 ? -85 : UIScreen.main.bounds.width > 430 ? -72 : -72)
                                        }
                                        
                                        
                                        Button(action: spin) {
                                            Image(.btnBack)
                                                .resizable()
                                                .overlay {
                                                    Text("SPIN")
                                                        .One(size: 22, color: Color(red: 252/255, green: 255/255, blue: 193/255))
                                                }
                                                .frame(width: UIScreen.main.bounds.width > 1350 ? 166 : UIScreen.main.bounds.width > 1210 ? 126 : UIScreen.main.bounds.width > 1150 ? 126 : UIScreen.main.bounds.width > 430 ? 126 : 126,
                                                       height: UIScreen.main.bounds.width > 1350 ? 60 : UIScreen.main.bounds.width > 1210 ? 40 : UIScreen.main.bounds.width > 1150 ? 40 : UIScreen.main.bounds.width > 430 ? 40 : 40)
                                        }
                                        .disabled(isSpinning ? true : placedBets.isEmpty ? true : false)
                                        .opacity(placedBets.isEmpty ? 0.5 : isSpinning ? 0.5 : 1)
                                    }
                                    
                                    VStack(spacing: UIScreen.main.bounds.width > 1350 ? 30 : 10) {
                                        VStack(spacing: 0) {
                                            HStack(spacing: 0) {
                                                VStack(spacing: 0) {
                                                    Button(action: {
                                                        guard let bet = selectedBet else { return }
                                                        let betAlreadyPlaced = placedBets.values.contains(bet)
                                                        if !betAlreadyPlaced {
                                                            placedBets["0"] = bet
                                                        }
                                                    }) {
                                                        ZStack {
                                                            Rectangle()
                                                                .fill(Color.green)
                                                                .frame(width: 23, height: 90)
                                                                .overlay(
                                                                    RoundedRectangle(cornerRadius: 0)
                                                                        .stroke(Color.white)
                                                                )
                                                            
                                                            Text("0")
                                                                .foregroundColor(.white)
                                                                .font(.system(size: 14, weight: .bold))
                                                                .rotationEffect(.degrees(-90))
                                                            
                                                            if let bet = placedBets["0"] {
                                                                Image(betImageName(for: bet))
                                                                    .resizable()
                                                                    .frame(width: 20, height: 20)
                                                            }
                                                        }
                                                    }
                                                }
                                                
                                                VStack(spacing: 0) {
                                                    ForEach(rows.indices, id: \.self) { rowIndex in
                                                        HStack(spacing: 0) {
                                                            ForEach(rows[rowIndex]) { num in
                                                                Button(action: {
                                                                    guard let bet = selectedBet else { return }
                                                                    let betAlreadyPlaced = placedBets.values.contains(bet)
                                                                    if !betAlreadyPlaced {
                                                                        placedBets[num.number] = bet
                                                                    }
                                                                }) {
                                                                    ZStack {
                                                                        Rectangle()
                                                                            .fill(num.color)
                                                                            .overlay {
                                                                                RoundedRectangle(cornerRadius: 0)
                                                                                    .stroke(.white)
                                                                            }
                                                                            .frame(width: UIScreen.main.bounds.width > 1350 ? 34 : UIScreen.main.bounds.width > 1210 ? 23 : UIScreen.main.bounds.width > 1150 ? 30 : UIScreen.main.bounds.width > 430 ? 23 : 23,
                                                                                   height: UIScreen.main.bounds.width > 1350 ? 50 : UIScreen.main.bounds.width > 1210 ? 30 : UIScreen.main.bounds.width > 1150 ? 40 : UIScreen.main.bounds.width > 430 ? 30 : 30)
                                                                        
                                                                        Text("\(num.number)")
                                                                            .One(size: 12)
                                                                            .rotationEffect(.degrees(-90))
                                                                        
                                                                        if let bet = placedBets[num.number] {
                                                                            Image(betImageName(for: bet))
                                                                                .resizable()
                                                                                .frame(width: 20, height: 20)
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                            VStack(spacing: 0) {
                                                ForEach(Array(betItems.enumerated()), id: \.element) { (index, item) in
                                                    HStack(spacing: 0) {
                                                        ForEach(item, id: \.self) { item2 in
                                                            Button(action: {
                                                                guard let bet = selectedBet else { return }
                                                                let betAlreadyPlaced = placedBets.values.contains(bet)
                                                                if !betAlreadyPlaced {
                                                                    placedBets[item2] = bet
                                                                }
                                                            }) {
                                                                ZStack {
                                                                    Rectangle()
                                                                        .fill(item2 == "Red" ? Color(red: 174/255, green: 40/255, blue: 45/255) :
                                                                                item2 == "Black" ? Color(red: 43/255, green: 42/255, blue: 42/255) :
                                                                                Color.clear)
                                                                        .overlay(
                                                                            RoundedRectangle(cornerRadius: 0)
                                                                                .stroke(Color.white)
                                                                        )
                                                                    
                                                                    Text(item2)
                                                                        .One(size: index == 0 ? 14 : 12)
                                                                    
                                                                    if let betAmount = placedBets[item2] {
                                                                        Image(betImageName(for: betAmount))
                                                                            .resizable()
                                                                            .frame(width: 20, height: 20)
                                                                    }
                                                                }
                                                                .frame(width: index == 0 ? 107.3 : 53.6,
                                                                       height: index == 0 ? 33 : 33)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                            
                                        }
                                        
                                        HStack {
                                            Button(action: {
                                                selectedBet = 50
                                            }) {
                                                Image(.red)
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width > 1350 ? 65 : UIScreen.main.bounds.width > 1210 ? 55 : UIScreen.main.bounds.width > 1150 ? 55 : UIScreen.main.bounds.width > 430 ? 55 : 55,
                                                           height: UIScreen.main.bounds.width > 1350 ? 62 : UIScreen.main.bounds.width > 1210 ? 52 : UIScreen.main.bounds.width > 1150 ? 52 : UIScreen.main.bounds.width > 430 ? 52 : 52)
                                            }
                                            
                                            Button(action: {
                                                selectedBet = 100
                                            }) {
                                                Image(.yellow)
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width > 1350 ? 65 : UIScreen.main.bounds.width > 1210 ? 55 : UIScreen.main.bounds.width > 1150 ? 55 : UIScreen.main.bounds.width > 430 ? 55 : 55,
                                                           height: UIScreen.main.bounds.width > 1350 ? 62 : UIScreen.main.bounds.width > 1210 ? 52 : UIScreen.main.bounds.width > 1150 ? 52 : UIScreen.main.bounds.width > 430 ? 52 : 52)
                                            }
                                            
                                            Button(action: {
                                                selectedBet = 500
                                            }) {
                                                Image(.green)
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width > 1350 ? 65 : UIScreen.main.bounds.width > 1210 ? 55 : UIScreen.main.bounds.width > 1150 ? 55 : UIScreen.main.bounds.width > 430 ? 55 : 55,
                                                           height: UIScreen.main.bounds.width > 1350 ? 62 : UIScreen.main.bounds.width > 1210 ? 52 : UIScreen.main.bounds.width > 1150 ? 52 : UIScreen.main.bounds.width > 430 ? 52 : 52)
                                            }
                                            
                                            Button(action: {
                                                selectedBet = 1000
                                            }) {
                                                Image(.blue)
                                                    .resizable()
                                                    .frame(width: UIScreen.main.bounds.width > 1350 ? 65 : UIScreen.main.bounds.width > 1210 ? 55 : UIScreen.main.bounds.width > 1150 ? 55 : UIScreen.main.bounds.width > 430 ? 55 : 55,
                                                           height: UIScreen.main.bounds.width > 1350 ? 62 : UIScreen.main.bounds.width > 1210 ? 52 : UIScreen.main.bounds.width > 1150 ? 52 : UIScreen.main.bounds.width > 430 ? 52 : 52)
                                            }
                                        }
                                        
                                        HStack {
                                            Button(action: {
                                                undo()
                                            }) {
                                                Image(.btnBack)
                                                    .resizable()
                                                    .overlay {
                                                        Text("UNDO")
                                                            .One(size: 18, color: Color(red: 252/255, green: 255/255, blue: 193/255))
                                                    }
                                                    .frame(width: UIScreen.main.bounds.width > 1350 ? 126 : UIScreen.main.bounds.width > 1210 ? 106 : UIScreen.main.bounds.width > 1150 ? 106 : UIScreen.main.bounds.width > 430 ? 106 : 106,
                                                           height: UIScreen.main.bounds.width > 1350 ? 45 : UIScreen.main.bounds.width > 1210 ? 35 : UIScreen.main.bounds.width > 1150 ? 35 : UIScreen.main.bounds.width > 430 ? 35 : 35)
                                            }
                                            
                                            Button(action: {
                                                redo()
                                            }) {
                                                Image(.btnBack)
                                                    .resizable()
                                                    .overlay {
                                                        Text("REDO")
                                                            .One(size: 18, color: Color(red: 252/255, green: 255/255, blue: 193/255))
                                                    }
                                                    .frame(width: UIScreen.main.bounds.width > 1350 ? 126 : UIScreen.main.bounds.width > 1210 ? 106 : UIScreen.main.bounds.width > 1150 ? 106 : UIScreen.main.bounds.width > 430 ? 106 : 106,
                                                           height: UIScreen.main.bounds.width > 1350 ? 45 : UIScreen.main.bounds.width > 1210 ? 35 : UIScreen.main.bounds.width > 1150 ? 35 : UIScreen.main.bounds.width > 430 ? 35 : 35)
                                            }
                                            
                                            Button(action: {
                                                clearAll()
                                            }) {
                                                Image(.btnBack)
                                                    .resizable()
                                                    .overlay {
                                                        Text("CLEAR")
                                                            .One(size: 18, color: Color(red: 252/255, green: 255/255, blue: 193/255))
                                                    }
                                                    .frame(width: UIScreen.main.bounds.width > 1350 ? 126 : UIScreen.main.bounds.width > 1210 ? 106 : UIScreen.main.bounds.width > 1150 ? 106 : UIScreen.main.bounds.width > 430 ? 106 : 106,
                                                           height: UIScreen.main.bounds.width > 1350 ? 45 : UIScreen.main.bounds.width > 1210 ? 35 : UIScreen.main.bounds.width > 1150 ? 35 : UIScreen.main.bounds.width > 430 ? 35 : 35)
                                            }
                                        }
                                    }
                                }
                                .padding()
                            }
                    }
                    .cornerRadius(24)
//                    .padding(.top, 10)
                
                if UIScreen.main.bounds.width > 880 {
                    Spacer()
                }
            }
            
            if chromaWheelModel.win > 0 && showWinPopup {
                Color(red: 125/255, green: 8/255, blue: 167/255).opacity(0.4)
                    .ignoresSafeArea()
                ZStack {
                    ImageEmitterView(imageName: "coin3")
                    
                    Image(.win)
                        .resizable()
                        .frame(width: 395, height: 265)
                    
                    VStack(spacing: 10) {
                        Rectangle()
                            .fill(Color(red: 156/255, green: 24/255, blue: 24/255))
                            .frame(width: 180, height: 33)
                            .cornerRadius(10)
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(LinearGradient(colors: [Color(red: 251/255, green: 242/255, blue: 146/255),
                                                                    Color(red: 252/255, green: 255/255, blue: 193/255),
                                                                    Color(red: 245/255, green: 219/255, blue: 102/255),
                                                                    Color(red: 200/255, green: 142/255, blue: 77/255),
                                                                    Color(red: 183/255, green: 97/255, blue: 69/255)], startPoint: .leading, endPoint: .trailing), lineWidth: 3)
                                    .overlay {
                                        HStack {
                                            HStack(spacing: 5) {
                                                Image(.coin)
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                                
                                                Spacer()
                                                
                                                Text("\(chromaWheelModel.win)")
                                                    .One(size: 20, color:  Color(red: 252/255, green: 255/255, blue: 193/255))
                                                
                                                Spacer()
                                                
                                                Image(.coin)
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                    }
                            }
                        
                        Button(action: {
                            chromaWheelModel.balance += chromaWheelModel.win
                            UserDefaults.standard.set(chromaWheelModel.balance, forKey: "coin")
                            chromaWheelModel.win = 0
                        }) {
                            Image(.wheelClaim)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 185, height: 68)
                        }
                    }
                    .offset(y: 100)
                }
                .offset(x: 10, y: 30)
                .transition(.scale.combined(with: .opacity))
            }
        }
        .fullScreenCover(isPresented: $info, content: {
            WheelInfoView()
        })
        .fullScreenCover(isPresented: $isMenu, content: {
            MainView()
        })
        .onChange(of: chromaWheelModel.win) { newValue in
            if newValue > 0 {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    showWinPopup = true
                }
            } else {
                withAnimation {
                    showWinPopup = false
                }
            }
        }
        .onChange(of: totalBet) { newValue in
            chromaWheelModel.bet = totalBet
        }
    }
    
    func betImageName(for bet: Int) -> String {
        switch bet {
        case 50: return "red"
        case 100: return "yellow"
        case 500: return "green"
        case 1000: return "blue"
        default: return ""
        }
    }
    
    func spin() {
        guard !isSpinning else { return }
        soundManager.playWheelMusic()
        isSpinning = true
        stoppedSectorNumber = nil
        chromaWheelModel.win = 0
        UserDefaults.standard.set(chromaWheelModel.balance - totalBet, forKey: "coin")
        let fullRotations = Double.random(in: 4...6)
        let randomAngle = Double.random(in: 0..<360)
        let finalRotation = fullRotations * 360 + randomAngle

        withAnimation(.easeOut(duration: 4)) {
            wheelRotation = finalRotation
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            let normalizedAngle = finalRotation.truncatingRemainder(dividingBy: 360)
            let snappedAngle = (normalizedAngle / sectorDegree).rounded() * sectorDegree
            
            let sectorOffsetDegrees = 10.0
            let adjustedAngle = (snappedAngle + sectorOffsetDegrees).truncatingRemainder(dividingBy: 360)
            let sectorIndex = Int((360 - adjustedAngle) / sectorDegree) % sectorCount
            
            let fixedSectorIndex = sectorIndex % sectorCount
            stoppedSectorNumber = sectors[fixedSectorIndex]

            chromaWheelModel.calculateWin(for: stoppedSectorNumber!, placedBets: placedBets)
            placedBets.removeAll()
            
            isSpinning = false
        }
    }
}

#Preview {
    WheelInfoView()
}

struct WheelInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Image(.crimsonBack)
                .resizable()
                .ignoresSafeArea()
            
            Color(red: 125/255, green: 8/255, blue: 167/255).opacity(0.4)
                .ignoresSafeArea()
            
            Image(.topWheel)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width > 1150 ? 150 : 80)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.33,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 48 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 72 : UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 25 : UIScreen.main.bounds.width / 25)
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width > 1150 ? 150 : 80)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.33,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 48 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 72 : UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 25 : UIScreen.main.bounds.width / 25)
            
            VStack {
                HStack {
                    Circle()
                        .fill(Color(red: 241/255, green: 89/255, blue: 219/255))
                        .frame(width: 47, height: 47)
                        .overlay {
                            Button(action: {
                                presentationMode.wrappedValue.dismiss()
                            }) {
                                    Image("backArrow")
                                        .resizable()
                                        .frame(width: 29, height: 24)
                            }
                        }
                    
                    Spacer()
                    
                    Image(.info)
                        .resizable()
                        .frame(width: 127, height: 65)
                        .padding(.leading, 50)
                    
                    Spacer()
                    
                    HStack(spacing: 15) {
                        Rectangle()
                            .fill(.clear)
                            .frame(width: 180, height: 30)
                            .overlay {
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(LinearGradient(colors: [Color(red: 251/255, green: 242/255, blue: 146/255),
                                                                    Color(red: 252/255, green: 255/255, blue: 193/255),
                                                                    Color(red: 245/255, green: 219/255, blue: 102/255),
                                                                    Color(red: 200/255, green: 142/255, blue: 77/255),
                                                                    Color(red: 183/255, green: 97/255, blue: 69/255)], startPoint: .leading, endPoint: .trailing), lineWidth: 5)
                                    .overlay {
                                        HStack {
                                            Text("Balance")
                                                .One(size: 12, color:  Color(red: 252/255, green: 255/255, blue: 193/255))
                                            
                                            Spacer()
                                            
                                            HStack(spacing: 5) {
                                                Text("\(UserDefaults.standard.integer(forKey: "coin"))")
                                                    .One(size: 12, color:  Color(red: 252/255, green: 255/255, blue: 193/255))
                                                
                                                Image(.coin)
                                                    .resizable()
                                                    .frame(width: 15, height: 15)
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                    }
                            }
                    }
                }
                .padding(.top, 5)
                .padding(.horizontal, UIScreen.main.bounds.width > 1150 ? 20 : 0)
                
                Spacer()
                
                Image(.wheelInfo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 737, height: 244)
                    .padding(.bottom, 25)
                
                if UIScreen.main.bounds.width > 880 {
                    Spacer()
                }
            }
        }
    }
}
