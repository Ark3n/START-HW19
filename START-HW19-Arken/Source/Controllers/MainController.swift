//
//  ViewController.swift
//  START-HW19-Arken
//
//  Created by Arken Sarsenov on 21.12.2023.
//

import UIKit
import Alamofire

final class MainController: UIViewController {
    
    // MARK: - Properties
    var characters: [Character]? {
        didSet {
            tableView.reloadData()
        }
    }
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        fetchData()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Fetch data
    func fetchData() {
        let url = NetworkService.getURL()
        AF.request(url).responseDecodable(of: Result.self) { response in
            switch response.result {
            case .success(let result):
                // Handle successful response
                let characters = result.data.results
                self.characters = characters
            case .failure(let error):
                // Handle error
                print("Error: \(error)")
            }
        }
    }
    
    // MARK: - setup View
    private func setupUI(){
        view.addSubview(tableView)
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource
extension MainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        characters?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let characters = characters else { fatalError("NO data") }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {return UITableViewCell()}
        let character = characters[indexPath.row]
        cell.configureCell(character: character)
        return cell
    }
}
// MARK: - UITableViewDelegate
extension MainController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let characters = characters else { return }
        let vc = DetailedController()
        let charachter = characters[indexPath.row]
        vc.character = charachter
        navigationController?.pushViewController(vc, animated: true)
    }
}

