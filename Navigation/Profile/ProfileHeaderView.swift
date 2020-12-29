//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Егор Никитин on 29.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit



class ProfileHeaderView: UIView {
    
    // MARK: Properties
    @IBOutlet private var avatarImage: UIImageView! {
        didSet {
            avatarImage.layer.borderWidth = 3
            avatarImage.backgroundColor = .white
            avatarImage.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            avatarImage.image = #imageLiteral(resourceName: "Cat.jpeg")
            avatarImage.contentMode = .scaleAspectFill
            avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
            avatarImage.clipsToBounds = true
        }
    }
    
    @IBOutlet private var nameLabel: UILabel! {
        didSet {
            nameLabel.backgroundColor = .lightGray
            nameLabel.text = "Funny Cat"
            nameLabel.font = UIFont.monospacedSystemFont(ofSize: 18, weight: .bold)
            nameLabel.textColor = .black
        }
    }
    
    @IBOutlet private var statusLabel: UILabel! {
        didSet {
            statusLabel.backgroundColor = .lightGray
            statusLabel.textColor = .gray
            statusLabel.text = "..."
            statusLabel.font = UIFont.monospacedSystemFont(ofSize: 14, weight: .regular)
        }
    }
    
    @IBOutlet private var showStatusButton: UIButton! {
        didSet {
            showStatusButton.backgroundColor = .systemBlue
            showStatusButton.setTitle("Set status", for: .normal)
            showStatusButton.setTitleColor(.white, for: .normal)
            showStatusButton.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            showStatusButton.layer.cornerRadius = 12 //4
            showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
            showStatusButton.layer.shadowRadius = 12 //4
            showStatusButton.layer.shadowOpacity = 0.7
        }
    }
    
    @IBOutlet private var setStatusField: UITextField! {
        didSet {
            setStatusField.backgroundColor = .white
            setStatusField.font = UIFont.monospacedSystemFont(ofSize: 15, weight: .regular)
            setStatusField.textColor = .black
            setStatusField.layer.borderColor = UIColor.black.cgColor
            setStatusField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
            setStatusField.indent(size: 10)
            setStatusField.layer.cornerRadius = 12
            setStatusField.layer.masksToBounds = true
            setStatusField.layer.borderWidth = 1
        }
    }
    
    private var statusText: String = ""
    
    // MARK: initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: Actions
    @objc func buttonPressed() {
        statusLabel.text = statusText
        guard let consoleMessage = statusLabel.text else {
            print("field is empty")
            return
        }
        print("User set status: \(consoleMessage)")
        
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        guard let text = setStatusField.text else {
            print("field is empty")
            return
        }
        statusText = text
    }
    
}

// MARK: Extensions
extension UITextField {
    func indent(size:CGFloat) {
        self.leftView = UIView(frame: CGRect(
                                x: self.frame.minX,
                                y: self.frame.minY,
                                width: size,
                                height: self.frame.height))
        self.leftViewMode = .always
    }
}

