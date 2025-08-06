import SwiftUI
import SpriteKit

class ImageEmitterScene: SKScene {
    let particleTexture: SKTexture
    var spawnTimer: Timer?
    
    init(size: CGSize, imageName: String) {
        self.particleTexture = SKTexture(imageNamed: imageName)
        super.init(size: size)
        backgroundColor = .clear
        scaleMode = .resizeFill
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        startSpawning()
    }
    
    override func willMove(from view: SKView) {
        spawnTimer?.invalidate()
    }
    
    func startSpawning() {
        spawnTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.spawnParticle()
        }
    }
    
    func spawnParticle() {
        let particle = SKSpriteNode(texture: particleTexture)
        particle.size = CGSize(width: 33, height: 33)
        let xPos = CGFloat.random(in: 0...size.width)
        particle.position = CGPoint(x: xPos, y: size.height + particle.size.height)
        particle.zPosition = 1
        addChild(particle)
        
        let duration = Double.random(in: 5.0...12.0)
        let moveAction = SKAction.moveTo(y: -particle.size.height, duration: duration)
        let removeAction = SKAction.removeFromParent()
        particle.run(SKAction.sequence([moveAction, removeAction]))
    }
}

struct ImageEmitterView: View {
    let scene: SKScene
    
    init(imageName: String) {
        let screenSize = UIScreen.main.bounds.size
        scene = ImageEmitterScene(size: screenSize, imageName: imageName)
    }
    
    var body: some View {
        SpriteView(
            scene: scene,
            options: [.allowsTransparency]
        )
        .ignoresSafeArea()
        .background(Color.clear)
    }
}

struct NumberCircleView: View {
    let sectors = [
        "0", "18", "31", "10", "20", "2", "26", "13", "22", "30",
        "15", "4", "24", "8", "33", "17", "34", "11", "3", "23",
        "16", "32", "27", "6", "12", "29", "1", "19", "9", "28",
        "35", "21", "7", "5", "25", "14"
    ]
    
    let radius: CGFloat = 110
    
    var body: some View {
        ZStack {
            ForEach(sectors.indices, id: \.self) { index in
                Text(sectors[index])
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .position(x: circleX(radius: radius, index: index), y: circleY(radius: radius, index: index))
            }
        }
        .frame(width: radius * 2 + 40, height: radius * 2 + 40)
    }
    
    func circleX(radius: CGFloat, index: Int) -> CGFloat {
        let angle = angleForIndex(index)
        return radius + cos(angle) * radius + 20
    }
    
    func circleY(radius: CGFloat, index: Int) -> CGFloat {
        let angle = angleForIndex(index)
        return radius + sin(angle) * radius + 20
    }
    
    func angleForIndex(_ index: Int) -> CGFloat {
        let sectorCount = sectors.count
        let degreesPerSector = 360.0 / CGFloat(sectorCount)
        let degrees = CGFloat(index) * degreesPerSector - 90
        return degrees * CGFloat.pi / 180
    }
}
