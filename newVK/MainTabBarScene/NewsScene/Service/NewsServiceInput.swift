//
//  NewsServiceInput.swift
//  newVK
//
//  Created by Николай Онучин on 04.06.2022.
//

import Foundation

/// Входящий протокол сервиса сцены "Новости".
protocol NewsServiceInput {
    /// Загрузить новости текущего пользователя.
    func loadNews(completion: @escaping ((Result<NewsModel, NewsServiceError>) -> ()))
}
