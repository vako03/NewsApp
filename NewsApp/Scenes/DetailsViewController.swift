//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by vako on 19.04.24.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    var imageUrl: String?
    var text: String?
    var timeText: String?
    
    // MARK: - UI Elements
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Details"
        label.font = UIFont(name: "SpaceGrotesk-Bold", size: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.alpha = 1
        return imageView
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FiraGO-SemiBold", size: 14)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "FiraGO-SemiBold", size: 16)
        label.textColor = .black
        return label
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
    }
    
    // MARK: - UI Setup

    func setUI() {
        
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23.9),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            imageView.widthAnchor.constraint(equalToConstant: 327),
            imageView.heightAnchor.constraint(equalToConstant: 190),
        ])
        
        imageView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        
        view.addSubview(timeLabel)
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 13),
            timeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            textLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 26),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 36),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -36),
        ])
        
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            loadImage(from: url)
        }
        
        textLabel.text = text
        timeLabel.text = timeText
    }
    // MARK: - Image Loading
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, let image = UIImage(data: data), error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
}
