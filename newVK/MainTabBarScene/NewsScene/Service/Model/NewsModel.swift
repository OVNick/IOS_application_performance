//
//  NewsModel.swift
//  newVK
//
//  Created by Николай Онучин on 04.06.2022.
//

import Foundation

/// Модель для парсинга новостей.
enum NewsModel {
    struct Response:Decodable {
        let response: Items
        let profiles: Profiles
        let groups: Groups
        let nextFrom: String
        
        enum CodingKeys: String, CodingKey {
            case response = "response"
            case profiles = "profiles"
            case groups = "groups"
            case nextFrom = "next_from"
        }
    }
    
    // MARK: - Items
    struct Items: Decodable {
        let items: [News]
    }
    
    struct News: Decodable {
        let sourceId: String
        let date: Int
        let text: String
        let attachments: [Attachments]
        let comments: Comments
        let reposts: Reposts
        let views: Views
        
        enum CodingKeys: String, CodingKey {
            case sourceId = "source_id"
            case date = "date"
            case text = "text"
            case attachments = "attachments"
            case comments = "comments"
            case reposts = "reposts"
            case views = "views"
        }
    }
    
    struct Comments: Decodable {
        let canPost: Int
        let count: Int
        let groupsCanPost: Bool
        
        enum CodingKeys: String, CodingKey {
            case canPost = "can_post"
            case count = "count"
            case groupsCanPost = "groups_can_post"
        }
    }
    
    struct Likes: Decodable {
        let canLike: Int
        let count: Int
        let userLikes: Int
        let canPublish: Int
        
        enum CodingKeys: String, CodingKey {
            case canLike = "can_like"
            case count = "count"
            case userLikes = "user_likes"
            case canPublish = "can_publish"
        }
    }
    
    struct Reposts: Decodable {
        let count: Int
        let userReposted: Int
        
        enum CodingKeys: String, CodingKey {
            case count = "count"
            case userReposted = "user_reposted"
        }
    }
    
    struct Views: Decodable {
        let count: Int
        
        enum CodingKeys: String, CodingKey {
            case count = "count"
        }
    }
        
    struct Attachments: Decodable {
        let type: String
        let photo: [Photo]
        let video: [Video]
        let audio: [Audio]
        let link: [Link]
        
        enum CodingKeys: String, CodingKey {
            case type = "type"
            case photo = "photo"
            case video = "video"
            case audio = "audio"
            case link = "link"
        }
    }
    
    struct Photo: Decodable {
        let ownerId: Int
        let sizes: [Sizes]
        
        enum CodingKeys: String, CodingKey {
            case ownerId = "owner_id"
            case sizes = "sizes"
        }
    }
    
    struct Sizes: Decodable {
        let height: Int
        let width: Int
        let url: String
        let type: String
        
        enum CodingKeys: String, CodingKey {
            case height = "height"
            case width = "width"
            case url = "url"
            case type = "type"
        }
    }
    
    struct Video: Decodable {
        let title: String
        let image: [Image]
        
        enum CodingKeys: String, CodingKey {
            case title = "title"
            case image = "image"
        }
    }
    
    struct Image: Decodable {
        let url: String
        let width: Int
        let height: Int
        
        enum CodingKeys: String, CodingKey {
            case url = "url"
            case height = "height"
            case width = "width"
        }
    }
    
    struct Audio: Decodable {
        let artist: String
        let title: String
        
        enum CodingKeys: String, CodingKey {
            case artist = "artist"
            case title = "title"
        }
    }
    
    struct Link: Decodable {
        let url: String
        let title: String
        let caption: String
        let photo: [Photo]
        
        enum CodingKeys: String, CodingKey {
            case url = "url"
            case title = "title"
            case caption = "caption"
            case photo = "photo"
        }
    }
        
    // MARK: - Profiles
    struct Profiles: Decodable {
        let profiles: [User]
    }
    
    struct User: Decodable {
        let id: Int
        let firstName: String
        let lastName: String
        let photo50: String
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case firstName = "first_name"
            case lastName = "last_name"
            case photo50 = "photo_50"
        }
    }
    
    // MARK: - Groups
    struct Groups: Decodable {
        let groups: [Group]
    }
    
    struct Group: Decodable {
        let id: Int
        let name: String
        let photo50: String
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case photo50 = "photo_50"
        }
    }
}
