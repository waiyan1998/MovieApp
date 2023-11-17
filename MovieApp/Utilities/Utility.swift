
import Foundation
import UIKit

class Utility {
    static let shared = Utility()
    func getAppVersion() -> String {
        if let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return version
        }
        return ""
    }
    
    func getFont(fontSize: CGFloat, weight: UIFont.Weight = .regular) -> UIFont {
        var fontName = ""
        if weight == .regular {
            fontName = "Quicksand-Regular"
        } else if weight == .medium {
            fontName = "Quicksand-Medium"
        } else if weight == .semibold {
            fontName = "Quicksand-SemiBold"
        } else if weight == .bold {
            fontName = "Quicksand-Bold"
        }
        return UIFont(name: fontName, size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: weight)
    }

    
}
