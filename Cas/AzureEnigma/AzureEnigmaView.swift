import SwiftUI

struct AzureEnigmaView: View {
    @StateObject var enigmaViewModel =  AzureEnigmaViewModel()
    @State private var showWinPopup = false
    @State private var isMenu = false
    @State private var info = false
    @State var music: Bool {
        didSet {
            UserDefaults.standard.set(music, forKey: "slot3")
            soundManager.toggleMusic()
        }
    }

    init() {
        self.music = UserDefaults.standard.bool(forKey: "slot3")
    }
    
    @ObservedObject private var soundManager = SoundManager.shared
    
    var body: some View {
        ZStack {
            Image(.crimsonBack)
                .resizable()
                .ignoresSafeArea()
            
            Color(red: 4/255, green: 152/255, blue: 219/255).opacity(0.4)
                .ignoresSafeArea()
            
            Image(.enigmaBack)
                .resizable()
                .frame(width: 529, height:  819)
                .position(x: UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height / 2)
            
            ZStack {
                if enigmaViewModel.isStopSpininng {
                    Image(.enigmaBoy2)
                        .resizable()
                        .frame(width: 193, height: 289)
                        .position(x: UIScreen.main.bounds.width / 18, y: UIScreen.main.bounds.height / 1.6)
                        .transition(.opacity.combined(with: .slide))
                } else {
                    Image(.enigmaBoy)
                        .resizable()
                        .frame(width: 183, height: 289)
                        .position(x: UIScreen.main.bounds.width / 18, y: UIScreen.main.bounds.height / 1.6)
                        .transition(.opacity.combined(with: .slide))
                }
            }
            .animation(.interactiveSpring(duration: 0.6), value: enigmaViewModel.isStopSpininng)
            
    
            
            Image(.enigmaTop)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .position(x: UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height > 430 ? UIScreen.main.bounds.height / 12 : UIScreen.main.bounds.height / 10)
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .position(x: UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height > 430 ? UIScreen.main.bounds.height / 12 : UIScreen.main.bounds.height / 10)
            
            Image(.enigmaTop)
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
                enigmaViewModel.bet = enigmaViewModel.balance
            }) {
                Image(.enigmaMaxBet)
                    .resizable()
                    .frame(width: 113, height: 50)
            }
            .position(x: UIScreen.main.bounds.width / 1.25, y: UIScreen.main.bounds.height / 1.4)
            
