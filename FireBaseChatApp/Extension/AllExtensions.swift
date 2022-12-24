//
//  AllExtensions.swift
//  kotinethin
//
//
// swiftlint: disable force_cast valid_ibinspectable

import Foundation
import UIKit
import NotificationBannerSwift

@IBDesignable
class DesignableView: UIView {
}

@IBDesignable
class DesignableButton: UIButton {
}

@IBDesignable
class DesignableTextField: UITextField {
    @IBInspectable var insetX: CGFloat = 6 {
        didSet {
            layoutIfNeeded()
        }
    }
    @IBInspectable var insetY: CGFloat = 6 {
        didSet {
            layoutIfNeeded()
        }
    }
    
    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
    
    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}

@IBDesignable
class DesignableLabel: UILabel {
}

@IBDesignable
class DesignableImageView: UIImageView {
}

extension UIView { 
    
    func getAllLabels(fromView view: UIView) -> [UILabel] {
        return view.subviews.compactMap { (view) -> [UILabel]? in
            if view is UILabel {
                return [(view as! UILabel)]
            } else {
                return getAllLabels(fromView: view)
            }
        }.flatMap({$0})
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layoutSubviews()
        }
    }
    
    @IBInspectable
    var shadowColor: CGColor {
        get {
            return layer.shadowColor ?? UIColor.clear.cgColor
        }
        set {
            layer.shadowColor = newValue
            layoutSubviews()
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
            layoutSubviews()
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
            layoutSubviews()
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
            layoutSubviews()
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    } 
}

extension UITextView: UITextViewDelegate {
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.bounds.minY
            let labelWidth = self.frame.width - (labelX * 2) - 50
            let labelHeight = self.bounds.height
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: CGFloat(labelHeight))
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
    private func addPlaceholder(_ placeholderText: String) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        placeholderLabel.numberOfLines = 0
        placeholderLabel.font = self.font
//        placeholderLabel.textColor = UIColor.init(hexString: "777777", alpha: 0.7)
        placeholderLabel.tag = 100
        
        placeholderLabel.isHidden = !self.text.isEmpty
        
        self.addSubview(placeholderLabel)
        self.resizePlaceholder()
        self.delegate = self
    }
}

extension UIViewController {
//    func presentBottomSheet(_ bottomSheet: BottomSheetViewController, completion: (() -> Void)?) {
//        self.present(bottomSheet, animated: false, completion: completion)
//    }
//
//    // With this extension you can access the MainViewController from the child view controllers.
//    func revealViewController() -> MainViewController? {
//        var viewController: UIViewController? = self
//
//        if viewController != nil && viewController is MainViewController {
//            return viewController! as? MainViewController
//        }
//        while !(viewController is MainViewController) && viewController?.parent != nil {
//            viewController = viewController?.parent
//        }
//        if viewController is MainViewController {
//            return viewController as? MainViewController
//        }
//        return nil
//    }
    
    func showToast(message: String) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        let maximumLabelSize: CGSize = CGSize(width: 280, height: 300)
        let expectedLabelSize: CGSize = toastLabel.sizeThatFits(maximumLabelSize)
        var newFrame: CGRect = toastLabel.frame
        newFrame.size.height = expectedLabelSize.height + 20
        newFrame.size.width = self.view.frame.size.width - 40
        newFrame.origin.y = self.view.frame.size.height - newFrame.size.height - 40
        newFrame.origin.x = self.view.frame.size.width/2 - (newFrame.size.width/2)
        toastLabel.frame = newFrame
        toastLabel.clipsToBounds  =  true
        
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            keyWindow?.addSubview(toastLabel)
        } else {
           let window = UIApplication.shared.keyWindow
            window?.addSubview(toastLabel)
        }
        
        UIView.animate(withDuration: 3, delay: 0.5, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(_) in
            toastLabel.removeFromSuperview()
        })
    }
    
    func showBanner(_ title: String, _ style: BannerStyle) {
        let banner = StatusBarNotificationBanner(title: title, style: style, colors: nil)
//        banner.bannerHeight = self.view.frame.height * 0.12
        banner.show()
    }
    
