//
//  BaseViewController.swift
//  FireBaseChatApp
//
//  Created by Alvin  on 24/12/2022.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        setupUI()
    }
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func setupUI() {
        
    }
}
