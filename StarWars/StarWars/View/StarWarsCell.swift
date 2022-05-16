//
//  StarWarsCell.swift
//  StarWars
//
//  Created by Consultant on 5/16/22.
//

import UIKit

class StarWarsCell: UITableViewCell {

    static let reuseId = "\(StarWarsCell.self)"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some Name"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var eyeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some Name"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var hairLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some Name"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var homeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some Name"
        label.numberOfLines = 0
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    
    
    var networkManager = NetworkManager()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        self.contentView.backgroundColor = .magenta
        
        let vStack = UIStackView(frame: .zero)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        
        let topBuffer = UIView(resistancePriority: .defaultLow, huggingPriority: .defaultLow)
        let bottomBuffer = UIView(resistancePriority: .defaultLow, huggingPriority: .defaultLow)

        vStack.addArrangedSubview(topBuffer)
        vStack.addArrangedSubview(self.nameLabel)
        vStack.addArrangedSubview(self.eyeLabel)
        vStack.addArrangedSubview(self.hairLabel)
        vStack.addArrangedSubview(self.homeLabel)
        vStack.addArrangedSubview(bottomBuffer)
        
        self.contentView.addSubview(vStack)
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.borderWidth = 4
        
        vStack.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8).isActive = true
        vStack.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        vStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8).isActive = true
        vStack.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        
        topBuffer.heightAnchor.constraint(equalTo: bottomBuffer.heightAnchor).isActive = true
    }
    
    func configure(index: Int, result: Character) {
        self.reset()
        self.nameLabel.text = result.name
        self.eyeLabel.text = result.eye_color
        self.hairLabel.text = result.hair_color
        self.homeLabel.text = result.homeworld
        
        //slow but functional
        networkManager.fetchPlanetInfo(urlPath: homeLabel.text ?? "") { result in
            switch result {
                case .success(let page):
                    DispatchQueue.main.async {
                        self.homeLabel.text = page.name
                    }
                    
                case .failure(let err):
                    print("Error: \(err.localizedDescription)")
                    
                }
        }
    }
        
    
    private func reset() {
        self.nameLabel.text = "undefined"
        self.eyeLabel.text = "undefined"
        self.hairLabel.text = "undefined"
        self.homeLabel.text = "undefined"
    }
}
