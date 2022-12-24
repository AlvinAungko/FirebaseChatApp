//
//  AppDelegate.swift
//  FireBaseChatApp
//
//  Created by Alvin  on 19/12/2022.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    let userDefault = UserDefaults.standard
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // IQKeyboard Manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let isLoggedIn = userDefault.bool(forKey: "logged-in")
        
        if !isLoggedIn {
            let vc = LoginViewController()
            window?.rootViewController = UINavigationController(rootViewController: vc)
        } else {
            let vc = ChatConversationViewController()
            window?.rootViewController = UINavigationController(rootViewController: vc)
        }
        
        return true
    }
    
}

