//
//  NewsRepo.swift
//  NewsFeed
//
//  Created by JaGgu Sam on 21/07/21.
//

import Foundation

protocol NewsListRepositoryProtocol {
    func getNewsList(completionHandler: @escaping ([String: Any], TaskError) -> Void)
}

class NewsListRepository: NewsListRepositoryProtocol {
    static let repository = NewsListRepository()
    func getNewsList(completionHandler: @escaping ([String: Any], TaskError) -> Void) {
        let task = HTTPTask()
        
        task.GET(api: Constants.api.newsApi) { (result, error) in
            self.saveData(result: result)
            DispatchQueue.main.async {
                completionHandler(result, error)
            }
        }
    }
    
    // Saving news list in userDefaults for offlineStore
    func saveData(result : [String: Any]) {
        do {
            let data = try JSONSerialization.data(withJSONObject: result, options: [])
            UserDefaults.standard.set(data, forKey: Constants.UserDefaultsKeys.newsData)
        } catch {
            print("Not Converted")
        }
    }
}
