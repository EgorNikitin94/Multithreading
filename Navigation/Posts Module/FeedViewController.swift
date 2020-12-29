//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    //Mark: -  Properties
    
    var previous = NSDecimalNumber.one
    var current = NSDecimalNumber.one
    var position: UInt = 1
    var updateTimer: Timer?
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    private lazy var resultsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textAlignment = .center
        label.toAutoLayout()
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.2823529412, green: 0.5215686275, blue: 0.8, alpha: 1)
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private lazy var buttonOne: UIButton = {
        let button = UIButton()
        button.setTitle("FirstButton", for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        button.layer.cornerRadius = 14
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    
    // Mark: - init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        view.backgroundColor = .green
        setupLayout()
        NotificationCenter.default
            .addObserver(self, selector: #selector(reinstateBackgroundTask),
                         name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    // Mark: - Actions
    
    @objc func didTapPlayPause(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            resetCalculation()
            updateTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self,
                                               selector: #selector(calculateNextNumber), userInfo: nil, repeats: true)
            registerBackgroundTask ()
            
        } else {
            updateTimer?.invalidate()
            updateTimer = nil
            if backgroundTask != .invalid {
                endBackgroundTask()
            }
            
            
        }
    }
    
    @objc func tapButton() {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    // Mark: - Background tasks
    
    @objc func calculateNextNumber() {
        let result = current.adding(previous)
        
        let bigNumber = NSDecimalNumber(mantissa: 1, exponent: 40, isNegative: false)
        if result.compare(bigNumber) == .orderedAscending {
            previous = current
            current = result
            position += 1
        } else {
            // This is just too much.... Start over.
            resetCalculation()
        }
        
        let resultsMessage = "Position \(position) = \(current)"
        switch UIApplication.shared.applicationState {
        case .active:
            resultsLabel.text = resultsMessage
        case .background:
            print("App is backgrounded. Next number = \(resultsMessage)")
            print("Background time remaining = " +
                    "\(UIApplication.shared.backgroundTimeRemaining) seconds")
        case .inactive:
            break
        }
        
        
        
        
    }
    
    func resetCalculation() {
        previous = .one
        current = .one
        position = 1
    }
    
    
    private func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask { [weak self] in
            self?.endBackgroundTask()
        }
        assert(backgroundTask != .invalid)
    }
    
    private func endBackgroundTask() {
        print("Background task ended.")
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }
    
    @objc func reinstateBackgroundTask() {
        if updateTimer != nil && backgroundTask ==  .invalid {
            registerBackgroundTask()
        }
    }
    
    
    // Mark: - Layout Settings
    
    private func setupLayout() {
        
        view.addSubview(buttonOne)
        view.addSubview(resultsLabel)
        view.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            
            buttonOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            buttonOne.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonOne.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            buttonOne.heightAnchor.constraint(equalToConstant: 50),
            
            resultsLabel.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 40),
            resultsLabel.widthAnchor.constraint(equalToConstant: 150),
            resultsLabel.heightAnchor.constraint(equalToConstant: 20),
            resultsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            playButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            playButton.widthAnchor.constraint(equalToConstant: 40),
            playButton.heightAnchor.constraint(equalToConstant: 20),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }
}

