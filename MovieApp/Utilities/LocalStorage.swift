
import Foundation

struct UserDefaultKey {
    static let Localize = "localize"
    static let userData = "userData"
}

class LocalStorage {
    static let shared = LocalStorage()
    let defaults = UserDefaults.standard
    
    func setLocalize(_ localized: String) {
        defaults.setValue(localized, forKey: UserDefaultKey.Localize)
        NotificationCenter.default.post(name: .LangeuageChange, object: nil)
    }
    
    func getLocalize() -> String {
        if defaults.object(forKey: UserDefaultKey.Localize) != nil {
            return defaults.object(forKey: UserDefaultKey.Localize) as! String
        }
        return "en"
    }
    
    
}
