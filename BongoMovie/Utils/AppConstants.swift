//
//  NHConstants.swift
//  BongoMovie
//
//  Created by mac 2019 on 03/11/2022.
//

import Foundation
import UIKit

struct AppConstants {
    static let kUserDefaultSecreteTokenKey = "kSecreteTokenKey"
    static let kUserDefaultDarkModeKey = "kDarkModeKey"
    static let kUserDefaultLanguageKey = "kLanguageKey"
}

// MARK: APIConstants
struct APIConstants {
    static let bearerKey = "Authorization"
    static let apiKey = "c37d3b40004717511adb2c1fbb15eda4"
    
    static let imageUrl = "https://image.tmdb.org/t/p/original"
    static let baseUrl = "https://api.themoviedb.org/3/"
    static let topRatedEndPoint = "movie/top_rated"
    static let movieDetailsEndPoint = "movie/"
}

enum AppTexts: String {
    case translate_id_0001
    case translate_id_0002
    case translate_id_0003
    case translate_id_0004
    case translate_id_0005
    case translate_id_0006
    case translate_id_0007
    case translate_id_0008
    case translate_id_0009
    case translate_id_0010
    case translate_id_0011
    case translate_id_0012
    case translate_id_0013
    case translate_id_0014
    case translate_id_0015
    case translate_id_0016
    case translate_id_0017
    case translate_id_0018
    case translate_id_0019
    case translate_id_0020
    case translate_id_0021
    case translate_id_0022
    case translate_id_0023
    case translate_id_0024
    case translate_id_0025
    case translate_id_0026
    case translate_id_0027
    case translate_id_0028
    case translate_id_0029
    case translate_id_0030
    case translate_id_0031
    case translate_id_0032
    case translate_id_0033
    case translate_id_0034
    case translate_id_0035
    case translate_id_0036
    case translate_id_0037
    case translate_id_0038
    case translate_id_0039
    case translate_id_0040
    case translate_id_0041
    case translate_id_0042
    case translate_id_0043
    case translate_id_0044
    case translate_id_0045
    case translate_id_0046
    case translate_id_0047
    case translate_id_0048
    case translate_id_0049
    case translate_id_0050
}

// MARK: AppImages
enum AppImages: String {
    // MARK: common
    case defaultProfile = "default_profile"
    case logo = "logo"
    case arrowBack = "arrow_back"
    case defaultThumbnail = "thumbnail"
    case transparent = "transparent"
    case settings = "settings"
    case downArrowBlack = "down_arrow_black"
    
    // MARK: Tabbar
    case tab_recent = "recent"
    case tab_search = "search"
    case tab_settings = "menu"
}

extension UIFont {
    
    static func InterRegular(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Regular", size: ofSize)!
    }
    
    static func InterLight(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Light", size: ofSize)!
    }
    
    static func InterMedium(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Medium", size: ofSize)!
    }
    
    static func InterSemiBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-SemiBold", size: ofSize)!
    }
    
    static func InterBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Bold", size: ofSize)!
    }
    
    static func InterExtraBold(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Inter-ExtraBold", size: ofSize)!
    }
    
    static func RobotoRegular(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Roboto-Regular", size: ofSize)!
    }
    
    static func HiraginoSansW3(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "HiraginoSans-W3", size: ofSize)!
    }
    
    static func HiraginoSansW6(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "HiraginoSans-W6", size: ofSize)!
    }
    
    static func HiraginoSansW7(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "HiraginoSans-W7", size: ofSize)!
    }
    
    static func BarlowMedium(ofSize: CGFloat) -> UIFont {
        return UIFont(name: "Barlow-Medium", size: ofSize)!
    }
    
}

extension UIColor {
    static let blueText = UIColor.init(hexString: "#3385FF")
    static let detailBG = UIColor.init(hexString: "#0C0908") //562F25 //0C0908
    static let background = UIColor(named: "background")
    static let whiteBlack = UIColor(named: "white_black")
    static let whiteGray = UIColor(named: "white_gray")
    static let grayDarkLight = UIColor(named: "gray_dark_light")
}

struct DateFormatConstants {
    static let yyyy_MM_dd_T_HH_mm_ss_mmm_z = "yyyy-MM-dd'T'HH:mm:ss.mmmZ"
    static let yyyy_MM_dd_T_HH_mm_ss_z = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd HH:mm:ss"
    static let dd_MMM_yyyy = "dd MMM yyyy"
    static let MMM_dd_yyyy = "MMM dd, yyyy"
    static let yyyy_mm_dd = "yyyy-MM-dd"
    static let yyyy_mm_dd_slash = "yyyy/MM/dd"
    static let yyyy = "yyyy"
    static let dd_mmm = "dd MMM"
    static let hh_mm_a = "hh:mm a"
}
