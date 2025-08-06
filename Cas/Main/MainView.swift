import SwiftUI

struct MainView: View {
    private let arrayOfGames = ["game1", "game2", "game3", "game4", "game5"]
    @State private var sliderProgress: CGFloat = 0
    @State private var scrollTargetIndex: Int = 0
    @State private var music = false
    @State private var selectedScreenIndex: ScreenIndex? = nil


    var body: some View {
        ZStack {
            Image(.back)
                .resizable()
                .ignoresSafeArea()
            
            Image(.top)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 100)
                .position(x: UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height / 10)
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 100)
                .position(x: UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height / 10)
            
            Image(.top)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .position(x: UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height / 25)
                .rotationEffect(.degrees(180))
            
            Image(.top2)
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: 80)
                .position(x: UIScreen.main.bounds.width / 2.35, y: UIScreen.main.bounds.height / 25)
                .rotationEffect(.degrees(180))
            
            VStack {
                HStack {
                    Button(action: {
                        
                    }) {
                        Circle()
                            .fill(Color(red: 241/255, green: 89/255, blue: 219/255))
                            .frame(width: 47, height: 47)
                            .overlay {
                                Text("Privacy\nPolicy")
                                    .One(size: 10, color: .black)
                                    .multilineTextAlignment(.center)
                            }
                    }
                    
                    Button(action: {
                        music.toggle()
                    }) {
                        Circle()
                            .fill(Color(red: 241/255, green: 89/255, blue: 219/255))
                            .frame(width: 47, height: 47)
                            .overlay {
                                Image(systemName: music ? "speaker.wave.3.fill" : "speaker.slash.fill")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 24))
                            }
                    }
                    
                    Spacer()
                    
                    Image(.chooseGame)
                        .resizable()
                        .frame(width: 357, height: 85)
                        .offset(y: 6)
                    
                    Spacer()
                    
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 210, height: 30)
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
                
                Spacer()
                
                ScrollViewReader { proxy in
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(arrayOfGames.indices, id: \.self) { index in
                                Button(action: {
                                    selectedScreenIndex = ScreenIndex(id: index)
                                }) {
                                    Image(arrayOfGames[index])
                                        .resizable()
                                        .frame(width: 210, height: 210)
                                        .id(index)
                                }
                            }
                        }
                    }
                    .frame(height: 210)
                    .onChange(of: scrollTargetIndex) { newIndex in
                        withAnimation {
                            proxy.scrollTo(newIndex, anchor: .center)
                        }
                    }
                    .offset(y: -6)
                    
                    GeometryReader { geo in
                        let totalWidth = geo.size.width
                        let thumbWidth = max(totalWidth / CGFloat(arrayOfGames.count), 50)
                        let maxOffsetX = totalWidth - thumbWidth - 40
                        
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .frame(height: 16)
                                .cornerRadius(8)
                            
                            Rectangle()
                                .fill(Color(red: 241/255, green: 89/255, blue: 219/255))
                                .frame(width: thumbWidth, height: 12)
                                .cornerRadius(8)
                                .offset(x: sliderProgress * maxOffsetX)
                                .gesture(
                                    DragGesture()
                                        .onChanged { value in
                                            let newX = min(max(0, value.location.x - thumbWidth / 2), maxOffsetX)
                                            sliderProgress = newX / maxOffsetX
                                            
                                            let exactIndex = sliderProgress * CGFloat(arrayOfGames.count - 1)
                                            let newIndex = Int(exactIndex.rounded())
                                            if newIndex != scrollTargetIndex {
                                                scrollTargetIndex = newIndex
                                            }
                                        }
                                )
                                .padding(.horizontal, 5)
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 30)
                    .offset(y: 30)
                }
                
                Spacer()
            }
        }
        
        .fullScreenCover(item: $selectedScreenIndex) { screenIndex in
            switch screenIndex.id {
            case 0: ChromaWheelView()
            case 1: EmeraldMirageView()
            case 2: CrimsonDreamsView()
            case 3: VioletInfernoView()
            case 4: AzureEnigmaView()
            default: ChromaWheelView()
            }
        }
    }
}

#Preview {
    MainView()
}

struct ScrollViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScreenIndex: Identifiable {
    let id: Int
}
