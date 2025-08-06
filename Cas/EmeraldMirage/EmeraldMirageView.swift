import SwiftUI

struct EmeraldMirageView: View {
    @StateObject var emeraldMirageModel =  EmeraldMirageViewModel()
    @State private var showWinPopup = false
    @State private var isMenu = false
    @State private var info = false
    @ObservedObject private var soundManager = SoundManager.shared
    
    @State var music: Bool {
        didSet {
            UserDefaults.standard.set(music, forKey: "slot1")
            soundManager.toggleMusic()
        }
    }

    init() {
        self.music = UserDefaults.standard.bool(forKey: "slot1")
    }
    
    var body: some View {
        ZStack {
            Image(.bgMirage)
                .resizable()
                .ignoresSafeArea()
            
            Color(red: 0/255, green: 218/255, blue: 54/255).opacity(0.4)
                .ignoresSafeArea()
            
            Image(.mirageBack)
                .resizable()
                .frame(width: 569, height: 330)
                .position(x: UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height / 2)
            
            ZStack {
                if emeraldMirageModel.isStopSpininng {
                    Image(.gnomMirage2)
                        .resizable()
                        .frame(width: 193, height: 289)
                        .position(x: UIScreen.main.bounds.width / 1.25, y: UIScreen.main.bounds.height / 1.6)
                        .transition(.opacity.combined(with: .slide))
                } else {
                    Image(.gnomMirage)
                        .resizable()
                        .frame(width: 183, height: 289)
                        .position(x: UIScreen.main.bounds.width / 1.25, y: UIScreen.main.bounds.height / 1.6)
                        .transition(.opacity.combined(with: .slide))
                }
            }
            .animation(.interactiveSpring(duration: 0.6), value: emeraldMirageModel.isStopSpininng)
            
            Image(.topMirage)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .position(x: UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height > 430 ? UIScreen.main.bounds.height / 12 : UIScreen.main.bounds.height / 10)
            
          
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .position(x: UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height > 430 ? UIScreen.main.bounds.height / 12 : UIScreen.main.bounds.height / 10)
            
            Image(.topMirage)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .position(x: UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height > 430 ? UIScreen.main.bounds.height / 32 : UIScreen.main.bounds.height / 25)
                .rotationEffect(.degrees(180))
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .position(x: UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height > 430 ? UIScreen.main.bounds.height / 32 : UIScreen.main.bounds.height / 25)
                .rotationEffect(.degrees(180))
            
            Button(action: {
                emeraldMirageModel.bet = emeraldMirageModel.balance
            }) {
                Image(.maxBetMirage)
                    .resizable()
                    .frame(width: 113, height: 50)
            }
            .position(x: UIScreen.main.bounds.width / 15, y: UIScreen.main.bounds.height / 1.4)
            
            VStack {
                HStack {
                    Button(action: {
                        info = true
                    }) {
                        Circle()
                            .fill(Color(red: 90/255, green: 241/255, blue: 150/255))
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
//                            .fill(Color(red: 90/255, green: 241/255, blue: 150/255))
//                            .frame(width: 47, height: 47)
//                            .overlay {
//                                Image(systemName: !music ? "speaker.wave.3.fill" : "speaker.slash.fill")
//                                    .foregroundStyle(.black)
//                                    .font(.system(size: 24))
//                            }
//                    }
                    
                    Button(action: {
                        isMenu = true
                    }) {
                        Circle()
                            .fill(Color(red: 90/255, green: 241/255, blue: 150/255))
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
                                                Text("\(emeraldMirageModel.bet)")
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
                                                Text("\(emeraldMirageModel.win)")
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
                                                Text("\(emeraldMirageModel.balance)")
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
                
                Spacer()
                
                VStack {
                    ForEach(0..<3, id: \.self) { row in
                        HStack(spacing: 26) {
                            ForEach(0..<5, id: \.self) { col in
                                Image(.mirageBackItem)
                                    .resizable()
                                    .overlay {
                                        Image(emeraldMirageModel.board[row][col])
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                            .opacity(emeraldMirageModel.isSpinning ? 0.5 : 1.0)
                                        
                                    }
                                    .frame(width: 60, height: 60)
                                    .transition(.move(edge: .bottom))
                                    .shadow(color: emeraldMirageModel.winningPositions.contains(where: { $0.row == row && $0.col == col }) ? Color(red: 1/255, green: 255/255, blue: 42/255) : .clear, radius: emeraldMirageModel.isSpinning ? 0 : 10)
                            }
                        }
                    }
                }
                .offset(x: -3, y: 10)
                .animation(.easeInOut(duration: 0.2), value: emeraldMirageModel.board)
                
                Spacer()
                
                HStack {
                    HStack {
                        Button(action: {
                            if emeraldMirageModel.activeLinesCount > 2 {
                                emeraldMirageModel.activeLinesCount -= 1
                            }
                        }) {
                            Image(.btnBackMirage)
                                .resizable()
                                .overlay {
                                    Text("-")
                                        .One(size: 40)
                                        .shadow(radius: 1)
                                        .offset(y: -5)
                                }
                                .frame(width: 44, height: 44)
                                .opacity(emeraldMirageModel.activeLinesCount == 1 ? 0.5 : 1)
                        }
                        .disabled(emeraldMirageModel.activeLinesCount == 1)
                        
                        Text("LINES:\n\(emeraldMirageModel.activeLinesCount)")
                            .One(size: 20)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            if emeraldMirageModel.activeLinesCount < 10 {
                                emeraldMirageModel.activeLinesCount += 1
                            }
                        }) {
                            Image(.btnBackMirage)
                                .resizable()
                                .overlay {
                                    Text("+")
                                        .One(size: 40)
                                        .shadow(radius: 4)
                                        .offset(y: -7)
                                }
                                .frame(width: 44, height: 44)
                                .opacity(emeraldMirageModel.activeLinesCount == 10 ? 0.5 : 1)
                        }
                        .disabled(emeraldMirageModel.activeLinesCount == 10)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if !emeraldMirageModel.isSpinning {
                            emeraldMirageModel.spin()
                            soundManager.playSlot1()
                        }
                    }) {
                        Image(.spinMirage)
                            .resizable()
                            .frame(width: 155, height: 65)
                    }
                    .offset(y: -25)
                    .disabled(emeraldMirageModel.isSpinning ? true : emeraldMirageModel.bet > emeraldMirageModel.balance ? true : false)
                    .opacity(emeraldMirageModel.isSpinning ? 0.5 : emeraldMirageModel.bet > emeraldMirageModel.balance ? 0.5 : 1)
                    
                    Spacer()
                    
                    Button(action: {
                        if emeraldMirageModel.bet > 100 {
                            emeraldMirageModel.bet -= 100
                        }
                    }) {
                        Image(.btnBackMirage)
                            .resizable()
                            .overlay {
                                Text("-")
                                    .One(size: 40)
                                    .shadow(radius: 1)
                                    .offset(y: -5)
                            }
                            .frame(width: 44, height: 44)
                    }
                    .opacity(emeraldMirageModel.bet == 100 ? 0.5 : 1)
                    .disabled(emeraldMirageModel.bet == 100)
                    
                    Text("BET:\n\(emeraldMirageModel.bet)")
                        .One(size: 20)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        if emeraldMirageModel.bet < emeraldMirageModel.balance {
                            emeraldMirageModel.bet += 100
                        }
                    }) {
                        Image(.btnBackMirage)
                            .resizable()
                            .overlay {
                                Text("+")
                                    .One(size: 40)
                                    .shadow(radius: 4)
                                    .offset(y: -7)
                            }
                            .frame(width: 44, height: 44)
                    }
                    .opacity(emeraldMirageModel.bet == emeraldMirageModel.balance ? 0.5 : 1)
                    .disabled(emeraldMirageModel.bet == emeraldMirageModel.balance)
                }
                .offset(y: 20)
            }
            
            if emeraldMirageModel.win > 0 && showWinPopup {
                Color(red: 0/255, green: 218/255, blue: 54/255).opacity(0.4)
                    .ignoresSafeArea()
                ZStack {
                    ImageEmitterView(imageName: "coin3")
                    
                    Image(.win)
                        .resizable()
                        .frame(width: 395, height: 265)
                    
                    VStack(spacing: 10) {
                        Rectangle()
                            .fill(Color(red: 23/255, green: 156/255, blue: 75/255))
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
                                                
                                                Text("\(emeraldMirageModel.win)")
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
                            emeraldMirageModel.balance += emeraldMirageModel.win
                            UserDefaults.standard.set(emeraldMirageModel.balance, forKey: "coin")
                            emeraldMirageModel.win = 0
                        }) {
                            Image(.claimMirage)
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
        .onChange(of: emeraldMirageModel.win) { newValue in
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
        .fullScreenCover(isPresented: $info) {
            EmeraldMirageInfoView()
        }
        .fullScreenCover(isPresented: $isMenu) {
            MainView()
        }
    }
}

#Preview {
    EmeraldMirageView()
}
