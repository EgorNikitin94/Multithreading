//
//  UIViewExtension.swift
//  Navigation
//
//  Created by Егор Никитин on 27.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

extension UIColor {
    
    static func createColor(lightMode: UIColor, darkMode: UIColor) -> UIColor {
        guard #available(iOS 13.0, *) else { return lightMode
        }
        return UIColor { (traitCollection) -> UIColor in
            return traitCollection.userInterfaceStyle == .light ? lightMode : darkMode
            
        }
    }
}

 
