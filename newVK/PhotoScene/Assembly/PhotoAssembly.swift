//
//  PhotoAssembly.swift
//  newVK
//
//  Created by Николай Онучин on 14.05.2022.
//

import UIKit

/// Сборщик сцены "Фото".
final class PhotoAssembly {
    static func makePhotoListVC() -> UIViewController {
        let imageLoader = ImageLoaderHelper()
        let photoCacheService = PhotoCacheService()
        let vc = PhotoViewController()
        let interactor = PhotoInteractor(imageProvider: imageLoader, photoCacheService: photoCacheService)
        let presenter = PhotoPresenter(interactor: interactor)
        
        vc.output = presenter
        presenter.view = vc
        
        return vc
    }
}
