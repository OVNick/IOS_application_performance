//
//  NewsAssembly.swift
//  newVK
//
//  Created by Николай Онучин on 05.06.2022.
//

import UIKit

/// Сборщик сцены "Новости".
final class NewsAssembly {
    /// Создать сцену "Новости".
    /// - Returns: ViewController.
    static func makeNewsListVC() -> UIViewController {
        let imageLoader = ImageLoaderHelper()
        let vc = NewsViewController()
        let interactor = NewsInteractor(imageProvider: imageLoader)
        let presenter = NewsPresenter(interactor: interactor)
        vc.output = presenter
        presenter.view = vc
        return vc
    }
}
