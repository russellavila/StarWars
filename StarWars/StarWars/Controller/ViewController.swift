//
//  ViewController.swift
//  StarWars
//
//  Created by Consultant on 5/16/22.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var mainTableView: UITableView = {
        let tableview = UITableView(frame: .zero)
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.prefetchDataSource = self
        tableview.backgroundColor = .black
        tableview.register(StarWarsCell.self, forCellReuseIdentifier: StarWarsCell.reuseId)
        return tableview
    }()
    
    var nextOffset = 1
    let networkManager = NetworkManager()
    var pages: [Character] = []
    var planets: [Planet] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
        self.fetchCharacterPage()
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .magenta
        self.view.addSubview(self.mainTableView)
        
        self.mainTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        self.mainTableView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 8).isActive = true
        self.mainTableView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -8).isActive = true
        self.mainTableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -8).isActive = true
    }
    
    func fetchCharacterPage() {
        self.networkManager.fetchCharacter(offset: self.nextOffset) { [self] result in
            switch result {
            case .success(let page):
                
                self.pages.append(contentsOf: page.results)
                print("fetch up to " + pages[pages.count - 1].name)
                DispatchQueue.main.async {
                    self.mainTableView.reloadData()
                }
            case .failure(let err):
                print("Error: \(err.localizedDescription)")
                self.presentErrorAlert(title: "NetworkError", message: err.localizedDescription)
            }
        }
    }
    
    /*func fetchPlanet(urlPath: String) {
        self.networkManager.fetchPlanetInfo(urlPath: urlPath) { [self] result in
            switch result {
            case .success(let page):
                self.planets.append(page)
            case .failure(let err):
                print("Error: \(err.localizedDescription)")
                //self.presentErrorAlert(title: "NetworkError", message: err.localizedDescription)
            }
        }
    }*/
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StarWarsCell.reuseId, for: indexPath) as? StarWarsCell else {
            return UITableViewCell()
        }
        
        cell.configure(index: indexPath.row, result: self.pages[indexPath.row])
        
        return cell
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        let lastIndexPath = IndexPath(row: self.pages.count - 1, section: 0)
        guard indexPaths.contains(lastIndexPath) else { return }
        
        self.nextOffset += 1
        self.fetchCharacterPage()
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "NewViewController") as? NewViewController else { return }
        vc.nameLabel.text = self.pages[indexPath.row].name
        vc.eyeLabel.text = self.pages[indexPath.row].eye_color
        vc.hairLabel.text = self.pages[indexPath.row].hair_color
        vc.homeLabel.text = self.pages[indexPath.row].homeworld
        self.navigationController?.pushViewController(vc, animated: true)
        self.present(vc, animated: true, completion: nil)
    }
}

