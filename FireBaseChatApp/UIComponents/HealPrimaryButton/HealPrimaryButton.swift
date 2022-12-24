//
// HealPrimaryButton.swift
//
//

import UIKit

public class HealPrimaryButton: UIButton {
    
    public enum Style: Equatable {
        case normal
        case plain
        case secondary
        case disabled
        case previous
        case request
    }
    
    public var buttonStyle: Style = .normal {
        didSet {
            setupView()
        }
    }
    
    private var buttonCornerRadius: CGFloat {
        15
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        resetDesignAttributes()
        
        applyFoundationAttributes()
        
        switch buttonStyle {
        case .normal:
            applyNormalTheme()
        case .plain:
            applyPlainTheme()
        case .secondary:
            applySecondaryTheme()
        case .disabled:
            applyDisabledTheme()
        case .previous:
            applyPreviousTheme()
        case .request:
            applyRequestTheme()
        }
    }
    
    private func resetDesignAttributes() {
        setImage(nil, for: .normal)
        setImage(nil, for: .highlighted)
        imageEdgeInsets = .zero
    }
    
    // MARK: - Apply Theme
    private func applyFoundationAttributes() {
        titleLabel?.font = UIFont.museoSans300(ofSize: 14)
//        titleLabel?.font = UIFont.museoSans500(ofSize: 16)

        layer.cornerRadius = self.buttonCornerRadius
        layer.borderColor = UIColor.clear.cgColor
        layer.borderWidth = 1
    }
    
    private func applyNormalTheme() {
        setTitleColor(.white, for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
        
        backgroundColor = .mainTheme
        
        isEnabled = true
    }
    
    private func applyPlainTheme() {
        setTitleColor(.mainTheme, for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
        
        backgroundColor = .clear
        
        isEnabled = true
    }
    
    private func applySecondaryTheme() {
        setTitleColor(.secondaryText, for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
        
        backgroundColor = .clear
        
        isEnabled = true
    } 
    
    private func applyDisabledTheme() {
        setTitleColor(.white, for: .normal)
        
        backgroundColor = UIColor(named: "#C8CEE4")
        
        isEnabled = false
    }
    
    private func applyPreviousTheme() {
        setTitleColor(.mainTheme, for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
        
        backgroundColor = .white
        borderColor = .mainTheme
        borderWidth = 1
        
        isEnabled = true
    }
    
    private func applyRequestTheme() {
        setTitleColor(.secondaryText, for: .normal)
        setTitleColor(.lightGray, for: .highlighted)
        
        backgroundColor = .clear
        
        isEnabled = false
    }
}
