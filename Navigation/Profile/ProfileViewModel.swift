//
//  ProfieViewModel.swift
//  Navigation
//
//  Created by Егор Никитин on 18.01.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

final class ProfileViewModel: ProfileViewControllerOutput {
    
    private let imageProcessor = ImageProcessor()
    
    public lazy var avatar: UIImage = {
        var image = UIImage()
        imageProcessor.processImage(sourceImage: #imageLiteral(resourceName: "Cat.jpeg"), filter: .noir) { (imageFilter) in
            image = imageFilter!
        }
        return image
    }()
    
    public func configurePost(post: Post) -> (author: String, image: UIImage?, description: String, likes: String, views: String) {
        let author = post.author
        let image = UIImage(named: post.image)
        let description = post.description
        let likes = "Likes: \(String(post.likes))"
        let views = "Views: \(String(post.views))"
        return (author, image, description, likes, views)
    }
    
    public func configurePhotos() -> [UIImage] {
        let photos = [StoragePhotos.photos[0], StoragePhotos.photos[1], StoragePhotos.photos[2], StoragePhotos.photos[3]]
        var photosWithFilters: [UIImage] = []
        for photo in photos {
            imageProcessor.processImage(sourceImage: photo, filter: .noir) { (image) in
                let photoIn = image!
                photosWithFilters.append(photoIn)
            }
        }
        return photosWithFilters
    }
    
}

