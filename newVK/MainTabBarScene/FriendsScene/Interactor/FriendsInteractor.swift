//
//  FriendsInteractor.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation
import UIKit

/// Интерактор сцены "Друзья".
final class FriendsInteractor {
    
    /// Свойство, отвечающее за сервисный слой сцены "Друзья".
    private let service: FriendsServiceInput
    private let imageProvider: ImageLoaderHelperProtocol
    private let photoCacheService: PhotoCacheService
    
    /// Инициализатор сервиного слоя сцены "Друзья".
    init(service: FriendsServiceInput = FriendsService(),
         imageProvider: ImageLoaderHelperProtocol,
         photoCacheService: PhotoCacheService) {
        self.service = service
        self.imageProvider = imageProvider
        self.photoCacheService = photoCacheService
    }
}


// MARK: - FriendsInteractorInput

extension FriendsInteractor: FriendsInteractorInput {
    
    // Загружаем id выбранного друга в DataManager.
    func loadId(userId: Int) {
        DataManager.id = userId
    }
    
    // Загружаем друзей.
    func loadFriends(completion: @escaping ([DTO.FriendsScene.Friend]) -> Void) {
        service.loadFriends { result in
            switch result {
            case .success(let friends):
                completion(friends)
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
extension FriendsInteractor {
    // Загружаем фото по URL.
    func loadPhotoFromURL(url: String, completion: @escaping (UIImage) -> Void) {
        imageProvider.loadImage(url: url) { image in
            completion(image)
        }
    }
}
