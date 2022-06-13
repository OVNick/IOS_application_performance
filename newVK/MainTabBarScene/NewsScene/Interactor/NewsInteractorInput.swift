//
//  NewsInteractorInput.swift
//  newVK
//
//  Created by Николай Онучин on 04.06.2022.
//

import Foundation
import UIKit

/// Входящий протокол интерактора  сцены "Новости".
protocol NewsInteractorInput {
    /// Загрузить новости.
    func loadNews(completion: @escaping (NewsModel) -> Void)
    /// Загрузить фото по URL.
    func loadPhotoFromURL(url: String, completion: @escaping (UIImage) -> Void)
}
