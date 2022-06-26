//
//  PhotoCacheService.swift
//  newVK
//
//  Created by Николай Онучин on 26.06.2022.
//

import Foundation
import UIKit

final class PhotoCacheService {
    /// Время жизни кеша.
    private let cacheLifeTime: TimeInterval = 5 * 24 * 60 * 60
    /// Cловарь с фото и url.
    var images = [String: UIImage]()
    
    /// Имя папки с изображениями.
    private static let pathName: String = {
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return pathName
        }
        
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url,
                                                     withIntermediateDirectories: true,
                                                     attributes: nil)
        }
        return pathName
    }()
    
    /// Метод, возвращающий путь к файлу для сохранения или загрузки.
    private func getFilePath(url: String) -> String? {
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        let hashName = url.split(separator: "/").last ?? "default"
        
        return cachesDirectory.appendingPathComponent(PhotoCacheService.pathName + "/" + hashName).path
    }
    
    /// Сохранение изображения в файловой системе.
    func saveImageToCache(url: String, image: UIImage) {
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        
        FileManager.default.createFile(atPath: fileName,
                                       contents: data,
                                       attributes: nil)
    }
    
    /// Загрузка фото из кеша.
    func getImageFromCache(url: String) -> UIImage? {
        guard let fileName = getFilePath(url: url),
              let info = try? FileManager.default.attributesOfItem(atPath: fileName),
              let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard lifeTime <= cacheLifeTime,
              let image = UIImage(contentsOfFile: fileName) else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        
        return image
    }
}
