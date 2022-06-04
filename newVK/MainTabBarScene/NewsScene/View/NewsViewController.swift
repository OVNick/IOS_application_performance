//
//  NewsViewController.swift
//  newVK
//
//  Created by Николай Онучин on 05.05.2022.
//

import UIKit

final class NewsViewController: UIViewController {
    /// Идентификатор ячейки с автором.
    private let writerCellIdentifire = "NewsWriterCell"
    /// Идентификатор ячейки с текстом.
    private let textCellIdentifire = "NewsTextCell"
    /// Идентификатор ячейки с текстом.
    private let photoCellIdentifire = "NewsPhotoCell"
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
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard
                let writerCell = tableView.dequeueReusableCell(withIdentifier: writerCellIdentifire) as? NewsWriterCell
            else {
                return UITableViewCell()
            }
            writerCell.configureNewsWriterCell()
            return writerCell
        case 1:
            guard
                let textCell = tableView.dequeueReusableCell(withIdentifier: textCellIdentifire) as? NewsTextCell
            else {
                return UITableViewCell()
            }
            textCell.configureNewsTextCell()
            return textCell
        case 2:
            guard
                let photoCell = tableView.dequeueReusableCell(withIdentifier: photoCellIdentifire) as? NewsPhotoCell
            else {
                return UITableViewCell()
            }
            photoCell.configureNewsPhotoCell()
            return photoCell
        case 3:
            guard
                let ratingCell = tableView.dequeueReusableCell(withIdentifier: ratingCellIdentifire) as? NewsRatingCell
            else {
                return UITableViewCell()
            }
            ratingCell.configureNewsRatingCell()
            return ratingCell
        default:
            return UITableViewCell()
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
        tableView.register(NewsWriterCell.self, forCellReuseIdentifier: writerCellIdentifire)
        tableView.register(NewsTextCell.self, forCellReuseIdentifier: textCellIdentifire)
        tableView.register(NewsPhotoCell.self, forCellReuseIdentifier: photoCellIdentifire)
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