            VStack {
                HStack {
                    Button(action: {
                        info = true
                    }) {
                        Circle()
                            .fill(Color(red: 4/255, green: 152/255, blue: 219/255))
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
//                            .fill(Color(red: 4/255, green: 152/255, blue: 219/255))
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
                            .fill(Color(red: 4/255, green: 152/255, blue: 219/255))
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
                                                Text("\(enigmaViewModel.bet)")
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
                                                Text("\(enigmaViewModel.win)")
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
                                                Text("\(enigmaViewModel.balance)")
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
                                Image(.enigmaBackItem)
                                    .resizable()
                                    .overlay {
                                        Image(enigmaViewModel.board[row][col])
                                            .resizable()
                                            .frame(width: 40, height: 45)
                                            .opacity(enigmaViewModel.isSpinning ? 0.5 : 1.0)
                                        
                                    }
                                    .frame(width: 60, height: 60)
                                    .transition(.move(edge: .bottom))
                                    .shadow(color: enigmaViewModel.winningPositions.contains(where: { $0.row == row && $0.col == col }) ? Color(red: 4/255, green: 152/255, blue: 219/255) : .clear, radius: enigmaViewModel.isSpinning ? 0 : 10)
                            }
                        }
                    }
                }
                .offset(x: -3, y: 10)
                .animation(.easeInOut(duration: 0.2), value: enigmaViewModel.board)
                
                Spacer()
                
                HStack {
                    HStack {
                        Button(action: {
                            if enigmaViewModel.activeLinesCount > 2 {
                                enigmaViewModel.activeLinesCount -= 1
                            }
                        }) {
                            Image(.enigmaBackBtn)
                                .resizable()
                                .overlay {
                                    Text("-")
                                        .One(size: 40)
                                        .shadow(radius: 1)
                                        .offset(y: -5)
                                }
                                .frame(width: 44, height: 44)
                                .opacity(enigmaViewModel.activeLinesCount == 1 ? 0.5 : 1)
                        }
                        .disabled(enigmaViewModel.activeLinesCount == 1)
                        
                        Text("LINES:\n\(enigmaViewModel.activeLinesCount)")
                            .One(size: 20)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            if enigmaViewModel.activeLinesCount < 10 {
                                enigmaViewModel.activeLinesCount += 1
                            }
                        }) {
                            Image(.enigmaBackBtn)
                                .resizable()
                                .overlay {
                                    Text("+")
                                        .One(size: 40)
                                        .shadow(radius: 4)
                                        .offset(y: -7)
                                }
                                .frame(width: 44, height: 44)
                                .opacity(enigmaViewModel.activeLinesCount == 10 ? 0.5 : 1)
                        }
                        .disabled(enigmaViewModel.activeLinesCount == 10)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if !enigmaViewModel.isSpinning {
                            enigmaViewModel.spin()
                            soundManager.playSlot3()
                        }
                    }) {
                        Image(.enigmaSpin)
                            .resizable()
                            .frame(width: 155, height: 65)
                    }
                    .offset(y: -25)
                    .disabled(enigmaViewModel.isSpinning ? true : enigmaViewModel.bet > enigmaViewModel.balance ? true : false)
                    .opacity(enigmaViewModel.isSpinning ? 0.5 : enigmaViewModel.bet > enigmaViewModel.balance ? 0.5 : 1)
                    
                    Spacer()
                    
                    Button(action: {
                        if enigmaViewModel.bet > 100 {
                            enigmaViewModel.bet -= 100
                        }
                    }) {
                        Image(.enigmaBackBtn)
                            .resizable()
                            .overlay {
                                Text("-")
                                    .One(size: 40)
                                    .shadow(radius: 1)
                                    .offset(y: -5)
                            }
                            .frame(width: 44, height: 44)
                    }
                    .opacity(enigmaViewModel.bet == 100 ? 0.5 : 1)
                    .disabled(enigmaViewModel.bet == 100)
                    
                    Text("BET:\n\(enigmaViewModel.bet)")
                        .One(size: 20)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        if enigmaViewModel.bet < enigmaViewModel.balance {
                            enigmaViewModel.bet += 100
                        }
                    }) {
                        Image(.enigmaBackBtn)
                            .resizable()
                            .overlay {
                                Text("+")
                                    .One(size: 40)
                                    .shadow(radius: 4)
                                    .offset(y: -7)
                            }
                            .frame(width: 44, height: 44)
                    }
                    .opacity(enigmaViewModel.bet == enigmaViewModel.balance ? 0.5 : 1)
                    .disabled(enigmaViewModel.bet == enigmaViewModel.balance)
                }
                .offset(y: 20)
            }
            
            if enigmaViewModel.win > 0 && showWinPopup {
                Color(red: 4/255, green: 152/255, blue: 219/255).opacity(0.4)
                    .ignoresSafeArea()
                
                ZStack {
                    ImageEmitterView(imageName: "coin3")
                    
                    Image(.win)
                        .resizable()
                        .frame(width: 395, height: 265)
                    
                    VStack(spacing: 10) {
                        Rectangle()
                            .fill(Color(red: 4/255, green: 152/255, blue: 219/255))
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
                                                
                                                Text("\(enigmaViewModel.win)")
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
                            enigmaViewModel.balance += enigmaViewModel.win
                            UserDefaults.standard.set(enigmaViewModel.balance, forKey: "coin")
                            enigmaViewModel.win = 0
                        }) {
                            Image(.enigmaClaim)
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
        .onChange(of: enigmaViewModel.win) { newValue in
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
            EnigmaInfoView()
        }
        .fullScreenCover(isPresented: $isMenu) {
            MainView()
        }
    }
}

#Preview {
    AzureEnigmaView()
}

struct EnigmaInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Image(.crimsonBack)
                .resizable()
                .ignoresSafeArea()
            
            Color(red: 4/255, green: 152/255, blue: 219/255).opacity(0.4)
                .ignoresSafeArea()
            
            Image(.enigmaTop)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .position(x: UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height > 430 ? UIScreen.main.bounds.height / 12 : UIScreen.main.bounds.height / 10)
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .position(x: UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height > 430 ? UIScreen.main.bounds.height / 12 : UIScreen.main.bounds.height / 10)
            
            VStack {
                HStack {
                    Circle()
                        .fill(Color(red: 4/255, green: 152/255, blue: 219/255))
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
                
                Spacer()
                
                Image(.enigmaInfo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 737, height: 244)
                    .padding(.bottom, 25)
            }
        }
    }
}
