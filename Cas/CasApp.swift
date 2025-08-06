import SwiftUI

@main
struct CasApp: App {

    init() {
        let defaults = UserDefaults.standard
        let hasLaunchedKey = "hasLaunchedBefore"
        
        if !defaults.bool(forKey: hasLaunchedKey) {
            defaults.set(6500, forKey: "coin")
            defaults.set(true, forKey: hasLaunchedKey)
            defaults.synchronize()
        }
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
