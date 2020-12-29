//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Егор Никитин on 13.11.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostTableViewCell: UITableViewCell {
    
    // MARK: Properties
    private lazy var authorLabel: UILabel = {
        let author = UILabel()
        author.toAutoLayout()
        author.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        author.textColor = .black
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
        image.backgroundColor = .black
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var likesLabel: UILabel = {
        let likes = UILabel()
        likes.toAutoLayout()
        likes.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        likes.textColor = .black
        return likes
    }()
    
    private lazy var viewsLabel: UILabel = {
        let views = UILabel()
        views.toAutoLayout()
        views.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        views.textColor = .black
        views.textAlignment = .right
        return views
    }()
    
    // MARK: Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SETUP
    internal func configure(post: Post) {
        authorLabel.text = post.author
        postImageView.image = UIImage(named: post.image)
        descriptionLabel.text = post.description
        likesLabel.text = "Likes: \(String(post.likes))"
        viewsLabel.text = "Views: \(String(post.views))"
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
