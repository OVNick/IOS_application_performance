//
//  NewsInteractor.swift
//  newVK
//
//  Created by Николай Онучин on 04.06.2022.
//

import Foundation
import UIKit

/// Интерактор сцены "Новости".
final class NewsInteractor {
    /// Свойство, отвечающее за сервисный слой сцены "Новости".
    private let service: NewsServiceInput
    
    private let imageProvider: ImageLoaderHelperProtocol
    
    /// Инициализатор сервиного слоя сцены "Новости".
    init(service: NewsServiceInput = NewsService(), imageProvider: ImageLoaderHelperProtocol) {
        self.service = service
        self.imageProvider = imageProvider
    }
}

// MARK: - FriendsInteractorInput
extension NewsInteractor: NewsInteractorInput {
    // Загружаем новости с сервера.
    func loadNews(completion: @escaping (NewsModel) -> Void) {
        service.loadNews { result in
            switch result {
            case .success(let news):
                completion(news)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // Загружаем фото по URL.
    func loadPhotoFromURL(url: String, completion: @escaping (UIImage) -> Void) {
        imageProvider.loadImage(url: url) { image in
            completion(image)
        }
    }
}
