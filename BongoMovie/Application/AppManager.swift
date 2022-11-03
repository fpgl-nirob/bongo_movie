//
//  AppManager.swift
//  GCommerce
//
//  Created by mac 2019 on 10/28/22.
//

import Foundation
import UIKit

final class AppManager {
    static let shared = AppManager()
    private let userDefaults = UserDefaults.standard
    
    var isDarkMode: Bool {
        if let window = UIApplication.shared.windows.first {
            return window.traitCollection.userInterfaceStyle == .dark
        }
        return false
    }
    
    var isPhone: Bool {
        if let window = UIApplication.shared.windows.first {
            return window.traitCollection.userInterfaceIdiom == .phone
        }
        return false
    }
    
    var traitCollection: UITraitCollection? {
        if let window = UIApplication.shared.windows.first {
            return window.traitCollection
        }
        return nil
    }
    
    init() {
        
    }
    
    func setAuthorizationToken(token: String?) {
        userDefaults.set(token, forKey: AppConstants.kUserDefaultSecreteTokenKey)
    }
    
    func getAuthorizationToken() -> String? {
        return userDefaults.string(forKey: AppConstants.kUserDefaultSecreteTokenKey)
    }
    
    func setLanguage(lang: String) {
        userDefaults.set(lang, forKey: AppConstants.kUserDefaultLanguageKey)
    }
    
    func getLanguage() -> String {
        return userDefaults.string(forKey: AppConstants.kUserDefaultLanguageKey) ?? Locale.current.languageCode ?? "en"
    }
    
    func saveDarkMode(isDark: Bool) {
        userDefaults.set(isDark, forKey: AppConstants.kUserDefaultDarkModeKey)
    }
    
    func getSavedDarkMode() -> Bool? {
        let isExist = userDefaults.isExist(key: AppConstants.kUserDefaultDarkModeKey)
        return isExist ? userDefaults.bool(forKey: AppConstants.kUserDefaultDarkModeKey) : nil
    }
    
    func getAppVersion() -> String {
        return "ver.\(Bundle.main.formattedVersion)"
    }
    
}
