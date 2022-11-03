//
//  Others+Extension.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation
import UIKit
import Photos

extension Bundle {
    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }
    
    var formattedVersion: String {
        return "\(versionNumber ?? "1.0")"
    }
}

extension UserDefaults {
    func isExist(key: String) -> Bool {
        return self.object(forKey: key) != nil
    }
}

extension Notification.Name {
    static let themeChangedNotification = Notification.Name("themeChangedNotification")
    static let languageChangedNotification = Notification.Name("languageChangedNotification")
}

extension UISwitch {
    func setScale(width: CGFloat, height: CGFloat) {
        
        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51
        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}

extension UICollectionViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    static var cellIdentifier: String {
        return String(describing: self)
    }
}


