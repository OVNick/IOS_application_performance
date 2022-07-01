//
//  NewsRatingCell.swift
//  newVK
//
//  Created by Николай Онучин on 29.05.2022.
//

import UIKit

/// Ячейка, отображающая рейтинг новости.
final class NewsRatingCell: UITableViewCell {
    /// Высота ячейки.
    private let heightCell: CGFloat = 48
    
    /// Фон ячейки.
    private lazy var backgroundCell: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    /// Стек содержащий лайки.
    private lazy var stackLikeView: UIStackView = {
        let view = UIStackView()
        
        view.backgroundColor = .white
        view.spacing = 4
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Стек содержащий комменты.
    private lazy var stackCommentView: UIStackView = {
        let view = UIStackView()
        
        view.backgroundColor = .white
        view.spacing = 4
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Стек содержащий репосты.
    private lazy var stackRepostView: UIStackView = {
        let view = UIStackView()
        
        view.backgroundColor = .white
        view.spacing = 4
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Стек содержащий просмотры
    private lazy var stackViewsView: UIStackView = {
        let view = UIStackView()
        
        view.backgroundColor = .white
        view.spacing = 4
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Общий стек.
    private lazy var stackRatingView: UIStackView = {
        let view = UIStackView()
        
        view.backgroundColor = .white
        view.spacing = 48
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    /// Изображение лайка.
    private var iconLike: UIImage = UIImage() {
        didSet {
            likeImageView.backgroundColor = .white
            likeImageView.image = iconLike
        }
    }
    /// Изображение коммента.
    private var iconComment: UIImage = UIImage() {
        didSet {
            commentImageView.backgroundColor = .white
            commentImageView.image = iconComment
        }
    }
    /// Изображение репоста.
    private var iconRepost: UIImage = UIImage() {
        didSet {
            repostImageView.backgroundColor = .white
            repostImageView.image = iconRepost
        }
    }
    
    
    /// Лайк.
    private lazy var likeImageView: UIImageView = {
        let view = UIImageView()
        
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.tintColor = .gray
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Коммент.
    private lazy var commentImageView: UIImageView = {
        let view = UIImageView()
        
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.tintColor = .gray
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Репост.
    private lazy var repostImageView: UIImageView = {
        let view = UIImageView()
        
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.tintColor = .gray
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Просмотры.
    private lazy var viewsImageView: UIImageView = {
        let view = UIImageView()
        
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFit
        view.tintColor = .gray
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    ///  Кол-во лайков.
    private lazy var likeCount: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    ///  Кол-во комментов.
    private lazy var commentCount: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    ///  Кол-во репостов.
    private lazy var repostCount: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    ///  Кол-во просмотров.
    private lazy var viewsCount: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    /// Инициализатор ячейки.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Конфигуратор ячейки.
    func configureNewsRatingCell(likeImage: UIImage?,
                                 commentImage: UIImage?,
                                 repostImage: UIImage?,
                                 viewsImage: UIImage?,
                                 like: String?,
                                 comment: String?,
                                 repost: String?,
                                 views: String?) {
        
        likeImageView.image = likeImage
        commentImageView.image = commentImage
        repostImageView.image = repostImage
        viewsImageView.image = viewsImage
        
        likeCount.text = like
        commentCount.text = comment
        repostCount.text = repost
        viewsCount.text = views
    }
}


// MARK: - Private
private extension NewsRatingCell {
    /// Установка View.
    func setupSubviews() {
        contentView.addSubview(backgroundCell)
        
        [likeImageView, likeCount].forEach { stackLikeView.addArrangedSubview($0) }
        [commentImageView, commentCount].forEach { stackCommentView.addArrangedSubview($0) }
        [repostImageView, repostCount].forEach { stackRepostView.addArrangedSubview($0) }
        [viewsImageView, viewsCount].forEach { stackViewsView.addArrangedSubview($0) }
        [stackLikeView, stackCommentView, stackRepostView, stackViewsView].forEach { stackRatingView.addArrangedSubview($0) }
        
        backgroundCell.addSubview(stackRatingView)
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            backgroundCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            backgroundCell.heightAnchor.constraint(equalToConstant: heightCell),
            
            stackRatingView.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 4),
            stackRatingView.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -4),
            stackRatingView.centerXAnchor.constraint(equalTo: backgroundCell.centerXAnchor),
            
            likeImageView.widthAnchor.constraint(equalToConstant: 32),
            
            commentImageView.widthAnchor.constraint(equalToConstant: 32),
            
            repostImageView.widthAnchor.constraint(equalToConstant: 32),
            
            viewsImageView.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}
