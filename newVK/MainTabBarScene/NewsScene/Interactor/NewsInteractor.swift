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
    private let photoCacheService: PhotoCacheService
    
    /// Инициализатор сервиного слоя сцены "Новости".
    init(service: NewsServiceInput = NewsService(),
         imageProvider: ImageLoaderHelperProtocol,
         photoCacheService: PhotoCacheService) {
        self.service = service
        self.imageProvider = imageProvider
        self.photoCacheService = photoCacheService
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
    
    // Загружаем фото, используя кеш.
    func loadPhotoFromCache(url: String, completion: @escaping (UIImage) -> Void) {
        // Проверка на источник загрузки.
        if let photo = photoCacheService.images[url] {
            completion(photo)
        } else if let photo = photoCacheService.getImageFromCache(url: url) {
            completion(photo)
        } else {
            // Загружаем фото по URL.
            loadPhotoFromURL(url: url) { photo in
                // Сохраняем фото в кеш.
                self.photoCacheService.saveImageToCache(url: url, image: photo)
                // Пробрасываем в completion.
                completion(photo)
            }
        }
    }
}

// MARK: - Private
extension NewsInteractor {
    // Загружаем фото по URL.
    func loadPhotoFromURL(url: String, completion: @escaping (UIImage) -> Void) {
        imageProvider.loadImage(url: url) { image in
            completion(image)
        }
    }
}
