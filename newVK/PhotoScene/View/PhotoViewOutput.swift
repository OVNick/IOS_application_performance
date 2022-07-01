//
//  PhotoViewOutput.swift
//  newVK
//
//  Created by Николай Онучин on 12.05.2022.
//

import Foundation
import UIKit

/// Исходящий протокол сцены "Фото".
protocol PhotoViewOutput {
    /// Загрузить фото.
    func loadPhotoData()
    /// Загрузить фото, используя кеш.
    func loadPhotoFromCache(url: String, completion: @escaping (UIImage) -> Void)
}