//    func showErrorPage(error: ErrorResponse) {
//        if error.statusCode == 401 || error.message == "User is not logged in." {
//            let vc = ErrorPageRouter.createModule(errorResponse: error, image: UIImage(named: "output-online"), title: "sessionExpiredTitle".localized(), subTitle: "sessionExpiredContent".localized(), description: "", buttonTitle: "login".localized())
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else {
//            let vc = ErrorPageRouter.createModule(errorResponse: error, image: UIImage(named: "error"), title: "Sorry!", subTitle: "Unsuccessful", description: (error.message != "" ? error.message ?? "": error.error?.localizedDescription)!, buttonTitle: "tryAgain".localized())
//            self.navigationController?.pushViewController(vc, animated: true)
////            self.showBanner(error.message ?? "\(error.error?.localizedDescription ?? "")", .danger)
//        }
//    }
}

extension Array {
    func json() -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
}

extension UILabel {
    var defaultFont: UIFont? {
        get { return self.font }
        set { self.font = newValue }
    }
}

extension UILabel {
    func configureWith(_ text: String,
                       color: UIColor,
                       alignment: NSTextAlignment,
                       font: UIFont) {
        self.font = font
        self.text = text
        self.textColor = color
        self.textAlignment = alignment
    }
}

extension UIView {
    func setupCornerRadius(_ cornerRadius: CGFloat = 0, maskedCorners: CACornerMask? = nil) {
        layer.cornerRadius = cornerRadius
        if let corners = maskedCorners {
            layer.maskedCorners = corners
        }
    }
    
    func animateClick(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.15) {
            self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        } completion: { _ in
            UIView.animate(withDuration: 0.15) {
                self.transform = CGAffineTransform.identity
            } completion: { _ in completion() }
        }
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 7
    }
}

extension UIStackView {
    func addArrangedSubviews(_ subviews: [UIView]) {
        subviews.forEach { addArrangedSubview($0) }
    }
}

extension Optional where Wrapped == String {
    var orEmpty: String { self ?? "" }
}

extension UITextField {
    func setLeftViewIcon(_ image: UIImage) {
        let iconView = UIImageView(frame: CGRect(x: 10, y: 3, width: 15, height: 15))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame: CGRect(x: 25, y: 0, width: 30, height: 20))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}

