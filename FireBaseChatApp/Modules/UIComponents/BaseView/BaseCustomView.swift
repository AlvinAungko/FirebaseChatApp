//
//  BaseView.swift
//  FireBaseChatApp
//
//  Created by Alvin  on 24/12/2022.
//

import UIKit

class BaseCustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
    }
    
    func commonInit() {
        
    }
}
