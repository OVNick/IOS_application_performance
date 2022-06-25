//
//  GroupsInteractor.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation

/// Интерактор сцены "Группы".
final class GroupsInteractor {
    
    /// Свойство, отвечающее за сервисный слой сцены "Группы".
    private let service: GroupsServiceInput

    /// Инициализатор сервиного слоя сцены "Группы".
    init(service: GroupsServiceInput = GroupsService()) {
        self.service = service
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
}