extension UINavigationController {
    func popViewController(animated: Bool, completion: @escaping () -> Void) {
        popViewController(animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
    
    func pushViewController(_ viewController: UIViewController, animated: Bool, completion: @escaping () -> Void) {
        pushViewController(viewController, animated: animated)
        
        if animated, let coordinator = transitionCoordinator {
            coordinator.animate(alongsideTransition: nil) { _ in
                completion()
            }
        } else {
            completion()
        }
    }
}

extension UILabel {
    var isTruncatedText: Bool {
        guard let height = textHeight else {
            return false
        }
        return height > bounds.size.height
    }
    
    var textHeight: CGFloat? {
        guard let labelText = text else {
            return nil
        }
        let attributes: [NSAttributedString.Key: UIFont] = [.font: font]
        let labelTextSize = (labelText as NSString).boundingRect(
            with: CGSize(width: frame.size.width, height: .greatestFiniteMagnitude),
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        ).size
        return ceil(labelTextSize.height)
    }
    
    var truncationIndex: Int? {
        guard let text = text else {
            return nil
        }
        let attributes: [NSAttributedString.Key: UIFont] = [.font: font]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        let textContainer = NSTextContainer(
            size: CGSize(width: frame.size.width,
                         height: CGFloat.greatestFiniteMagnitude)
        )
        textContainer.maximumNumberOfLines = numberOfLines
        textContainer.lineBreakMode = NSLineBreakMode.byTruncatingTail

        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)

        let textStorage = NSTextStorage(attributedString: attributedString)
        textStorage.addLayoutManager(layoutManager)

        // Determine the range of all Glpyhs within the string
        var glyphRange = NSRange()
        layoutManager.glyphRange(
            forCharacterRange: NSMakeRange(0, attributedString.length),
            actualCharacterRange: &glyphRange
        )

        var truncationIndex = NSNotFound
        // Iterate over each 'line fragment' (each line as it's presented, according to your `textContainer.lineBreakMode`)
        var i = 0
        layoutManager.enumerateLineFragments(
            forGlyphRange: glyphRange
        ) { _, _, _, glyphRange, stop in
            if i == self.numberOfLines - 1 {
                // We're now looking at the last visible line (the one at which text will be truncated)
                let lineFragmentTruncatedGlyphIndex = glyphRange.location
                if lineFragmentTruncatedGlyphIndex != NSNotFound {
                    truncationIndex = layoutManager.truncatedGlyphRange(inLineFragmentForGlyphAt: lineFragmentTruncatedGlyphIndex).location
                }
                stop.pointee = true
            }
            i += 1
        }
        return truncationIndex
    }
    
    @discardableResult
    func setExpandActionIfPossible(_ text: String, textColor: UIColor? = nil) -> NSRange? {
        guard isTruncatedText, let visibleString = visibleText else {
            return nil
        }
        let defaultTruncatedString = ""
        let fontAttribute: [NSAttributedString.Key: UIFont] = [.font: font]
        let expandAttributedString: NSMutableAttributedString = NSMutableAttributedString(
            string: defaultTruncatedString,
            attributes: fontAttribute
        )
        let customExpandAttributes: [NSAttributedString.Key: Any] = [
            .font: font as Any,
            .foregroundColor: (textColor ?? self.textColor) as Any
        ]
        let customExpandAttributedString = NSAttributedString(string: "\(text)", attributes: customExpandAttributes)
        expandAttributedString.append(customExpandAttributedString)
        
        let visibleAttributedString = NSMutableAttributedString(string: visibleString, attributes: fontAttribute)
        guard visibleAttributedString.length > expandAttributedString.length else {
            return nil
        }
        let changeRange = NSRange(location: visibleAttributedString.length - expandAttributedString.length, length: expandAttributedString.length)
        visibleAttributedString.replaceCharacters(in: changeRange, with: expandAttributedString)
        attributedText = visibleAttributedString
        return changeRange
    }
    
    var visibleText: String? {
        guard isTruncatedText,
            let labelText = text,
            let lastIndex = truncationIndex else {
            return nil
        }
        let visibleTextRange = NSRange(location: 0, length: lastIndex)
        guard let range = Range(visibleTextRange, in: labelText) else {
            return nil
        }
        return String(labelText[range])
    }
    
    private func getIndex(from point: CGPoint) -> Int? {
        guard let attributedString = attributedText, attributedString.length > 0 else {
            return nil
        }
        let textStorage = NSTextStorage(attributedString: attributedString)
        let layoutManager = NSLayoutManager()
        textStorage.addLayoutManager(layoutManager)
        let textContainer = NSTextContainer(size: frame.size)
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = numberOfLines
        textContainer.lineBreakMode = lineBreakMode
        layoutManager.addTextContainer(textContainer)

        let index = layoutManager.characterIndex(
            for: point,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )
        return index
    }
        
    func didTapInRange(_ point: CGPoint, targetRange: NSRange) -> Bool {
        guard let indexOfPoint = getIndex(from: point) else {
            return false
        }
        return indexOfPoint > targetRange.location ||
            indexOfPoint < targetRange.location + targetRange.length
    }
}

extension NSMutableAttributedString {
    func setColorForText(textForAttribute: String, withColor color: UIColor) {
        let range: NSRange = self.mutableString.range(of: textForAttribute, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}
