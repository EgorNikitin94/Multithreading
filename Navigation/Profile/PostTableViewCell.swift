//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Егор Никитин on 13.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    var cellConfigure: (author: String, image: UIImage?, description: String, likes: String, views: String)? {
        didSet {
            authorLabel.text = cellConfigure?.author
            postImageView.image = cellConfigure?.image
            descriptionLabel.text = cellConfigure?.description
            likesLabel.text = cellConfigure?.likes
            viewsLabel.text = cellConfigure?.views
        }
    }
    
    private lazy var authorLabel: UILabel = {
        let author = UILabel()
        author.toAutoLayout()
        author.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        author.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        author.numberOfLines = 2
        return author
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let description = UILabel()
        description.toAutoLayout()
        description.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        description.textColor = .systemGray
        description.numberOfLines = 0
        return description
    }()
    
    private lazy var postImageView: UIImageView = {
        let image = UIImageView()
        image.toAutoLayout()
        image.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var likesLabel: UILabel = {
        let likes = UILabel()
        likes.toAutoLayout()
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        return likes
    }()
    
    private lazy var viewsLabel: UILabel = {
        let views = UILabel()
        views.toAutoLayout()
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.textColor = UIColor.createColor(lightMode: .black, darkMode: .white)
        views.textAlignment = .right
        return views
    }()
    
    // MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupLayout()
        self.backgroundColor = UIColor.createColor(lightMode: .white, darkMode: .black)
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap))
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(doubleTapGestureRecognizer)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    @objc private func doubleTap() {
        print("doubleTap")
        CoreDataStack.sharedInstance.createObject(author: authorLabel.text,
                                                  description: descriptionLabel.text,
                                                  image: postImageView.image?.jpegData(compressionQuality: 1),
                                                  likes: likesLabel.text,
                                                  views: viewsLabel.text )

    }
    
    //MARK: SETUP
    
    func configure(_ favoritPost: FavoritPost) {
        authorLabel.text = favoritPost.author
        descriptionLabel.text = favoritPost.desc
        if let image = favoritPost.image {
            postImageView.image = UIImage(data: image)
        }
        likesLabel.text = favoritPost.likes
        viewsLabel.text = favoritPost.views
    }
    
    private func setupLayout() {
        contentView.addSubview(authorLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(likesLabel)
        contentView.addSubview(viewsLabel)
        
        let constraints = [
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            postImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.trailingAnchor.constraint(equalTo: contentView.centerXAnchor),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}

