//
//  String+Extension.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation
import CoreGraphics
import UIKit

extension String {
    var tr: String {
        let selectedLanguage = AppManager.shared.getLanguage()
        if let path = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj"), let bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: "Localizable", bundle: bundle, value: self, comment: self)
        }
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
    
    func attributedStringFromHTML(backgroundColor: UIColor, forgroundColor: UIColor) -> NSAttributedString? {
        let data = Data(self.utf8)
        if let attributedString = try? NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: forgroundColor, range: NSRange(location: 0, length: attributedString.length))
            attributedString.addAttribute(NSAttributedString.Key.backgroundColor, value: backgroundColor, range: NSRange(location: 0, length: attributedString.length))
            return attributedString
        }
        return nil
    }
}
