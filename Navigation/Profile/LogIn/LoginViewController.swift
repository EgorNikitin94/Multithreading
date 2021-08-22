//
//  LoginViewController1.swift
//  Navigation
//
//  Created by Егор Никитин on 09.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func createUser(user: User, completion: @escaping (Bool) -> Void)
    func checkUser(completion: @escaping (Bool, String?) -> Void)
}

final class LogInViewController: UIViewController {
    
    // MARK: Properties
    
    private let logInInspector = LoginInspector()
    
    private let localAuthorizationService: LocalAuthorizationServiceProtocol = LocalAuthorizationService()
    
    weak var delegate: LoginViewControllerDelegate?
    
    private lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.toAutoLayout()
        logo.image = #imageLiteral(resourceName: "logoVK")
        return logo
    }()
    
    private lazy var logInTextField: UITextField = {
        let logIn = UITextField()
        logIn.toAutoLayout()
        logIn.backgroundColor = Colors.textViewBackgroundColor
        logIn.textColor = Colors.textColor
        logIn.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        logIn.layer.borderColor = Colors.textViewBorderColor
        logIn.layer.borderWidth = 0.25
        logIn.tintColor = Colors.colorSet
        logIn.autocapitalizationType = .none
        logIn.indent(size: 10)
        logIn.placeholder = LocalizableStrings.emailOrPhone.rawValue.localize()
        return logIn
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.toAutoLayout()
        password.backgroundColor = Colors.textViewBackgroundColor
        password.isSecureTextEntry = true
        password.textColor = Colors.textColor
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.layer.borderColor = Colors.textViewBorderColor
        password.layer.borderWidth = 0.25
        password.tintColor = Colors.colorSet
        password.autocapitalizationType = .none
        password.indent(size: 10)
        password.placeholder = LocalizableStrings.password.rawValue.localize()
        return password
    }()
    
    private lazy var inputFieldsView: UIView = {
        let inputFields = UIView()
        inputFields.toAutoLayout()
        inputFields.layer.cornerRadius = 10
        inputFields.layer.masksToBounds = true
        inputFields.layer.borderColor = Colors.textViewBorderColor
        inputFields.layer.borderWidth = 0.5
        return inputFields
    }()
    
    private lazy var createProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        button.setTitle(LocalizableStrings.createProfile.rawValue.localize(), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector (createUser), for: .touchUpInside)
        return button
    }()
    
    private lazy var biometrySignInButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        button.setTitle("FaceID or TouchID", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector (biometryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.toAutoLayout()
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.toAutoLayout()
        return scrollView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        setupLayout()
        self.navigationController?.navigationBar.isHidden = true
        
        self.delegate = logInInspector
        
        /// Keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        delegate?.checkUser() { [weak self] (result, email) in
            guard let strongSelf = self else { return }
            if result {

                let alertController = UIAlertController(title: LocalizableStrings.welcome.rawValue.localize(), message: email ?? LocalizableStrings.user.rawValue.localize(), preferredStyle: .alert)
                let okAction = UIAlertAction(title: LocalizableStrings.sighIn.rawValue.localize(), style: .default) { _ in
                    guard let navigationVC = strongSelf.navigationController else { return }
                    let coordinator = ChildCoordinator(navigator: navigationVC)
                    coordinator.makeProfileModule(coordinator: coordinator)
                    strongSelf.view.endEditing(true)
                }
                alertController.addAction(okAction)
                strongSelf.present(alertController, animated: true, completion: nil)

            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Keyboard actions
    @objc fileprivate func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    //Mark: - Actions
    
    
    @objc private func createUser() {
        if logInTextField.text?.isEmpty == true && passwordTextField.text?.isEmpty == true {
            showAlertController(message: LocalizableStrings.pleaseFillInAllTheFields.rawValue.localize())

        } else if logInTextField.text?.isEmpty == true {
            showAlertController(message: LocalizableStrings.fillInTheLoginField.rawValue.localize())

        } else if  passwordTextField.text?.isEmpty == true {
            showAlertController(message: LocalizableStrings.fillInThePasswordField.rawValue.localize())

        } else {
            let user = User(id: UUID().uuidString ,email: logInTextField.text ?? "", password: passwordTextField.text ?? "")
            delegate?.createUser(user: user, completion: { [weak self] (result) in
                guard let strongSelf = self else { return }
                if result {
                    guard let navigationVC = strongSelf.navigationController else { return }
                    let coordinator = ChildCoordinator(navigator: navigationVC)
                    coordinator.makeProfileModule(coordinator: coordinator)
                    strongSelf.view.endEditing(true)
                } else {
                    strongSelf.showAlertController(message: LocalizableStrings.errorWhileCreatingNewUser.rawValue.localize())
                }
            })
        }
    }
    
    private func showAlertController(title: String = LocalizableStrings.attention.rawValue.localize() ,message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
            print("ОК")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @objc private func biometryButtonTapped() {
        localAuthorizationService.authorizePossible { [weak self] (possible) in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                if possible {
                    guard let navigationVC = strongSelf.navigationController else { return }
                    let coordinator = ChildCoordinator(navigator: navigationVC)
                    coordinator.makeProfileModule(coordinator: coordinator)
                    strongSelf.view.endEditing(true)
                } else {
                    strongSelf.showAlertController(title: "Biometry error", message: "Your device maybe have't FaceID or TouchID")
                }
            }
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    override func traitCollectionDidChange(_ traitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(traitCollection)
        if traitCollection?.userInterfaceStyle == UIUserInterfaceStyle.light {
            logInTextField.layer.borderColor = Colors.textViewBorderColor(theme: .darkTheme)
            passwordTextField.layer.borderColor = Colors.textViewBorderColor(theme: .darkTheme)
            inputFieldsView.layer.borderColor = Colors.textViewBorderColor(theme: .darkTheme)
        } else if traitCollection?.userInterfaceStyle == UIUserInterfaceStyle.dark {
            logInTextField.layer.borderColor = Colors.textViewBorderColor(theme: .lightTheme)
            passwordTextField.layer.borderColor = Colors.textViewBorderColor(theme: .lightTheme)
            inputFieldsView.layer.borderColor = Colors.textViewBorderColor(theme: .lightTheme)
        } else {
            logInTextField.layer.borderColor = Colors.textViewBorderColor(theme: .darkTheme)
            passwordTextField.layer.borderColor = Colors.textViewBorderColor(theme: .darkTheme)
            inputFieldsView.layer.borderColor = Colors.textViewBorderColor(theme: .darkTheme)
        }
        
    }
    
    // MARK: Setup layout
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImage)
        contentView.addSubview(inputFieldsView)
        contentView.addSubview(createProfileButton)
        contentView.addSubview(biometrySignInButton)
        
        inputFieldsView.addSubview(logInTextField)
        inputFieldsView.addSubview(passwordTextField)
        
        let constraints = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            logoImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
            logoImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            logInTextField.topAnchor.constraint(equalTo: inputFieldsView.topAnchor),
            logInTextField.leadingAnchor.constraint(equalTo: inputFieldsView.leadingAnchor),
            logInTextField.trailingAnchor.constraint(equalTo: inputFieldsView.trailingAnchor),
            logInTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: logInTextField.bottomAnchor),
            passwordTextField.bottomAnchor.constraint(equalTo: inputFieldsView.bottomAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: inputFieldsView.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: inputFieldsView.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
            
            inputFieldsView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            inputFieldsView.heightAnchor.constraint(equalToConstant: 100),
            inputFieldsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            inputFieldsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            createProfileButton.topAnchor.constraint(equalTo: inputFieldsView.bottomAnchor, constant: 16),
            createProfileButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            createProfileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            createProfileButton.heightAnchor.constraint(equalToConstant: 50),
            
            biometrySignInButton.topAnchor.constraint(equalTo: createProfileButton.bottomAnchor, constant: 16),
            biometrySignInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            biometrySignInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            biometrySignInButton.heightAnchor.constraint(equalToConstant: 50),
            biometrySignInButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
}

// MARK: Extensions
extension UIView {
    func toAutoLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UIImage {
    func alpha(_ value:CGFloat) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: CGPoint.zero, blendMode: .normal, alpha: value)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}


