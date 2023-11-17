//
//  UIViewController.swift
//  PoyaCustomer
//
//  Created by AdventSoft on 27/4/20.
//  Copyright © 2020 Advent Soft. All rights reserved.
//

import UIKit



extension UIViewController {
    
    class var storyboardID : String {
        return "\(self)"
    }
    
    static func initiate(appStoryBoard: AppStoryboard) -> Self {
        return appStoryBoard.viewController(viewControllerClass: self)
    }
    
}

