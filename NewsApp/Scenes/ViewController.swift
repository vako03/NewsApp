//
//  ViewController.swift
//  NewsApp
//
//  Created by vako on 19.04.24.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var tableView: UITableView!
    var newsItems = [NewsItem]()
    
    // MARK: - UI Elements
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Panicka News"
        label.font = UIFont(name: "SpaceGrotesk-Bold", size: 24)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUI()
        fetchNewsItems()
    }
    
    // MARK: - UI Setup
    
    func setUI() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsItemCell.self, forCellReuseIdentifier: "NewsItemCell")
        tableView.showsVerticalScrollIndicator = false
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23.9),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    // MARK: - Data Fetching
    
    private func fetchNewsItems() {
        APICallers.fetchNews { [weak self] (newsItems, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error)")
                return
            }
            
            if let newsItems = newsItems {
                DispatchQueue.main.async {
                    self.newsItems = newsItems
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsItemCell", for: indexPath) as! NewsItemCell
        let newsItem = newsItems[indexPath.row]
        cell.configure(with: newsItem)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedNewsItem = newsItems[indexPath.row]
        let detailsVC = DetailsViewController()
        detailsVC.imageUrl = selectedNewsItem.photoUrl
        detailsVC.text = selectedNewsItem.title
        detailsVC.timeText = selectedNewsItem.time
        navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 123
    }
}
