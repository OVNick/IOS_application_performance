//
//  GroupsViewController.swift
//  newVK
//
//  Created by Николай Онучин on 05.05.2022.
//

import UIKit

/// Контроллер сцены "Группы".
final class GroupsViewController: UIViewController {
    
    /// Идентификатор ячейки.
    let cellIdentifire = "GroupsCell"
    
    /// Массив групп.
    private var groups: [GroupItemModel] = []
    
    ///  Свойство, обрабатывающее исходящие события.
    var output: GroupsViewOutput?
        
    /// Таблица для отображения групп.
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
        output?.loadGroupsData()
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource

extension GroupsViewController: UITableViewDelegate, UITableViewDataSource {
        
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire) as? GroupCell
        else {
            return UITableViewCell()
        }
        
        let item = groups[indexPath.row]
        
        DispatchQueue.global(qos: .userInteractive).async {
            self.output?.loadPhotoFromCache(url: item.icon) { image in
                DispatchQueue.main.async {
                    cell.configureCell(name: item.title, avatar: image)
                }
            }
        }
        
        return cell
    }
}


// MARK: - GroupsViewInput

extension GroupsViewController: GroupsViewInput {
    
    // Устанавливаем группы в таблицу.
    func setGroups(groups: [GroupItemModel]) {
        self.groups = groups
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


// MARK: - Private

private extension GroupsViewController {
    
    /// Настройка и установка таблицы групп.
    func setupTableView() {
        tableView.backgroundColor = .white
        tableView.frame = self.view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.register(GroupCell.self, forCellReuseIdentifier: cellIdentifire)
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black,
                                                                   NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
        view.addSubview(tableView)
    }
    
    /// Установка констрейнтов для таблицы групп.
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
