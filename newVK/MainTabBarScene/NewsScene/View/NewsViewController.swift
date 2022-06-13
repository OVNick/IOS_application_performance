//
//  NewsViewController.swift
//  newVK
//
//  Created by Николай Онучин on 05.05.2022.
//

import UIKit

/// Контроллер сцены "Новости".
final class NewsViewController: UIViewController {
    ///  Свойство, обрабатывающее исходящие события.
    var output: NewsViewOutput?
    
    /// Массив новостей.
    private var news: [[NewsItemModel.CellType?]] = [[]]
    
    /// Идентификатор ячейки с автором.
    private let writerCellIdentifire = "NewsAuthorCell"
    /// Идентификатор ячейки с текстом.
    private let textCellIdentifire = "NewsTextCell"
    /// Идентификатор ячейки с текстом.
    private let attachmentsCellIdentifire = "NewsAttachmentsCell"
    /// Идентификатор ячейки с текстом.
    private let ratingCellIdentifire = "NewsRatingCell"
    
    /// Таблица для отображения новостей.
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupConstraints()
        output?.loadNewsData()
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch news[indexPath.section][indexPath.row] {
            
        case .author(let imageURL, let firstName, let lastName, let date):
            guard
                let authorCell = tableView.dequeueReusableCell(withIdentifier: writerCellIdentifire) as? NewsAuthorCell
            else {
                return UITableViewCell()
            }
            
            DispatchQueue.global(qos: .userInteractive).async {
                self.output?.loadPhotoFromURL(url: imageURL) { image in
                    DispatchQueue.main.async {
                        authorCell.configureNewsAuthorCell(avatarImage: image, firstName: firstName, lastName: lastName, date: date)
                    }
                }
            }
            
            return authorCell
            
        case .text(let text):
            guard
                let textCell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifire) as? NewsTextCell
            else {
                return UITableViewCell()
            }
            
            textCell.configureNewsTextCell(text: text)
            
            return textCell
            
        case .attachments(let attachmentsArray):
            
            print(attachmentsArray)
            
            guard
                let attachmentsCell = tableView.dequeueReusableCell(withIdentifier: attachmentsCellIdentifire) as? NewsAttachmentsCell
            else {
                return UITableViewCell()
            }
            
            attachmentsCell.configureNewsAttachmentsCell()
            
            return attachmentsCell
            
        case .rating(let canLike,
                     let countLike,
                     let userLikes,
                     let canPublish,
                     let canPost,
                     let countComment,
                     let countReposted,
                     let userReposted,
                     let viewsCount):
            guard
                let ratingCell = tableView.dequeueReusableCell(withIdentifier: ratingCellIdentifire) as? NewsRatingCell
            else {
                return UITableViewCell()
            }
            
            ratingCell.configureNewsRatingCell(likeImage: canLike == 1 ? UIImage(systemName: "suit.heart") : nil,
                                               commentImage: canPost == 1 ? UIImage(systemName: "bubble.left") : nil,
                                               repostImage: canPublish == 1 ? UIImage(systemName: "arrowshape.turn.up.right") : nil,
                                               viewsImage: UIImage(systemName: "eye.fill"),
                                               like: canLike == 1 ? String(countLike ?? 0) : nil,
                                               comment: canPost == 1 ? String(countComment ?? 0) : nil,
                                               repost: canPublish == 1 ? String(countReposted ?? 0) : nil,
                                               views: String(viewsCount ?? 0))
            return ratingCell
            
        default:
            return UITableViewCell()
        }
    }
}

// MARK: - FriendsViewInput

extension NewsViewController: NewsViewInput {
    // Устанавливаем друзей в таблицу.
    func setNews(newsItemModel: [[NewsItemModel.CellType?]]) {
        self.news = newsItemModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


// MARK: - Private
private extension NewsViewController {
    /// Настройка и установка таблицы.
    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.frame = self.view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(NewsAuthorCell.self, forCellReuseIdentifier: writerCellIdentifire)
        tableView.register(NewsTextCell.self, forCellReuseIdentifier: textCellIdentifire)
        tableView.register(NewsAttachmentsCell.self, forCellReuseIdentifier: attachmentsCellIdentifire)
        tableView.register(NewsRatingCell.self, forCellReuseIdentifier: ratingCellIdentifire)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        view.addSubview(tableView)
    }
    
    /// Установка констрейнтов для таблицы.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
