//
//  NewsViewOutput.swift
//  newVK
//
//  Created by Николай Онучин on 04.06.2022.
//

import Foundation
import UIKit

/// Исходящий протокол сцены "Новости".
protocol NewsViewOutput {
    /// Загрузить новости.
    func loadNewsData()
    /// Загрузить фото, используя кеш.
    func loadPhotoFromCache(url: String, completion: @escaping (UIImage) -> Void)
}
