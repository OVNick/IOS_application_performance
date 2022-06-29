//
//  NewsItemModel.swift
//  newVK
//
//  Created by Николай Онучин on 05.06.2022.
//

import Foundation
import UIKit

/// Модель представления новости.
struct NewsItemModel {
    /// Типы ячеек.
    enum CellType {
        /// (0: imageURL, 1: firstName, 2: lastName, 3: date)
        case author(String, String?, String?, String?)
        /// (0: text)
        case text(String?)
        /// ([0: type])
        case attachments([AttachmentType], String?)
        /// (0: canLike, 1: countLike, 2: userLikes, 3: canPublish, 4:  canPost, 5: countComment, 6: countReposted, 7: userReposted, 8: viewsCount)
        case rating(Int?, Int?, Int?, Int?, Int?, Int?, Int?, Int?, Int?)
    }
        
    let author: CellType?
    let text: CellType?
    let attachments: CellType?
    let rating: CellType?
    let array: [CellType?]
    
    init(author: CellType?,
         text: CellType?,
         attachments: CellType?,
         rating: CellType?) {
        self.author = author
        self.text = text
        self.attachments = attachments
        self.rating = rating
        self.array = [author, text, attachments, rating]
    }
}
