//
//  BaseCollectionViewCell.swift
//  FireBaseChatApp
//
//  Created by Alvin  on 24/12/2022.
//

import UIKit

class BaseCollectionViewCell<item: Any>: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        // Initialization code
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init method: not initalized")
    }
    
    func setupUI() {
        
    }
    
}
