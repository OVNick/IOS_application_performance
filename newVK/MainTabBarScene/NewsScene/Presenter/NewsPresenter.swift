//
//  NewsPresenter.swift
//  newVK
//
//  Created by Николай Онучин on 04.06.2022.
//

import Foundation
import UIKit

/// Презентер сцены "Новости".
final class NewsPresenter {
    
    // Ссылки на элементы модуля.
    weak var view: NewsViewInput?
    private let interactor: NewsInteractorInput
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH:mm"
        df.timeZone = TimeZone(abbreviation: "UTS")
        return df
    }()
    
    /// Инициализатор сцены "Новости".
    init(interactor: NewsInteractorInput) {
        self.interactor = interactor
    }
}

// MARK: - NewsViewOutput

extension NewsPresenter: NewsViewOutput {
    // Загружаем новости.
    func loadNewsData() {
        interactor.loadNews { [weak self] news in
            guard let self = self else { return }
            let items = self.formNewsArray(from: news)
            self.view?.setNews(newsItemModel: items)
        }
    }

    // Загружаем фото из кеша.
    func loadPhotoFromCache(url: String, completion: @escaping (UIImage) -> Void) {
        interactor.loadPhotoFromCache(url: url) { image in
            completion(image)
        }
    }
}

// MARK: - Private

private extension NewsPresenter {
    
    /// Формирование экземпляра "Автор".
    private func formAuthorObject(sourceId: Int?,
                                  profiles: [Profile],
                                  groups: [Group],
                                  timeIntervalSince1970: Int?) -> NewsItemModel.CellType? {
        
        var imageURL: String
        var firstName: String?
        var lastName: String? = nil
        var date: String?
        
        guard let id = sourceId else {
            return nil
        }
        
        if id > 0 {
            imageURL = profiles.first(where: { $0.id == id })?.photo50 ?? ""
            firstName = profiles.first(where: { $0.id == id })?.firstName
            lastName = profiles.first(where: { $0.id == id })?.lastName
        } else {
            imageURL = groups.first(where: { $0.id == -id })?.photo50 ?? ""
            firstName = groups.first(where: { $0.id == -id })?.name
        }
        
        date = formDate(timeIntervalSince1970: timeIntervalSince1970)
        
        return NewsItemModel.CellType.author(imageURL, firstName, lastName, date)
    }
    
    /// Формирование свойства "Дата".
    private func formDate(timeIntervalSince1970: Int?) -> String? {
        guard let date = timeIntervalSince1970 else {
            return nil
        }
        
        let newFormatDate = Date(timeIntervalSince1970: Double(date))
        
        return dateFormatter.string(from: newFormatDate)
    }
    
    /// Формирование экземпляра "Текст".
    private func formTextObject(text: String?) -> NewsItemModel.CellType? {
        
        guard let textNews = text else {
            return nil
        }
        guard textNews != "" else {
            return nil
        }
        
        return NewsItemModel.CellType.text(textNews)
    }
    
    /// Формирование экземпляра "Вложения".
    private func formAttachmentsObject(attachments: [ItemAttachment]?) -> NewsItemModel.CellType? {
        
        guard let arrayItemAttachments = attachments else {
            return nil
        }
        
        var arrayAttachments = arrayItemAttachments.compactMap { item -> AttachmentType? in
            let type = item.type
            return type
        }
        
        arrayAttachments = arrayAttachments.compactMap{ $0 }
        
        let photoURL = attachments?.first?.photo?.sizes?.last?.url
        
        return NewsItemModel.CellType.attachments(arrayAttachments, photoURL)
    }
    
    /// Формирование экземпляра "Рейтинг".
    private func formRatingObject(like: Likes?,
                                  comments: Comments?,
                                  reposts: Reposts?,
                                  views: Views?) -> NewsItemModel.CellType? {
        
        return NewsItemModel.CellType.rating(like?.canLike,
                                             like?.count,
                                             like?.userLikes,
                                             like?.canPublish,
                                             comments?.canPost,
                                             comments?.count,
                                             reposts?.count,
                                             reposts?.userReposted,
                                             views?.count)
    }
    
    /// Формирование массива новостей.
    func formNewsArray(from newsModel: NewsModel?) -> [[NewsItemModel.CellType?]] {
        
        guard let model = newsModel else {
            return []
        }
        guard let profiles = model.response.profiles else {
            return []
        }
        guard let groups = model.response.groups else {
            return []
        }
        
        let newsArray = model.response.items.compactMap { item -> [NewsItemModel.CellType?] in
            let element = NewsItemModel.init(author: formAuthorObject(sourceId: item.sourceID,
                                                                      profiles: profiles,
                                                                      groups: groups,
                                                                      timeIntervalSince1970: item.date),
                                             text: formTextObject(text: item.text),
                                             attachments: formAttachmentsObject(attachments: item.attachments),
                                             rating: formRatingObject(like: item.likes,
                                                                      comments: item.comments,
                                                                      reposts: item.reposts,
                                                                      views: item.views))
            
            // Удаляем элемнты nil из массива.
            let array = element.array.compactMap{ $0 }
            
            return array
        }
        
        return newsArray
    }
}
