//
// AppFonts.swift
//
//

import UIKit

extension UIFont {
    
    // MARK: - MuseoSans
    public class func museoSans100(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MuseoSans-100", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    public class func museoSans300(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MuseoSans-300", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    public class func museoSans500(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MuseoSans-500", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
    
    public class func museoSans700(ofSize size: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MuseoSans-700", size: size) else {
            return UIFont.systemFont(ofSize: size)
        }
        return font
    }
}
