//
//  ContainerView.swift
//  Navigation
//
//  Created by Егор Никитин on 08.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

class ContainerView: UIView {
    
    // Mark: - Properties
    
    var onTap: (() -> Void)?
    
    private lazy var buttonOne: UIButton = {
        $0.setTitle("FirstButton", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        $0.toAutoLayout()
        return $0
    }(UIButton())
    
    private lazy var buttonTwo: UIButton = {
        $0.setTitle("SecondButton", for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        $0.setTitleColor(.black, for: .normal)
        $0.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        $0.toAutoLayout()
        return $0
    }(UIButton())
    
    
    // Mark: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .green
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    // Mark: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        buttonOne.layer.cornerRadius = 14
        buttonOne.layer.masksToBounds = true
        
        buttonTwo.layer.cornerRadius = 14
        buttonTwo.layer.masksToBounds = true
        
    }
    
    
    private func setupLayout() {
        
        self.addSubview(buttonOne)
        self.addSubview(buttonTwo)
        
        buttonOne.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(50)
        }
        
        buttonTwo.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
    
    @objc private func tapButton() {
        print("TAP")
        onTap?()
    }
    
}
