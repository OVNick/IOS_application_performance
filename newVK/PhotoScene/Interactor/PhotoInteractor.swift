//
//  PhotoInteractor.swift
//  newVK
//
//  Created by Николай Онучин on 14.05.2022.
//

import Foundation
import UIKit

/// Интерактор сцены "Фото".
final class PhotoInteractor {
    
    /// Свойство, отвечающее за сервисный слой сцены "Фото".
    private let service: PhotoServiceInput
    private let imageProvider: ImageLoaderHelperProtocol
    private let photoCacheService: PhotoCacheService

    /// Инициализатор сервиного слоя сцены "Фото".
    init(service: PhotoServiceInput = PhotoService(),
         imageProvider: ImageLoaderHelperProtocol,
         photoCacheService: PhotoCacheService) {
        self.service = service
        self.imageProvider = imageProvider
        self.photoCacheService = photoCacheService
    }
}


// MARK: - GroupsInteractorInput

extension PhotoInteractor: PhotoInteractorInput {
    // Загружаем фото.
    func loadPhoto(completion: @escaping ([DTO.PhotoScene.Photo]) -> Void) {
        service.loadPhoto { result in
            switch result {
            case .success(let photo):
                completion(photo)
            case .failure(_):
                return
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
extension PhotoInteractor {
    // Загружаем фото по URL.
    func loadPhotoFromURL(url: String, completion: @escaping (UIImage) -> Void) {
        imageProvider.loadImage(url: url) { image in
            completion(image)
        }
    }
}
