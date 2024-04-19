//
//  APICallers.swift
//  NewsApp
//
//  Created by vako on 19.04.24.
//

import Foundation

class APICallers {
    
    // MARK: - API Call
    
    static func fetchNews(completion: @escaping ([NewsItem]?, Error?) -> Void) {
        let urlString = "https://imedinews.ge/api/categorysidebarnews/get"
        
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let responseData = data else {
                completion(nil, NSError(domain: "No data received", code: 0, userInfo: nil))
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] {
                    if let newsList = json["List"] as? [[String: Any]] {
                        var newsItems = [NewsItem]()
                        for news in newsList {
                            if let title = news["Title"] as? String,
                               let time = news["Time"] as? String,
                               let url = news["Url"] as? String,
                               let photoUrl = news["PhotoUrl"] as? String,
                               let photoAlt = news["PhotoAlt"] as? String {
                                let newsItem = NewsItem(title: title, time: time, url: url, photoUrl: photoUrl, photoAlt: photoAlt)
                                newsItems.append(newsItem)
                            }
                        }
                        completion(newsItems, nil)
                    }
                }
            } catch {
                completion(nil, error)
            }
        }
        task.resume()
    }
}

struct NewsItem {
    let title: String
    let time: String
    let url: String
    let photoUrl: String
    let photoAlt: String
}
