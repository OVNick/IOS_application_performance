//
//  GroupsViewOutput.swift
//  newVK
//
//  Created by Николай Онучин on 10.05.2022.
//

import Foundation
import UIKit

/// Исходящий протокол сцены "Группы".
protocol GroupsViewOutput {
    /// Загрузить группы.
    func loadGroupsData()
    /// Загрузить фото, используя кеш.
    func loadPhotoFromCache(url: String, completion: @escaping (UIImage) -> Void)
}
