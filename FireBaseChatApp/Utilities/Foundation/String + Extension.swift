//
//  String + Extension.swift
//  kotinethin
//
//
// swiftlint: disable compiler_protocol_init

import Foundation
import UIKit

extension String {
    // MARK: - To validate and make a call
    enum RegularExpressions: String {
        case phone = "^\\s*(?:\\+?(\\d{1,3}))?([-. (]*(\\d{3})[-. )]*)?((\\d{3})[-. ]*(\\d{2,4})(?:[-.x ]*(\\d+))?)\\s*$"
        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func isValid(regex: RegularExpressions) -> Bool { return isValid(regex: regex.rawValue) }
    func isValid(regex: String) -> Bool { return range(of: regex, options: .regularExpression) != nil }
    
    func onlyDigits() -> String {
        let filtredUnicodeScalars = unicodeScalars.filter { CharacterSet.decimalDigits.contains($0) }
        return String(String.UnicodeScalarView(filtredUnicodeScalars))
    }
    
    func makeACall() {
        guard   isValid(regex: .phone),
            let url = URL(string: "tel://\(self.onlyDigits())"),
            UIApplication.shared.canOpenURL(url) else { return }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func removeDecimal() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2

        // Avoid not getting a zero on numbers lower than 1
        // Eg: .5, .67, etc...
        formatter.numberStyle = .decimal

        return formatter.string(from: NSNumber(floatLiteral: Double(self) ?? 0.0)) ?? "0"
    }
    
    // MARK: - To convert HTML text to String
    var htmlToAttributedString: NSMutableAttributedString? {
        guard let data = data(using: .utf8) else { return NSMutableAttributedString() }
        do {
            let mutableAttributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            //                let paragraphStyle = NSMutableParagraphStyle()
            //                paragraphStyle.lineSpacing = 5
            //                mutableAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, mutableAttributedString.length))
            return mutableAttributedString
        } catch {
            return NSMutableAttributedString()
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func attributedStringForMMFont() -> NSMutableAttributedString {
        let mutableAttributedString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        mutableAttributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: mutableAttributedString.length))
        return mutableAttributedString
    }
    
    func setBackgroundColor(color: UIColor, range: NSRange) -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        return attributeString
    }
    
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range: NSRange(location: 0, length: attributeString.length))
        return attributeString
    }
    
    func isValidEmail() -> Bool {
        let emailPred = NSPredicate(format: "SELF MATCHES %@", RegularExpressions.email.rawValue)
        return emailPred.evaluate(with: self)
    }
    
    // MARK: - To Localized String
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    var isInt: Bool {
        return Int(self) != nil
    }
    
    var toDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    var ddmmYYYYtoDate: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    var to24HrTime: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
    
    var to12HrTime: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        dateFormatter.timeZone = TimeZone.autoupdatingCurrent
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
}

extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}
