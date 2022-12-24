//
// AppColors.swift
// Copyright (c) 2022 and Confidential to kotinethin All rights reserved.
//
// Created on 3/29/22
//

import UIKit

extension UIColor {
        
    static func loadColor(with name: String) -> UIColor? {
        return UIColor(named: name, in: Bundle(for: BaseCustomView.self), compatibleWith: nil)
    }
    
    public static var mainTheme: UIColor {
        return UIColor.loadColor(with: "MainThemeColor")!
    }
    
    public static var secondaryTheme: UIColor {
        return UIColor.loadColor(with: "SecondaryThemeColor")!
    }
    
    public static var mainText: UIColor {
        return UIColor.loadColor(with: "MainTextColor")!
    }
    
    public static var secondaryText: UIColor {
        return UIColor.loadColor(with: "SecondaryTextColor")!
    }
    
    public static var mainBackground: UIColor {
        return UIColor.loadColor(with: "MainBGColor")!
    }
    
    public static var premium: UIColor {
        return UIColor.loadColor(with: "PremiumColor")!
    }
    
    public static var placeholder: UIColor {
        return UIColor.loadColor(with: "PlaceholderColor")!
    }
    
    public static var highlight: UIColor {
        return UIColor.loadColor(with: "HighlightColor")!
    }
    
    public static var success: UIColor {
        return UIColor.loadColor(with: "SuccessColor")!
    }
}
