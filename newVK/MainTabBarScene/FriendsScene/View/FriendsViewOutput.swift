//
//  FriendsViewOutput.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation
import UIKit

/// Исходящий протокол сцены "Друзья".
protocol FriendsViewOutput {
    /// Загрузить друзей.
    func loadFriendsData()
    ///  Обработать нажатие на ячейку.
    func cellTapAction(userId: Int)
    /// Загрузить фото, используя кеш.
    func loadPhotoFromCache(url: String, completion: @escaping (UIImage) -> Void)
}
