//
//  Colors.swift
//  Navigation
//
//  Created by Егор Никитин on 17.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

enum Colors {
    
    enum AppTheme {
        case lightTheme
        case darkTheme
    }
    
    static let colorSet = #colorLiteral(red: 0.2823529412, green: 0.5215686275, blue: 0.8, alpha: 1)
    static let backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
    static let textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
    static let textViewBackgroundColor = UIColor.createColor(lightMode: #colorLiteral(red: 0.8534691637, green: 0.870538547, blue: 0.870538547, alpha: 1), darkMode: #colorLiteral(red: 0.3103783312, green: 0.3103783312, blue: 0.3103783312, alpha: 1))
    static let textViewBorderColor = UIColor.createColor(lightMode: UIColor.lightGray, darkMode: UIColor.white).cgColor
    static let setStatusFieldBorderColor = UIColor.createColor(lightMode: .black, darkMode: .white).cgColor
    static let avatarImageBorderColor = UIColor.createColor(lightMode: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), darkMode: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)).cgColor
    static let showStatusButtonShadowColor = UIColor.createColor(lightMode: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), darkMode: #colorLiteral(red: 0.4916521256, green: 0.4916521256, blue: 0.4916521256, alpha: 1)).cgColor
    
    static func textViewBorderColor(theme: AppTheme) -> CGColor {
        if theme == .lightTheme {
            return UIColor.lightGray.cgColor
        } else {
            return UIColor.white.cgColor
        }
    }
    
    static func setStatusFieldBorderColor(theme: AppTheme) -> CGColor {
        if theme == .lightTheme {
            return UIColor.black.cgColor
        } else {
            return UIColor.white.cgColor
        }
    }
    
    static func avatarImageBorderColor(theme: AppTheme) -> CGColor {
        if theme == .lightTheme {
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    static func showStatusButtonShadowColor(theme: AppTheme) -> CGColor {
        if theme == .lightTheme {
            return #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else {
            return #colorLiteral(red: 0.4916521256, green: 0.4916521256, blue: 0.4916521256, alpha: 1)
        }
    }
}

