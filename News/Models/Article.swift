//
//  Article.swift
//  News
//
//  Created by Jacob Contreras on 1/1/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import Foundation

struct Source: Codable {
    let name: String
}

struct Article: Identifiable, Codable {
    let id = UUID()
    let source: Source
    let author: String?
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: Date
    
    var wrappedAuthor: String {
        return author ?? "Unknown Author"
    }
    
    var wrappedUrlToImage: String {
        return urlToImage ?? ""
    }
}

struct Response: Codable {
    let totalResults: Int
    let articles: [Article]
}

