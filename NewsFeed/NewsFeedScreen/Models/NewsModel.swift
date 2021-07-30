//
//  NewsModel.swift
//  NewsFeed
//
//  Created by JaGgu Sam on 21/07/21.
//

import Foundation

// MARK: - Welcome
struct NewsModel: Codable {
    let pagination: Pagination
    let data: [Article]
}

// MARK: - Datum
struct Article: Codable {
    let author: String?
    let title, datumDescription: String
    let url: String
    let source: String
    let image: String?
    let category: Category
    let language: Language
    let country: Country
    let publishedAt: Date

    enum CodingKeys: String, CodingKey {
        case author, title
        case datumDescription = "description"
        case url, source, image, category, language, country
        case publishedAt = "published_at"
    }
}

enum Category: String, Codable {
    case general = "general"
    case sports = "sports"
}

enum Country: String, Codable {
    case countryIn = "in"
}

enum Language: String, Codable {
    case en = "en"
}

// MARK: - Pagination
struct Pagination: Codable {
    let limit, offset, count, total: Int
}
