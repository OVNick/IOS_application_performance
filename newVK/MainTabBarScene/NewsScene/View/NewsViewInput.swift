//
//  NewsViewInput.swift
//  newVK
//
//  Created by Николай Онучин on 04.06.2022.
//

import Foundation

/// Входящий протокол сцены "Новости".
protocol NewsViewInput: AnyObject {
    /// Установить новости в таблицу.
    func setNews(newsItemModel: [[NewsItemModel.CellType?]])
}
