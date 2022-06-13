//
//  NewsModel.swift
//  newVK
//
//  Created by Николай Онучин on 04.06.2022.
//

import Foundation

// MARK: - NewsModel
struct NewsModel: Codable {
    let response: NewsResponse
}

// MARK: - Response
struct NewsResponse: Codable {
    let items: [Item]
    let profiles: [Profile]?
    let groups: [Group]?
    let nextFrom: String?

    enum CodingKeys: String, CodingKey {
        case items = "items"
        case profiles = "profiles"
        case groups = "groups"
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
    let id: Int?
    let name: String?
    let photo50: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case photo50 = "photo_50"
    }
}

// MARK: - Item
struct Item: Codable {
    let sourceID, date: Int?
    let text: String?
    let attachments: [ItemAttachment]?
    let comments: Comments?
    let likes: Likes?
    let reposts: Reposts?
    let views: Views?

    enum CodingKeys: String, CodingKey {
        case sourceID = "source_id"
        case date = "date"
        case text = "text"
        case attachments = "attachments"
        case comments = "comments"
        case likes = "likes"
        case reposts = "reposts"
        case views = "views"
    }
}

// MARK: - ItemAttachment
struct ItemAttachment: Codable {
    let type: AttachmentType?
    let photo: Photo?
    //let link: Link?
    //let video: Video?
    //let audio: Audio?
}

//// MARK: - Audio
//struct Audio: Codable {
//    let artist: String?
//    let id: String?
//    let title: String?
//
//    enum CodingKeys: String, CodingKey {
//        case artist = "artist"
//        case id = "id"
//        case title = "title"
//    }
//}

//// MARK: - Link
//struct Link: Codable {
//    let url: String?
//    let title, caption, linkDescription: String?
//    let photo: Photo?
//    let isFavorite: Bool?
//    let target: String?
//
//    enum CodingKeys: String, CodingKey {
//        case url, title, caption
//        case linkDescription = "description"
//        case photo
//        case isFavorite = "is_favorite"
//        case target
//    }
//}

// MARK: - Photo
struct Photo: Codable {
    let sizes: [Size]?

    enum CodingKeys: String, CodingKey {
        case sizes = "sizes"
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int?
    let url: String?
    let width: Int?

    enum CodingKeys: String, CodingKey {
        case height = "height"
        case url = "url"
        case width = "width"
    }
}

//enum Text: String, Codable {
//    case empty = ""
//}

enum AttachmentType: String, Codable {
    case audio = "audio"
    case link = "link"
    case photo = "photo"
    case postedPhoto = "posted_photo"
    case video = "video"
    case doc = "doc"
    case graffiti = "graffiti"
    case note = "note"
    case app = "app"
    case poll = "poll"
    case page = "page"
    case album = "album"
    case photosList = "photos_list"
    case market = "market"
    case marketAlbum = "market_album"
    case sticker = "sticker"
    case prettyCards = "pretty_cards"
    case event = "event"
}

//// MARK: - Video
//struct Video: Codable {
//    let accessKey: String?
//    let canComment, canLike, canRepost, canSubscribe: Int?
//    let canAddToFaves, canAdd, comments, date: Int?
//    let videoDescription: String?
//    let duration: Int?
//    let image, firstFrame: [Size]?
//    let width, height, id, ownerID: Int?
//    let title: String?
//    let isFavorite: Bool?
//    let trackCode: String?
//    let videoRepeat: Int?
//    let type: VideoType?
//    let views, contentRestricted: Int?
//    let contentRestrictedMessage, ovID, liveStatus: String?
//    let live, spectators: Int?
//
//    enum CodingKeys: String, CodingKey {
//        case accessKey = "access_key"
//        case canComment = "can_comment"
//        case canLike = "can_like"
//        case canRepost = "can_repost"
//        case canSubscribe = "can_subscribe"
//        case canAddToFaves = "can_add_to_faves"
//        case canAdd = "can_add"
//        case comments, date
//        case videoDescription = "description"
//        case duration, image
//        case firstFrame = "first_frame"
//        case width, height, id
//        case ownerID = "owner_id"
//        case title
//        case isFavorite = "is_favorite"
//        case trackCode = "track_code"
//        case videoRepeat = "repeat"
//        case type, views
//        case contentRestricted = "content_restricted"
//        case contentRestrictedMessage = "content_restricted_message"
//        case ovID = "ov_id"
//        case liveStatus = "live_status"
//        case live, spectators
//    }
//}

//enum VideoType: String, Codable {
//    case live = "live"
//    case video = "video"
//}

//// MARK: - CategoryAction
//struct CategoryAction: Codable {
//    let action: Action?
//    let name: String?
//}
//
//// MARK: - Action
//struct Action: Codable {
//    let target, type, url: String?
//}

// MARK: - Comments
struct Comments: Codable {
    let canPost, count: Int?

    enum CodingKeys: String, CodingKey {
        case canPost = "can_post"
        case count = "count"
    }
}

//// MARK: - CopyHistory
//struct CopyHistory: Codable {
//    let id, ownerID, fromID, date: Int?
//    let postType: PostTypeEnum?
//    let text: String?
//    let attachments: [CopyHistoryAttachment]?
//    let postSource: CopyHistoryPostSource?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case ownerID = "owner_id"
//        case fromID = "from_id"
//        case date
//        case postType = "post_type"
//        case text, attachments
//        case postSource = "post_source"
//    }
//}

//// MARK: - CopyHistoryAttachment
//struct CopyHistoryAttachment: Codable {
//    let type: AttachmentType?
//    let photo: Photo?
//    let video: Video?
//}

//// MARK: - CopyHistoryPostSource
//struct CopyHistoryPostSource: Codable {
//    let type: PostSourceType?
//}

//enum PostSourceType: String, Codable {
//    case api = "api"
//    case vk = "vk"
//}
//
//enum PostTypeEnum: String, Codable {
//    case post = "post"
//}

//// MARK: - Copyright
//struct Copyright: Codable {
//    let id: Int?
//    let link: String?
//    let type, name: String?
//}
//
//// MARK: - Donut
//struct Donut: Codable {
//    let isDonut: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case isDonut = "is_donut"
//    }
//}

// MARK: - Likes
struct Likes: Codable {
    let canLike, count, userLikes, canPublish: Int?

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case count = "count"
        case userLikes = "user_likes"
        case canPublish = "can_publish"
    }
}

//// MARK: - ItemPostSource
//struct ItemPostSource: Codable {
//    let type: PostSourceType?
//    let platform: Platform?
//}
//
//enum Platform: String, Codable {
//    case android = "android"
//    case iphone = "iphone"
//}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int?
}

// MARK: - Profile
struct Profile: Codable {
    let id: Int?
    let photo50: String?
    let firstName, lastName: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case photo50 = "photo_50"
        case firstName = "first_name"
        case lastName = "last_name"
    }
}

//// MARK: - OnlineInfo
//struct OnlineInfo: Codable {
//    let visible: Bool?
//    let lastSeen: Int?
//    let isOnline: Bool?
//    let appID: Int?
//    let isMobile: Bool?
//
//    enum CodingKeys: String, CodingKey {
//        case visible
//        case lastSeen = "last_seen"
//        case isOnline = "is_online"
//        case appID = "app_id"
//        case isMobile = "is_mobile"
//    }
//}
