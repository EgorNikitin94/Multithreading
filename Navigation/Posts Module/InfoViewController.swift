//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private let apiURL: URL? = URL(string: "https://jsonplaceholder.typicode.com/todos/6")
    
    private let starWarsPlanetsApiURL: URL? = URL(string: "https://swapi.dev/api/planets/1/")
    
    private var residentsURLs: [URL] = [] {
        didSet {
            loadResidents(from: residentsURLs)
        }
    }
    
    private var residents: [Resident] = [] {
        didSet {
            DispatchQueue.main.async {
                self.residentsTableView.reloadData()
            }
        }
    }
    
    private let cellID = "cellIDInfoVC"
    
    private let coordinator: ChildCoordinator
    
    private let showAlertButton: UIButton = {
        let button = UIButton()
        button.setTitle(LocalizableStrings.showAlert.rawValue.localize(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.toAutoLayout()
        return button
    }()
    
    private let titleLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.toAutoLayout()
        return $0
    }(UILabel())
    
    private let orbitalPeriodLabel: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 20)
        $0.textColor = .black
        $0.textAlignment = .center
        $0.toAutoLayout()
        return $0
    }(UILabel())
    
    private let residentsTableView: UITableView = {
        $0.toAutoLayout()
        return $0
    }(UITableView())
    
    // Mark: - init
    
    init(coordinator: ChildCoordinator) {
        self.coordinator = coordinator
        super .init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        residentsTableView.dataSource = self
        
        residentsTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        loadTitle(from: apiURL)
        
        loadPlanet(from: starWarsPlanetsApiURL)
        
    }
    
    private func loadTitle(from url: URL?) {
        if let url = url {
            NetworkService.dataTask(url: url) { (data) in
                if let data = data, let dictionary = try? NetworkService.toObject(json: data),  let title = dictionary["title"] as? String {
                    DispatchQueue.main.async {
                        self.titleLabel.text = title
                    }
                }
            }
        }
    }
    
    private func loadPlanet(from url: URL?) {
        if let url = url {
            var residentsURLsFunc: [URL] = []
            NetworkService.dataTask(url: url) { (data) in
                if let data = data, let planet = try? StarWarsPlanet(data: data) {
                    DispatchQueue.main.async {
                        self.orbitalPeriodLabel.text = "\(planet.name)'s orbital period is \(planet.orbitalPeriod)"
                        }
                    for string in planet.residents {
                        let url = URL(string: string)
                        guard let urlUnwrapped = url else { return }
                        residentsURLsFunc.append(urlUnwrapped)
                    }
                    self.residentsURLs = residentsURLsFunc
                    print(self.residentsURLs)
                }
            }
        }
    }
    
    private func loadResidents(from urls: [URL]) {
        var residentsFunc: [Resident] = []
        for url in urls {
            NetworkService.dataTask(url: url) { (data) in
                if let data = data, let resident = try? Resident(data: data) {
                    residentsFunc.append(resident)
                    print(resident.name)
                }
                self.residents = residentsFunc
            }
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .yellow
        view.addSubview(showAlertButton)
        view.addSubview(titleLabel)
        view.addSubview(orbitalPeriodLabel)
        view.addSubview(residentsTableView)
        
        NSLayoutConstraint.activate([
            showAlertButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            showAlertButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            showAlertButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            orbitalPeriodLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100),
            orbitalPeriodLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            residentsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            residentsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            residentsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            residentsTableView.topAnchor.constraint(equalTo: showAlertButton.bottomAnchor, constant: 20)
            
        ])
    }
    
    @objc private func showAlert() {
        let alertController = UIAlertController(title: LocalizableStrings.deletePost.rawValue.localize(), message: LocalizableStrings.postCannotBeRestored.rawValue.localize(), preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: LocalizableStrings.cancel.rawValue.localize(), style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: LocalizableStrings.delete.rawValue.localize(), style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
}




extension InfoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return residents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID)!
        cell.selectionStyle = .none
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = residents[indexPath.row].name
        return cell
    }
    
    
}
