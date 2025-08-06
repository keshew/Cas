import SwiftUI

struct EmeraldMirageInfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack {
            Image(.bgMirage)
                .resizable()
                .ignoresSafeArea()
            
            Color(red: 0/255, green: 218/255, blue: 54/255).opacity(0.4)
                .ignoresSafeArea()
            
            Image(.topMirage)
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
                        .fill(Color(red: 90/255, green: 241/255, blue: 150/255))
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
                
                Image(.infoMirage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 737, height: 244)
                    .padding(.bottom, 25)
            }
        }
    }
}

#Preview {
    EmeraldMirageInfoView()
}

