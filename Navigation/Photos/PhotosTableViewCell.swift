//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Егор Никитин on 17.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    private var photosLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.text = "Photos"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private var arrowImageView: UIImageView = {
        let arrow = UIImageView()
        arrow.toAutoLayout()
        arrow.image = UIImage(systemName: "arrow.right")
        arrow.tintColor = .black
        return arrow
    }()
    
    private var photoOneImageView: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.layer.cornerRadius = 6
        photo.clipsToBounds = true
        photo.image = StoragePhotos.photos[0]
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    private var photoTwoImageView: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.layer.cornerRadius = 6
        photo.clipsToBounds = true
        photo.image = StoragePhotos.photos[1]
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    private var photoThreeImageView: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.layer.cornerRadius = 6
        photo.clipsToBounds = true
        photo.image = StoragePhotos.photos[2]
        photo.contentMode = .scaleAspectFill
        return photo
    }()
    
    private var photoFourImageView: UIImageView = {
        let photo = UIImageView()
        photo.toAutoLayout()
        photo.layer.cornerRadius = 6
        photo.clipsToBounds = true
        photo.image = StoragePhotos.photos[3]
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
