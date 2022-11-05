//
//  SettingsViewModel.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation

enum LangCode: String {
    case en
    case hi
}

class SettingsViewModel {
    var selectedLang: String?
    
    init() {
        selectedLang = getLang(from: LangCode(rawValue: AppManager.shared.getLanguage()) ?? .en)
    }
    
    public func getSelectedLangIndex() -> Int {
        switch selectedLang {
        case AppTexts.translate_id_0014.rawValue.tr:
            return 0
        case AppTexts.translate_id_0015.rawValue.tr:
            return 1
        default:
            return 0
        }
    }
    
    public func getLangCode() -> LangCode {
        switch selectedLang {
        case AppTexts.translate_id_0014.rawValue.tr:
            return .en
        case AppTexts.translate_id_0015.rawValue.tr:
            return .hi
        default:
            return .en
        }
    }
    
    public func getLang(from code: LangCode) -> String {
        switch code {
        case .en:
            return AppTexts.translate_id_0014.rawValue.tr
        case .hi:
            return AppTexts.translate_id_0015.rawValue.tr
        }
    }
}
