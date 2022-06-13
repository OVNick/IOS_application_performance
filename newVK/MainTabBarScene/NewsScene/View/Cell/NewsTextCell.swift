//
//  NewsTextCell.swift
//  newVK
//
//  Created by Николай Онучин on 29.05.2022.
//

import UIKit

/// Ячейка, отображающая текст новости.
final class NewsTextCell: UITableViewCell {
    
    /// Фон ячейки.
    private lazy var backgroundCell: UIView = {
        let view = UIView()
        
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    /// Текст новости.
    private lazy var title: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 6
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
    func configureNewsTextCell(text: String?) {
        title.text = text
    }
}

// MARK: - Private
private extension NewsTextCell {
    /// Установка View.
    func setupSubviews() {
        contentView.addSubview(backgroundCell)
        backgroundCell.addSubview(title)
        
        NSLayoutConstraint.activate([
            backgroundCell.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            backgroundCell.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            backgroundCell.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            backgroundCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            title.topAnchor.constraint(equalTo: backgroundCell.topAnchor, constant: 8),
            title.bottomAnchor.constraint(equalTo: backgroundCell.bottomAnchor, constant: -8),
            title.leftAnchor.constraint(equalTo: backgroundCell.leftAnchor, constant: 16),
            title.rightAnchor.constraint(equalTo: backgroundCell.rightAnchor, constant: -16),
        ])
    }
}
