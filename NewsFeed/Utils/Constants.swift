//
//  Constants.swift
//  NewsFeed
//
//  Created by JaGgu Sam on 21/07/21.
//

import Foundation

class Constants {
    
    struct api {
        static let newsApi = "https://newsapi.org/v2/everything?q=india&from=2021-07-28&sortBy=publishedAt&apiKey=37486c7389064ff1a883a1ebd013eaef"
    }
    
    struct TableViewCellIdentifier {
        static let newsCardTableViewCell = "NewsCardTableViewCell"
    }
    
    struct UserDefaultsKeys {
        static let newsData = "NewsData"
    }
}
