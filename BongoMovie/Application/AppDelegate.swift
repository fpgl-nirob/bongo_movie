//
//  AppDelegate.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import UIKit
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: ApplicationDelegate methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let savedTheme = AppManager.shared.getSavedDarkMode()
        if savedTheme != nil {
            self.window?.overrideUserInterfaceStyle = savedTheme == true ? .dark : .light
            print("traitcollection is not null: \(self.window?.traitCollection.userInterfaceStyle == .dark)")
        }
        let _ = SizeConfig.init()
        SDImageCache.shared.config.maxDiskSize = 1000000 * 100 // ~100 MB
        
        setSplashViewController()
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        //
    }
    
    public func setSplashViewController() {
        let splashVC = SplashViewController()
        let splashNC = CustomNavigationController(rootViewController: splashVC)
        window?.rootViewController = splashNC
        window?.makeKeyAndVisible()
    }
    
    public func setHomeViewController() {
        let searchVC = TopRatedMoviesViewController()
        let searchNC = CustomNavigationController(rootViewController: searchVC)
        window?.rootViewController = searchNC
        window?.makeKeyAndVisible()
    }

}

