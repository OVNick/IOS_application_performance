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
        
        view.spacing = 4
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Стек содержащий комменты.
    private lazy var stackCommentView: UIStackView = {
        let view = UIStackView()
        
        view.spacing = 4
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Стек содержащий репосты.
    private lazy var stackRepostView: UIStackView = {
        let view = UIStackView()
        
        view.spacing = 4
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Общий стек.
    private lazy var stackRatingView: UIStackView = {
        let view = UIStackView()
        
        view.spacing = 96
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    /// Изображение лайка.
    private var iconLike: UIImage = UIImage() {
        didSet {
            iconLikeImageView.image = iconLike
        }
    }
    /// Изображение коммента.
    private var iconComment: UIImage = UIImage() {
        didSet {
            iconCommentImageView.image = iconComment
        }
    }
    /// Изображение репоста.
    private var iconRepost: UIImage = UIImage() {
        didSet {
            iconRepostImageView.image = iconRepost
        }
    }
    
    
    /// Лайк.
    private lazy var iconLikeImageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFit
        view.tintColor = .gray
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Коммент.
    private lazy var iconCommentImageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFit
        view.tintColor = .gray
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    /// Репост.
    private lazy var iconRepostImageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFit
        view.tintColor = .gray
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
      
    
    ///  Кол-во лайков.
    private lazy var like: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    ///  Кол-во комментов.
    private lazy var comment: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    ///  Кол-во репостов.
    private lazy var repost: UILabel = {
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
    func configureNewsRatingCell() {
        iconLikeImageView.image = UIImage(systemName: "suit.heart")
        iconCommentImageView.image = UIImage(systemName: "bubble.left")
        iconRepostImageView.image = UIImage(systemName: "arrowshape.turn.up.right")
        like.text = "105"
        comment.text = "51"
        repost.text = "6"
    }
}


// MARK: - Private
private extension NewsRatingCell {
    /// Установка View.
    func setupSubviews() {
        contentView.addSubview(backgroundCell)
        
        [iconLikeImageView, like].forEach { stackLikeView.addArrangedSubview($0) }
        [iconCommentImageView, comment].forEach { stackCommentView.addArrangedSubview($0) }
        [iconRepostImageView, repost].forEach { stackRepostView.addArrangedSubview($0) }
        [stackLikeView, stackCommentView, stackRepostView].forEach { stackRatingView.addArrangedSubview($0) }
        
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
            
            iconLikeImageView.widthAnchor.constraint(equalToConstant: 32),
            iconLikeImageView.widthAnchor.constraint(equalToConstant: 32),
            
            iconCommentImageView.widthAnchor.constraint(equalToConstant: 32),
            iconCommentImageView.widthAnchor.constraint(equalToConstant: 32),
            
            iconRepostImageView.widthAnchor.constraint(equalToConstant: 32),
            iconRepostImageView.widthAnchor.constraint(equalToConstant: 32),
        ])
    }
}
