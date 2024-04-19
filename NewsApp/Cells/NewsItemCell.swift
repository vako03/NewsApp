//
//  NewsItemCell.swift
//  NewsApp
//
//  Created by vako on 19.04.24.
//
import UIKit

class NewsItemCell: UITableViewCell {
    
    // MARK: - UI Elements
    
    let titleLabel = UILabel()
    let timeLabel = UILabel()
    let newsImageView = UIImageView()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    
    private func setupUI() {
        contentView.addSubview(newsImageView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .clear
        timeLabel.textColor = .white
        titleLabel.textColor = .white
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            newsImageView.heightAnchor.constraint(equalToConstant: 108)
        ])
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.clipsToBounds = true
        newsImageView.layer.cornerRadius = 15
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            timeLabel.heightAnchor.constraint(equalToConstant: 20),
            timeLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -50)
        ])
        
        timeLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "FiraGO-SemiBold", size: 14)
    }
    
    // MARK: - Configuration
    
    func configure(with newsItem: NewsItem) {
        titleLabel.text = newsItem.title
        timeLabel.text = newsItem.time
        
        if let url = URL(string: newsItem.photoUrl) {
            loadImage(from: url)
        }
    }
    
    // MARK: - Image Loading
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                if let image = UIImage(data: data) {
                    self?.newsImageView.image = image
                }
            }
        }.resume()
    }
}
