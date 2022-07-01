//
//  GroupsInteractor.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation
import UIKit

/// Интерактор сцены "Группы".
final class GroupsInteractor {
    
    /// Свойство, отвечающее за сервисный слой сцены "Группы".
    private let service: GroupsServiceInput
    private let imageProvider: ImageLoaderHelperProtocol
    private let photoCacheService: PhotoCacheService

    /// Инициализатор сервиного слоя сцены "Группы".
    init(service: GroupsServiceInput = GroupsService(),
         imageProvider: ImageLoaderHelperProtocol,
         photoCacheService: PhotoCacheService) {
        self.service = service
        self.imageProvider = imageProvider
        self.photoCacheService = photoCacheService
    }
}


// MARK: - GroupsInteractorInput

extension GroupsInteractor: GroupsInteractorInput {
    // Загружаем группы.
    func loadGroups(completion: @escaping ([DTO.GroupsScene.Group]) -> Void) {
        service.getURL()
            .then(on: .global(), service.getData(_:))
            .then(service.getParsedData(_:))
            .done(on: .main) { data in
                completion(data)
            }.catch { error in
                print(error)
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

extension GroupsInteractor {
    // Загружаем фото по URL.
    func loadPhotoFromURL(url: String, completion: @escaping (UIImage) -> Void) {
        imageProvider.loadImage(url: url) { image in
            completion(image)
        }
    }
}
