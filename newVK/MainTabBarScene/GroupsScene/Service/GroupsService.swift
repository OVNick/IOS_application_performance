//
//  GroupsService.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation
import PromiseKit

// MARK: - Error

/// Перечисления возможных ошибок.
enum GroupsServiceError: Error {
    /// Ошибка парсинга.
    case parseError
    /// Ошибка запроса.
    case requestError(Error)
    /// Ошибка получения токена
    case getTokenError
}

final class GroupsService: GroupsServiceInput {
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        return session
    }()
    
    // MARK: - GroupsServiceInput
    
    func getURL() -> Promise<URL> {
        return Promise { resolver in
            // Получаем токен текущего пользователя из синглтона "Session".
            guard let token = Session.instance.token else {
                resolver.reject(GroupsServiceError.getTokenError)
                return
            }
            
            /// Массив с параметрами запроса.
            let params: [String: String] = [
                "v": "5.131",
                "access_token": token,
                "extended": "1",
                "fields": "photo_50"
            ]
            
            /// URL запроса групп текущего пользователя.
            let url: URL = .configureGroupsURL(token: token,
                                               method: .groupsGet,
                                               httpMethod: .get,
                                               params: params)
            resolver.fulfill(url)
        }
    }
    
    func getData(_ url: URL) -> Promise<Data> {
        return Promise { resolver in
            session.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    if let error = error {
                        resolver.reject(GroupsServiceError.requestError(error))
                    }
                    return
                }
                resolver.fulfill(data)
            }.resume()
        }
    }
    
    func getParsedData(_ data: Data) -> Promise<[DTO.GroupsScene.Group]> {
        return Promise { resolver  in
            do {
                let result = try JSONDecoder().decode(DTO.Response<DTO.GroupsScene.Group>.self, from: data).response.items
                resolver.fulfill(result)
            } catch {
                resolver.reject(GroupsServiceError.parseError)
            }
        }
    }
}

// MARK: - URL

extension URL {
    /// Конфигурируем URL запрос.
    static func configureGroupsURL(token: String,
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
