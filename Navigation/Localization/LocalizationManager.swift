//
//  LocalizationManager.swift
//  Navigation
//
//  Created by Егор Никитин on 17.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

extension String {
    func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}


enum LocalizableStrings: String {
    case emailOrPhone = "Email or phone"
    case password = "Password"
    case createProfile = "Create profile"
    case welcome = "Welcome"
    case user = "User"
    case sighIn = "Sigh in"
    case pleaseFillInAllTheFields = "Please fill in all the fields!"
    case fillInTheLoginField = "Fill in the login field"
    case fillInThePasswordField = "Fill in the password field!"
    case errorWhileCreatingNewUser = "Error while creating a new user"
    case attention = "Attention!"
    case setStatus = "Set status"
    case photos = "Photos"
    case photoGallery = "Photo Gallery"
    case clear = "Clear"
    case favoritesPosts = "Favorites posts"
    case findPost = "Find post"
    case enterAuthor = "Enter author"
    case search = "Search"
    case cancel = "Cancel"
    case firstButton = "FirstButton"
    case secondButton = "SecondButton"
    case feed = "Feed"
    case edit = "Edit"
    case post = "Post"
    case showAlert = "Show Alert"
    case deletePost = "Delete post?"
    case postCannotBeRestored = "The post cannot be restored"
    case delete = "Delete"
    case profile = "Profile"
    case favorites = "Favorites"
}
