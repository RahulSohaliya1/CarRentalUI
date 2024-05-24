//
//  AppDelegate.swift
//  CarRentalUI
//
//  Created by DREAMWORLD on 14/07/23.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    class func sharedApplication() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        
        let defaults = UserDefaults.standard
        print(defaults.bool(forKey: "USER_LOGIN"))
        
        if defaults.bool(forKey: "USER_LOGIN") {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "HomeVC") as UIViewController
            navigationController.viewControllers = [rootViewController]
            self.window?.rootViewController = navigationController
        } else {
            let storyboard = UIStoryboard(name: "SignUp", bundle: nil)
            let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
            let rootViewController = storyboard.instantiateViewController(withIdentifier: "OnBoardingVC") as UIViewController
            navigationController.viewControllers = [rootViewController]
            self.window?.rootViewController = navigationController
        }
        return true
    }
}


