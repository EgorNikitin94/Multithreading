//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Егор Никитин on 17.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    var cellConfigure: ([UIImage])? {
        didSet {
            guard let images = cellConfigure else {return}
            photoOneImageView.image = images[0]
            photoTwoImageView.image = images[1]
            photoThreeImageView.image = images[2]
            photoFourImageView.image = images[3]
        }
    }
    
    private var photosLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = LocalizableStrings.photos.rawValue.localize()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private var arrowImageView: UIImageView = {
        let arrow = UIImageView()
        arrow.toAutoLayout()
        arrow.image = UIImage(named: "arrow.right")
        arrow.tintColor = .black
        return arrow
    }()
    
    private lazy var photoOneImageView: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.layer.cornerRadius = 6
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    private lazy var photoTwoImageView: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.layer.cornerRadius = 6
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    private lazy var photoThreeImageView: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.layer.cornerRadius = 6
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    private lazy var photoFourImageView: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.layer.cornerRadius = 6
        photo.clipsToBounds = true
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    private var stackPhotos: UIStackView = {
        let stack = UIStackView()
        stack.toAutoLayout()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    // MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Setup Layout
    private func setupLayout() {
        contentView.addSubview(photosLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(stackPhotos)
        stackPhotos.addArrangedSubview(photoOneImageView)
        stackPhotos.addArrangedSubview(photoTwoImageView)
        stackPhotos.addArrangedSubview(photoThreeImageView)
        stackPhotos.addArrangedSubview(photoFourImageView)
        
        let width = (contentView.frame.size.width - 48) / 4
        let height = width
        
        let constraints = [
            photosLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photosLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photosLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor),
            
            arrowImageView.centerYAnchor.constraint(equalTo: photosLabel.centerYAnchor),
            arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrowImageView.heightAnchor.constraint(equalToConstant: 24),
            arrowImageView.widthAnchor.constraint(equalToConstant: 24),
            
            stackPhotos.topAnchor.constraint(equalTo: photosLabel.bottomAnchor, constant: 12),
            stackPhotos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            stackPhotos.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            stackPhotos.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            stackPhotos.heightAnchor.constraint(equalToConstant: height)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }

}
