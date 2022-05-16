//
//  NewViewController.swift
//  StarWars
//
//  Created by Consultant on 5/16/22.
//

import UIKit

class NewViewController: UIViewController {
    
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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
        }()
    
    lazy var contentView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
    }()
    
    var networkManager = NetworkManager()
    
    var characterData: [Characters] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
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
    
    private func setUpUI() {
        
        let vStack = UIStackView(frame: .zero)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .center
        
        let topBuffer = UIView(resistancePriority: .defaultLow, huggingPriority: .defaultLow)
        let bottomBuffer = UIView(resistancePriority: .defaultLow, huggingPriority: .defaultLow)
        
        view.addSubview(scrollView)
                
        scrollView.addSubview(contentView)
                
        contentView.addSubview(vStack)
        vStack.addArrangedSubview(topBuffer)
        vStack.addArrangedSubview(self.nameLabel)
        vStack.addArrangedSubview(self.eyeLabel)
        vStack.addArrangedSubview(self.hairLabel)
        vStack.addArrangedSubview(self.homeLabel)
        vStack.addArrangedSubview(bottomBuffer)
        
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
                
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
                
        topBuffer.heightAnchor.constraint(equalTo: bottomBuffer.heightAnchor).isActive = true
    }
}


