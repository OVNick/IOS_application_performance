//
//  GroupsServiceInput.swift
//  newVK
//
//  Created by Николай Онучин on 15.05.2022.
//

import Foundation
import PromiseKit

/// Входящий протокол сервиса сцены "Группы".
protocol GroupsServiceInput {
    func getURL() -> Promise<URL>
    func getData(_ url: URL) -> Promise<Data>
    func getParsedData(_ data: Data) -> Promise<[DTO.GroupsScene.Group]>
}
