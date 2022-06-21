//
//  NewsService.swift
//  newVK
//
//  Created by Николай Онучин on 31.05.2022.
//

import Foundation

// MARK: - Error

/// Перечисления возможных ошибок.
enum NewsServiceError: Error {
    /// Ошибка парсинга.
    case parseError
    /// Ошибка запроса.
    case requestError(Error)
}

/// Cервис сцены "Новости".
final class NewsService: NewsServiceInput {
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    
    // MARK: - NewsServiceInput
    
    func loadNews(completion: @escaping ((Result<NewsModel, NewsServiceError>) -> ())) {
        // Получаем токен текущего пользователя из синглтона "Session".
        guard let token = Session.instance.token else { return }
        
        /// Массив с параметрами запроса.
        let params: [String: String] = [
            "v": "5.131",
            "access_token": token,
            "filters": "post, photo",
            "count": "99"
        ]
        
        /// URL запроса новостей текущего пользователя.
        let url: URL = .configureNewsURL(token: token,
                                         method: .newsfeedGet,
                                         httpMethod: .get,
                                         params: params)
        
        // Извлекаем содержимое URL-адреса и вызывает обработчик по завершении.
        let task = self.session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                if let error = error {
                    completion(.failure(.requestError(error)))
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(NewsModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch let someError{
                print(someError)
                completion(.failure(.parseError))
            }
        }
        task.resume()
    }
}

// MARK: - URL

extension URL {
    
    /// Конфигурируем URL запрос.
    static func configureNewsURL(token: String,
                                 method: Constants.Service.TypeMethods,
                                 httpMethod: Constants.Service,
                                 params: [String: String]) -> URL {
        var queryItems: [URLQueryItem] = []
        
        params.forEach { param, value in
            queryItems.append(URLQueryItem(name: param, value: value))
        }
        
        /// Конструктор URL.
        var urlComponents = URLComponents()
        urlComponents.scheme = Constants.Service.scheme.rawValue
        urlComponents.host = Constants.Service.host.rawValue
        urlComponents.path = method.rawValue
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            fatalError("URL is invalidate")
        }
        return url
    }
}
