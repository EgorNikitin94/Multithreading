//
//  LogInViewController.swift
//  Navigation
//
//  Created by Егор Никитин on 11.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate: AnyObject {
    func checkUser(userEmail: String, userPassword: String, completion: @escaping (Bool) -> Void)
    func createUser(userEmail: String, userPassword: String, completion: @escaping (Bool) -> Void)
    func signOutUser(completion: @escaping (Error?) -> Void)
}

final class LogInViewController: UIViewController {
    
    // MARK: Properties
    
    private let logInInspector = LoginInspector()
    
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
        logIn.backgroundColor = #colorLiteral(red: 0.8534691637, green: 0.870538547, blue: 0.870538547, alpha: 1)
        logIn.textColor = .black
        logIn.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        logIn.layer.borderColor = UIColor.lightGray.cgColor
        logIn.layer.borderWidth = 0.25
        logIn.tintColor = Colors.colorSet
        logIn.autocapitalizationType = .none
        logIn.indent(size: 10)
        logIn.placeholder = "Email or phone"
        return logIn
    }()
    
    private lazy var passwordTextField: UITextField = {
        let password = UITextField()
        password.toAutoLayout()
        password.backgroundColor = #colorLiteral(red: 0.8534691637, green: 0.870538547, blue: 0.870538547, alpha: 1)
        password.isSecureTextEntry = true
        password.textColor = .black
        password.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        password.layer.borderColor = UIColor.lightGray.cgColor
        password.layer.borderWidth = 0.25
        password.tintColor = Colors.colorSet
        password.autocapitalizationType = .none
        password.indent(size: 10)
        password.placeholder = "Password"
        return password
    }()
    
    private lazy var inputFieldsView: UIView = {
        let inputFields = UIView()
        inputFields.toAutoLayout()
        inputFields.layer.cornerRadius = 10
        inputFields.layer.masksToBounds = true
        inputFields.layer.borderColor = UIColor.lightGray.cgColor
        inputFields.layer.borderWidth = 0.5
        return inputFields
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector (goToProfileViewController), for: .touchUpInside)
        return button
    }()
    
    private lazy var createProfileButton: UIButton = {
        let button = UIButton(type: .system)
        button.toAutoLayout()
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(1), for: .normal)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .selected)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .highlighted)
        button.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel").alpha(0.8), for: .disabled)
        button.setTitle("Create profile", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector (createUser), for: .touchUpInside)
        return button
    }()
    
    private let contentView: UIView = {
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
        view.backgroundColor = .white
        setupLayout()
        self.navigationController?.navigationBar.isHidden = true
        
        self.delegate = logInInspector
        
        /// Keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        delegate?.signOutUser(completion: { [weak self] (error) in
            guard let strongSelf = self else { return }
            if error != nil {
                strongSelf.showAlertController(message: "Не удалось выйти из аккаунта, перезагрузите пожалуйста приложение")
            }
        })
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
    
    @objc private func goToProfileViewController() {
        if logInTextField.text?.isEmpty == true && passwordTextField.text?.isEmpty == true {
            showAlertController(message: "Заполните все поля пожуйста!")
            
        } else if logInTextField.text?.isEmpty == true {
            showAlertController(message: "Заполните поле Login!")
            
        } else if  passwordTextField.text?.isEmpty == true {
            showAlertController(message: "Заполните поле Password!")
            
        } else {
            delegate?.checkUser(userEmail: logInTextField.text!, userPassword: passwordTextField.text!, completion: { [weak self] (result) in
                
                guard let strongSelf = self else { return }
                if result {
                    guard let navigationVC = strongSelf.navigationController else { return }
                    let coordinator = ChildCoordinator(navigator: navigationVC)
                    coordinator.makeProfileModule(coordinator: coordinator)
                    strongSelf.view.endEditing(true)
                } else {
                    strongSelf.showAlertController(message: "Данные введены не верно или пользователя не существует")
                }
            })
        }
    }
    
    @objc private func createUser() {
        if logInTextField.text?.isEmpty == true && passwordTextField.text?.isEmpty == true {
            showAlertController(message: "Заполните все поля пожуйста!")
            
        } else if logInTextField.text?.isEmpty == true {
            showAlertController(message: "Заполните поле Login!")
            
        } else if  passwordTextField.text?.isEmpty == true {
            showAlertController(message: "Заполните поле Password!")
            
        } else {
            delegate?.createUser(userEmail: logInTextField.text!, userPassword: passwordTextField.text!, completion: { [weak self] (result) in
                
                guard let strongSelf = self else { return }
                if result {
                    strongSelf.showAlertController(title: "Успешно", message: "Новый пользователь создан успешно")
                } else {
                    strongSelf.showAlertController(message: "Ошибка при создании нового пользователя")
                }
            })
        }
    }
    
    private func showAlertController(title: String = "Внимание!" ,message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ОК", style: .default) { _ in
            print("ОК")
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    // MARK: Setup layout
    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(logoImage)
        contentView.addSubview(inputFieldsView)
        contentView.addSubview(logInButton)
        contentView.addSubview(createProfileButton)
        
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
            
            logInButton.topAnchor.constraint(equalTo: inputFieldsView.bottomAnchor, constant: 16),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            
            createProfileButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            createProfileButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            createProfileButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            createProfileButton.heightAnchor.constraint(equalToConstant: 50),
            createProfileButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
            
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



