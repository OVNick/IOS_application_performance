//
//  NewsAttachmentsCell.swift
//  newVK
//
//  Created by Николай Онучин on 29.05.2022.
//

import UIKit

/// Ячейка, отображающая фото.
final class NewsAttachmentsCell: UITableViewCell {
    
    /// Фон ячейки.
    private lazy var backgroundCell: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    /// Изображение.
    private var icon: UIImage = UIImage() {
        didSet {
            iconImageView.image = icon
        }
    }
    
    /// Фото.
    var iconImageView: UIImageView = {
        let view = UIImageView()
        
        view.contentMode = .scaleAspectFill
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    ///  Временный лейбл для вывода типа attachments.
    private lazy var title: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.black
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
    func configureNewsAttachmentsCell(attachmentsType: String?, photo: UIImage?) {
        // Буду конфигурировать ячейку в зависимости от типа вложений
        iconImageView.image = photo
        title.text = attachmentsType
    }
}


// MARK: - Private
private extension NewsAttachmentsCell {
    /// Установка View.
    func setupSubviews() {
        
        contentView.addSubview(backgroundCell)
        backgroundCell.addSubview(iconImageView)
        backgroundCell.addSubview(title)
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            backgroundCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            backgroundCell.heightAnchor.constraint(equalToConstant: contentView.frame.width),
            
            iconImageView.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 4),
            iconImageView.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -4),
            iconImageView.leftAnchor.constraint(equalTo: backgroundCell.leftAnchor, constant: 0),
            iconImageView.rightAnchor.constraint(equalTo: backgroundCell.rightAnchor, constant: 0),
            
            title.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 8),
            title.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -8),
            title.centerXAnchor.constraint(equalTo: backgroundCell.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: backgroundCell.centerYAnchor),
        ])
    }
}
