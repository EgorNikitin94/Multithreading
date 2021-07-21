//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

final class FeedViewController: UIViewController {
    
    //Mark: -  Properties
    
    var coordinator: BaseCoordinator?
    
    private lazy var container: ContainerView = {
        $0.onTap = { [weak self] in
            self?.coordinator?.showNextViewController()
        }
        return $0
    }(ContainerView())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = LocalizableStrings.feed.rawValue.localize()
        view.backgroundColor = .green
        setupLayout()
        
    }
    
    // Mark: - init
    
    init() {
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Mark: - Layout Settings
    
    private func setupLayout() {
        
        view.addSubview(container)
        
        container.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(140)
        }
 
    }
    
    
}

