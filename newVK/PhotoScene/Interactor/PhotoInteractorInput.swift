//
//  PhotoInteractorInput.swift
//  newVK
//
//  Created by Николай Онучин on 14.05.2022.
//

import Foundation
import UIKit

/// Входящий протокол интерактора  сцены "Фото".
protocol PhotoInteractorInput {
    /// Загрузить фото.
    func loadPhoto(completion: @escaping ([DTO.PhotoScene.Photo]) -> Void)
    /// Загрузить фото.
    func loadPhotoFromCache(url: String, completion: @escaping (UIImage) -> Void)
}
