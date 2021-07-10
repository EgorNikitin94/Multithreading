//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Егор Никитин on 29.10.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

final class ProfileHeaderView: UIView {
    
    // MARK: Properties
    
    var avatarImageConfigure: UIImage? {
        didSet {
            avatarImage.image = avatarImageConfigure
        }
    }
    
    private lazy var avatarImage: UIImageView =  {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.layer.borderColor = Colors.avatarImageBorderColor
        imageView.contentMode = .scaleAspectFill
        imageView.toAutoLayout()
        return imageView
    }()
    
    private lazy var nameLabel: UILabel =  {
        let label = UILabel()
        label.backgroundColor = Colors.backgroundColor
        label.text = "Funny Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = Colors.textColor
        label.toAutoLayout()
        return label
    }()
    
    private lazy var statusLabel: UILabel =  {
        let label = UILabel()
        label.backgroundColor = Colors.backgroundColor
        label.textColor = Colors.textColor
        label.text = "..."
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.toAutoLayout()
        return label
    }()
    
    private lazy var showStatusButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle(LocalizableStrings.setStatus.rawValue.localize(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowColor = Colors.showStatusButtonShadowColor
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
        textField.backgroundColor = Colors.backgroundColor
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = Colors.textColor
        textField.layer.borderColor = Colors.setStatusFieldBorderColor
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
        self.backgroundColor = Colors.backgroundColor
        setupLayout()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LightAndDarkTheme
    
    override func traitCollectionDidChange(_ traitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(traitCollection)
        if traitCollection?.userInterfaceStyle == UIUserInterfaceStyle.light {
            setStatusField.layer.borderColor = Colors.setStatusFieldBorderColor(theme: .darkTheme)
            avatarImage.layer.borderColor = Colors.avatarImageBorderColor(theme: .darkTheme)
            showStatusButton.layer.shadowColor = Colors.showStatusButtonShadowColor(theme: .darkTheme)
        } else if traitCollection?.userInterfaceStyle == UIUserInterfaceStyle.dark {
            setStatusField.layer.borderColor = Colors.setStatusFieldBorderColor(theme: .lightTheme)
            avatarImage.layer.borderColor = Colors.avatarImageBorderColor(theme: .lightTheme)
            showStatusButton.layer.shadowColor = Colors.showStatusButtonShadowColor(theme: .lightTheme)
        } else {
            setStatusField.layer.borderColor = Colors.setStatusFieldBorderColor(theme: .darkTheme)
            avatarImage.layer.borderColor = Colors.avatarImageBorderColor(theme: .darkTheme)
            showStatusButton.layer.shadowColor = Colors.showStatusButtonShadowColor(theme: .darkTheme)
        }
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.borderWidth = 3
        avatarImage.layer.cornerRadius = avatarImage.frame.size.width / 2
        avatarImage.clipsToBounds = true
        
    }
    
    
    // MARK: Actions
    @objc private func buttonPressed() {
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
        
        self.snp.makeConstraints { (make) in
            make.height.equalTo(220)
            make.width.equalTo(UIScreen.main.bounds.width)
        }

        avatarImage.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(CGSize(width: 100, height: 100))
        }

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
        }

        statusLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(17)
            make.bottom.equalTo(showStatusButton.snp.top).offset(-64)
        }

        setStatusField.snp.makeConstraints { (make) in
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
            make.bottom.equalTo(showStatusButton.snp.top).offset(-16)
        }

        showStatusButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(avatarImage.snp.bottom).offset(16)
            make.height.equalTo(50)
        }
        
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

