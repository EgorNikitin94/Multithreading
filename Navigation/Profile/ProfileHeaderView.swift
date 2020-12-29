//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Егор Никитин on 29.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    // MARK: Properties
    
    private lazy var avatarImage: UIImageView =  {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        imageView.image = #imageLiteral(resourceName: "Cat.jpeg")
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel =  {
        let label = UILabel()
        label.backgroundColor = .white
        label.text = "Funny Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private lazy var statusLabel: UILabel =  {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .gray
        label.text = "..."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var showStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.layer.cornerRadius = 12 //4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 12 //4
        button.layer.shadowOpacity = 0.7
        button.toAutoLayout()
        return button
    }()
    
    private lazy var setStatusField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.borderColor = UIColor.black.cgColor
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        textField.indent(size: 10)
        textField.layer.cornerRadius = 12
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.toAutoLayout()
        return textField
    }()
    
    private var statusText: String = ""
    
    // MARK: initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.borderWidth = 3
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
        avatarImage.clipsToBounds = true
        
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
    
    @objc private func statusTextChanged(_ textField: UITextField) {
        guard let text = setStatusField.text else {
            print("field is empty")
            return
        }
        statusText = text
    }
    
    
    
    private func setupLayout() {
        
        self.addSubview(avatarImage)
        self.addSubview(nameLabel)
        self.addSubview(statusLabel)
        self.addSubview(showStatusButton)
        self.addSubview(setStatusField)
        
        NSLayoutConstraint.activate([
            
            self.heightAnchor.constraint(equalToConstant: 220),
            
            avatarImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            avatarImage.widthAnchor.constraint(equalToConstant: 100),
            avatarImage.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            statusLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            statusLabel.heightAnchor.constraint(equalToConstant: 17),
            statusLabel.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -64),
            
            setStatusField.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            setStatusField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            setStatusField.heightAnchor.constraint(equalToConstant: 40),
            setStatusField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -16),
            
            showStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            showStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            showStatusButton.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 16),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50)
        
        ])
        
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

