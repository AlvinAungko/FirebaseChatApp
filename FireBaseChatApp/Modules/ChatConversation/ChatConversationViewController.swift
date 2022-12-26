//
//  ChatConversationViewController.swift
//  FireBaseChatApp
//
//  Created by Alvin  on 24/12/2022.
//

import UIKit

class ChatConversationViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var sendButton: UIButton!
    
    
    override func setupUI() {
        super.setupUI()
        
        setUpCollectionView()
    }
    
    func setUpCollectionView() {
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.contentInset = .zero
        collectionView.backgroundColor = .clear
        collectionView.tintColor = .clear
        
        inputTextView.textContainer.lineFragmentPadding = 0
        inputTextView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        inputTextView.text = "Type your message here"
        inputTextView.textColor = .lightGray
        inputTextView.backgroundColor = .mainBackground
        inputTextView.layer.cornerRadius = 15
        inputTextView.delegate = self
        
        sendButton.addTarget(self, action: #selector(handleSendAction), for: .touchUpInside)
        sendButton.setImage(UIImage(named: "sendIcon"), for: .normal)
        
        plusButton.addTarget(self, action: #selector(handlePlusAction), for: .touchUpInside)
        plusButton.setImage(UIImage(named: "plusIcon"), for: .normal)
        
    }
    
    @objc func handleSendAction() {
        
    }
    
    @objc func handlePlusAction() {
        
    }
    
}

extension ChatConversationViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        textView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height
            }
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            return false
        }
        return true
    }
    
}

