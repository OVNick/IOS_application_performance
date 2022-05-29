//
//  NewsWriterCell.swift
//  newVK
//
//  Created by Николай Онучин on 29.05.2022.
//

import UIKit

/// Ячейка, отображающая автора новости.
final class NewsWriterCell: UITableViewCell {
    /// Высота ячейки.
    private let heightCell: CGFloat = 48
    
    /// Высота аватара.
    private let heightIcon: CGFloat = 48
    
    /// Изображение аватара.
    private var icon: UIImage = UIImage() {
        didSet {
            iconImageView.image = icon
        }
    }
    
    /// Аватар.
    private lazy var iconImageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = heightIcon/2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    /// Фон ячейки.
    private lazy var backgroundCell: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    /// Имя.
    private lazy var title: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    /// Фамилия.
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    /// Дата публикации.
    private lazy var publicationDate: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    /// Стек содержащий имя и фамилию.
    private lazy var stackTitleView: UIStackView = {
        let view = UIStackView()
        
        view.spacing = 4
        view.axis = .horizontal
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    func configureNewsWriterCell() {
        iconImageView.image = UIImage(named: "defaultImage")
        title.text = "Имя"
        subtitle.text = "Фамилия"
        publicationDate.text = "Дата публикации"
    }
}


// MARK: - Private
private extension NewsWriterCell {
    /// Установка View.
    func setupSubviews() {
        contentView.addSubview(backgroundCell)
        [title, subtitle].forEach { stackTitleView.addArrangedSubview($0) }
        [iconImageView, stackTitleView, publicationDate].forEach { backgroundCell.addSubview($0) }
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            backgroundCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            backgroundCell.heightAnchor.constraint(equalToConstant: heightCell),
            
            iconImageView.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
            iconImageView.leftAnchor.constraint(equalTo: backgroundCell.leftAnchor, constant: 16),
            iconImageView.heightAnchor.constraint(equalToConstant: heightIcon),
            iconImageView.widthAnchor.constraint(equalToConstant: heightIcon),
            
            stackTitleView.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 4),
            stackTitleView.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16),
            
            publicationDate.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -4),
            publicationDate.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 16)
        ])
    }
}
