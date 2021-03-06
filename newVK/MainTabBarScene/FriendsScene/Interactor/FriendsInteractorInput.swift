//
//  FriendsInteractorInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation
import UIKit

/// Входящий протокол интерактора  сцены "Друзья".
protocol FriendsInteractorInput {
    /// Загрузить друзей.
    func loadFriends(completion: @escaping ([DTO.FriendsScene.Friend]) -> Void)
    /// Загрузить id выбранного друга в DataManager.
    func loadId(userId: Int)
    /// Загрузить фото.
    func loadPhotoFromCache(url: String, completion: @escaping (UIImage) -> Void)
}
