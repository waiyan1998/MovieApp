

import UIKit

enum AppStoryboard: String {
    case Main = "Main"
    case Detail = "Detail"
   
    var instance: UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
    }
    
    func viewController<T: UIViewController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
    
    func navigateController<T: UINavigationController>(viewControllerClass: T.Type) -> T {
        let storyboardID = (viewControllerClass as UINavigationController.Type).storyboardID
        return instance.instantiateViewController(withIdentifier: storyboardID) as! T
    }
}

