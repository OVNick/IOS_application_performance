//
//  GroupsInteractorInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation
import UIKit

/// Входящий протокол интерактора  сцены "Группы".
protocol GroupsInteractorInput {
    /// Загрузить группы.
    func loadGroups(completion: @escaping ([DTO.GroupsScene.Group]) -> Void)
    /// Загрузить фото.
    func loadPhotoFromCache(url: String, completion: @escaping (UIImage) -> Void)
}
