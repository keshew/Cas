import SwiftUI

class UserDefaultsManager: ObservableObject {
    private let defaults = UserDefaults.standard
    
    private let keys = ["boolKey1", "boolKey2", "boolKey3", "boolKey4"]
    private let dateKeys = ["boolKey1_date", "boolKey2_date", "boolKey3_date", "boolKey4_date"]
    
    func toggleMusic() {
        let current = isMusicEnabled()
        UserDefaults.standard.set(!current, forKey: "isMusicEnabled")
        objectWillChange.send()
    }
    
    func toggleSound() {
        let current = isSoundEnabled()
        UserDefaults.standard.set(!current, forKey: "isSoundEnabled")
        objectWillChange.send()
    }
    
    func saveSoundSettings(isSoundEnabled: Bool) {
        UserDefaults.standard.set(isSoundEnabled, forKey: "isSoundEnabled")
    }
    
    func saveMusicSettings(isMusicEnabled: Bool) {
        UserDefaults.standard.set(isMusicEnabled, forKey: "isMusicEnabled")
    }
    
    func isSoundEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "isSoundEnabled")
    }
    
    func isMusicEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "isMusicEnabled")
    }
}
