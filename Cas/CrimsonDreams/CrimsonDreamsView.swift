import SwiftUI

struct CrimsonDreamsView: View {
    @StateObject var crimsonViewModel =  CrimsonDreamsViewModel()
    @State private var showWinPopup = false
    @State private var isMenu = false
    @State private var info = false
    @ObservedObject private var soundManager = SoundManager.shared
    @State var music: Bool {
        didSet {
            UserDefaults.standard.set(music, forKey: "slot2")
            soundManager.toggleMusic()
        }
    }

    init() {
        self.music = UserDefaults.standard.bool(forKey: "slot2")
    }
    var body: some View {
        ZStack {
            Image(.crimsonBack)
                .resizable()
                .ignoresSafeArea()
            
            Color(red: 218/255, green: 0/255, blue: 0/255).opacity(0.4)
                .ignoresSafeArea()
            
            Image(.rectangleCrimson)
                .resizable()
                .frame(width: UIScreen.main.bounds.width > 1350 ? 660 : UIScreen.main.bounds.width > 1200 ? 590 : UIScreen.main.bounds.width > 1150 ? 580 : UIScreen.main.bounds.width > 430 ? 499 : 569,
                       height: UIScreen.main.bounds.width > 1350 ? 900 : UIScreen.main.bounds.width > 1200 ? 690 : UIScreen.main.bounds.width > 1150 ? 680 : UIScreen.main.bounds.width > 430 ? 330 : 330)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1200 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.3,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2.8 : UIScreen.main.bounds.width > 1200 ? UIScreen.main.bounds.width / 3 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 3 : UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.height / 2 : UIScreen.main.bounds.height / 2)
            
            ZStack {
                if crimsonViewModel.isStopSpininng {
                    Image(.crimsonGirl2)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width > 1350 ? 400 : UIScreen.main.bounds.width > 1200 ? 300 : UIScreen.main.bounds.width > 1150 ? 300 : UIScreen.main.bounds.width > 430 ? 183 : 183,
                               height: UIScreen.main.bounds.width > 1350 ? 550 : UIScreen.main.bounds.width > 1200 ? 450 : UIScreen.main.bounds.width > 1150 ? 400 : UIScreen.main.bounds.width > 430 ? 289 : 289)
                        .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 9 : UIScreen.main.bounds.width > 1200 ? UIScreen.main.bounds.width / 10 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 10 : UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 18 : UIScreen.main.bounds.width / 18,
                                  y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1200 ? UIScreen.main.bounds.width / 2.2 : UIScreen.main.bounds.width > 980 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 3.5)
                        .transition(.opacity.combined(with: .slide))
                } else {
                    Image(.crimsonGirl)
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width > 1350 ? 400 : UIScreen.main.bounds.width > 1200 ? 300 : UIScreen.main.bounds.width > 1150 ? 300 : UIScreen.main.bounds.width > 430 ? 183 : 183,
                               height: UIScreen.main.bounds.width > 1350 ? 550 : UIScreen.main.bounds.width > 1200 ? 450 : UIScreen.main.bounds.width > 1150 ? 400 : UIScreen.main.bounds.width > 430 ? 289 : 289)
                        .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 9 : UIScreen.main.bounds.width > 1200 ? UIScreen.main.bounds.width / 10 : UIScreen.main.bounds.width > 980 ? UIScreen.main.bounds.width / 10 : UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 18 : UIScreen.main.bounds.width / 18,
                                  y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1200 ? UIScreen.main.bounds.width / 2.2 : UIScreen.main.bounds.width > 980 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 3.5)
                        .transition(.opacity.combined(with: .slide))
                }
            }
            .animation(.interactiveSpring(duration: 0.6), value: crimsonViewModel.isStopSpininng)
            
            Image(.crimsonTop)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width > 1150 ? 150 : 80)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.33,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 48 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 72 : UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 25 : UIScreen.main.bounds.width / 25)
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width > 1150 ? 150 : 80)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.33,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 48 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 72 : UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 25 : UIScreen.main.bounds.width / 25)
            
            Image(.crimsonTop)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width > 1150 ? 150 : 80)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.33,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 48 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 72 : UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 55 : UIScreen.main.bounds.width / 25)
                .rotationEffect(.degrees(180))
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width > 1150 ? 150 : 80)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.33,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 48 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 72 : UIScreen.main.bounds.width > 430 ? UIScreen.main.bounds.width / 55 : UIScreen.main.bounds.width / 25)
                .rotationEffect(.degrees(180))
            
            Button(action: {
                crimsonViewModel.bet = crimsonViewModel.balance
            }) {
                Image(.maxbetCrimson)
                    .resizable()
                    .frame(width: 113, height: 50)
            }
            .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 1.13 : UIScreen.main.bounds.width > 1200 ? UIScreen.main.bounds.width / 1.13 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 1.13 : UIScreen.main.bounds.width / 1.25,
                      y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 1.7 : UIScreen.main.bounds.width > 1200 ? UIScreen.main.bounds.width / 1.9 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 1.9 : UIScreen.main.bounds.height / 1.4)
            
            VStack {
                HStack {
                    Button(action: {
                        info = true
                    }) {
                        Circle()
                            .fill(Color(red: 255/255, green: 0/255, blue: 0/255))
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
//                            .fill(Color(red: 255/255, green: 0/255, blue: 0/255))
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
                            .fill(Color(red: 255/255, green: 0/255, blue: 0/255))
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
                                                Text("\(crimsonViewModel.bet)")
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
                                                Text("\(crimsonViewModel.win)")
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
                                                Text("\(crimsonViewModel.balance)")
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
                
                VStack {
                    ForEach(0..<3, id: \.self) { row in
                        HStack(spacing: 26) {
                            ForEach(0..<5, id: \.self) { col in
                                Image(.backItemCrimson)
                                    .resizable()
                                    .overlay {
                                        Image(crimsonViewModel.board[row][col])
                                            .resizable()
                                            .frame(width: 45, height: 45)
                                            .opacity(crimsonViewModel.isSpinning ? 0.5 : 1.0)
                                    }
                                    .frame(width: UIScreen.main.bounds.width > 1350 ? 90 : UIScreen.main.bounds.width > 1200 ? 80 : UIScreen.main.bounds.width > 1150 ? 70 : UIScreen.main.bounds.width > 430 ? 60 : 60,
                                           height: UIScreen.main.bounds.width > 1350 ? 100 : UIScreen.main.bounds.width > 1200 ? 90 : UIScreen.main.bounds.width > 1150 ? 80: UIScreen.main.bounds.width > 430 ? 60 : 60)
                                    .transition(.move(edge: .bottom))
                                    .shadow(color: crimsonViewModel.winningPositions.contains(where: { $0.row == row && $0.col == col }) ? Color(red: 255/255, green: 0/255, blue: 0/255) : .clear, radius: crimsonViewModel.isSpinning ? 0 : 10)
                            }
                        }
                    }
                }
                .offset(x: -3, y: 10)
                .animation(.easeInOut(duration: 0.2), value: crimsonViewModel.board)
                
                Spacer()
                
                HStack {
                    HStack {
                        Button(action: {
                            if crimsonViewModel.activeLinesCount > 2 {
                                crimsonViewModel.activeLinesCount -= 1
                            }
                        }) {
                            Image(.backBtnCrimson)
                                .resizable()
                                .overlay {
                                    Text("-")
                                        .One(size: 40)
                                        .shadow(radius: 1)
                                        .offset(y: -5)
                                }
                                .frame(width: 44, height: 44)
                                .opacity(crimsonViewModel.activeLinesCount == 1 ? 0.5 : 1)
                        }
                        .disabled(crimsonViewModel.activeLinesCount == 1)
                        
                        Text("LINES:\n\(crimsonViewModel.activeLinesCount)")
                            .One(size: 20)
                            .multilineTextAlignment(.center)
                        
                        Button(action: {
                            if crimsonViewModel.activeLinesCount < 10 {
                                crimsonViewModel.activeLinesCount += 1
                            }
                        }) {
                            Image(.backBtnCrimson)
                                .resizable()
                                .overlay {
                                    Text("+")
                                        .One(size: 40)
                                        .shadow(radius: 4)
                                        .offset(y: -7)
                                }
                                .frame(width: 44, height: 44)
                                .opacity(crimsonViewModel.activeLinesCount == 10 ? 0.5 : 1)
                        }
                        .disabled(crimsonViewModel.activeLinesCount == 10)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if !crimsonViewModel.isSpinning {
                            crimsonViewModel.spin()
                            soundManager.playSlot2()
                        }
                    }) {
                        Image(.spinCrimson)
                            .resizable()
                            .frame(width: 155, height: 65)
                    }
                    .offset(y: UIScreen.main.bounds.width > 1350 ? -60 : UIScreen.main.bounds.width > 1150 ? -50 : -35)
                    .disabled(crimsonViewModel.isSpinning ? true : crimsonViewModel.bet > crimsonViewModel.balance ? true : false)
                    .opacity(crimsonViewModel.isSpinning ? 0.5 : crimsonViewModel.bet > crimsonViewModel.balance ? 0.5 : 1)
                    
                    Spacer()
                    
                    Button(action: {
                        if crimsonViewModel.bet > 100 {
                            crimsonViewModel.bet -= 100
                        }
                    }) {
                        Image(.backBtnCrimson)
                            .resizable()
                            .overlay {
                                Text("-")
                                    .One(size: 40)
                                    .shadow(radius: 1)
                                    .offset(y: -5)
                            }
                            .frame(width: 44, height: 44)
                    }
                    .opacity(crimsonViewModel.bet == 100 ? 0.5 : 1)
                    .disabled(crimsonViewModel.bet == 100)
                    
                    Text("BET:\n\(crimsonViewModel.bet)")
                        .One(size: 20)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        if crimsonViewModel.bet < crimsonViewModel.balance {
                            crimsonViewModel.bet += 100
                        }
                    }) {
                        Image(.backBtnCrimson)
                            .resizable()
                            .overlay {
                                Text("+")
                                    .One(size: 40)
                                    .shadow(radius: 4)
                                    .offset(y: -7)
                            }
                            .frame(width: 44, height: 44)
                    }
                    .opacity(crimsonViewModel.bet == crimsonViewModel.balance ? 0.5 : 1)
                    .disabled(crimsonViewModel.bet == crimsonViewModel.balance)
                }
                .offset(y: 20)
                .padding(.horizontal, UIScreen.main.bounds.width > 1150 ? 20 : 0)
                .padding(.bottom, UIScreen.main.bounds.width > 1150 ? 20 : 0)
            }
            
            if crimsonViewModel.win > 0 && showWinPopup {
                Color(red: 255/255, green: 0/255, blue: 0/255).opacity(0.4)
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
                                                
                                                Text("\(crimsonViewModel.win)")
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
                            crimsonViewModel.balance += crimsonViewModel.win
                            UserDefaults.standard.set(crimsonViewModel.balance, forKey: "coin")
                            crimsonViewModel.win = 0
                        }) {
                            Image(.claimCrimson)
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
        .onChange(of: crimsonViewModel.win) { newValue in
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
            CrimsonInfoView()
        }
        .fullScreenCover(isPresented: $isMenu) {
            MainView()
        }
    }
}

#Preview {
    CrimsonInfoView()
}

struct CrimsonInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Image(.crimsonBack)
                .resizable()
                .ignoresSafeArea()
            
            Color(red: 218/255, green: 0/255, blue: 0/255).opacity(0.4)
                .ignoresSafeArea()
            
            Image(.crimsonTop)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width > 1150 ? 150 : 80)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.33,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 48 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 72 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 25 : UIScreen.main.bounds.width / 25)
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width > 1150 ? 150 : 80)
                .position(x: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 2.3 : UIScreen.main.bounds.width / 2.33,
                          y: UIScreen.main.bounds.width > 1350 ? UIScreen.main.bounds.width / 48 : UIScreen.main.bounds.width > 1210 ? UIScreen.main.bounds.width / 2 : UIScreen.main.bounds.width > 1150 ? UIScreen.main.bounds.width / 72 : UIScreen.main.bounds.width > 880 ? UIScreen.main.bounds.width / 25 : UIScreen.main.bounds.width / 25)
            
            VStack {
                HStack {
                    Circle()
                        .fill(Color(red: 255/255, green: 0/255, blue: 0/255))
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
                
                Image(.infoCrimson)
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
