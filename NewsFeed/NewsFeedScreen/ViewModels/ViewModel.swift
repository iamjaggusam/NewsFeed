//
//  ViewModel.swift
//  NewsFeed
//
//  Created by JaGgu Sam on 22/07/21.
//

import Foundation

// MARK: - NewsViewModel
struct NewsFeedViewModel {
    let name: String
    let author: String
    let title: String
    let description: String
    let url: String
    let image: String
    
    init(using newsModel: NewsFeedObject) {
        self.name = newsModel.name
        self.author = newsModel.author
        self.title = newsModel.title
        self.description = newsModel.description
        self.url = newsModel.url
        self.image = newsModel.image
    }
}

struct NewsFeedObject {
    let name: String
    let author: String
    let title: String
    let description: String
    let url: String
    let image: String
    
    init(dictionary : [String : AnyObject]) {
        print(nulltoNil(value: dictionary["image"] as AnyObject))
        name = nulltoNil(value: dictionary["source"]?["name"] as AnyObject)
        author = nulltoNil(value: dictionary["author"] as AnyObject)
        title = nulltoNil(value: dictionary["title"] as AnyObject)
        description = nulltoNil(value: dictionary["description"] as AnyObject)
        url = nulltoNil(value: dictionary["url"] as AnyObject)
        image = nulltoNil(value: dictionary["urlToImage"] as AnyObject)
    }
}

func nulltoNil(value: AnyObject) -> String {
    if value is NSNull {
        return ""
    } else {
        return String(describing: value)
    }
}
