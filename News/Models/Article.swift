//
//  PersistentArticle.swift
//  News
//
//  Created by Jacob Contreras on 2/6/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import Foundation
import CoreData

class Source: PersistentObject, Codable  {
    
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    init(name: String?) {
        self.name = name
    }
    
    let name: String?
    var wrappedName: String {
        return name?.components(separatedBy: ".").first ?? "Unknown Source"
    }
    
    // MARK: Encoding/Decoding
    
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        name = try? container?.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try? container.encode(name, forKey: .name)
    }
    
    // MARK: Persistence
    
   typealias ManagedObjectType = SourceMO

    var managedObject: SourceMO?
    
    required init(_ managedObject: SourceMO) {
        let sourceMO = managedObject
        name = sourceMO.name
        
    }
    
    func persist(context: NSManagedObjectContext = PersistenceService.context, save: Bool = false) -> SourceMO {
        let sourceMO = SourceMO.createSourceMO(context: context, _sourceMO: managedObject, source: self)
        
        managedObject = sourceMO
        
        if save && context.hasChanges {
            try? context.save()
        }
        
        return sourceMO
    }
}


class Article: PersistentObject, Identifiable, Codable {
    
    enum CodingKeys: CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt
    }
    
    
    var id = UUID()
    let source: Source?
    let author: String?
    let title: String
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: Date?
    
    var wrappedAuthor: String {
        return author ?? "Unknown Author"
    }
    
    var wrappedUrlToImage: String {
        return urlToImage ?? ""
    }
    
    // MARK: Encoding/Decoding
    
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        
        id = UUID()
        source = try (container?.decode(Source.self, forKey: .source) ?? Source(name: "Unknown Source"))
        author = try container?.decode(String?.self, forKey: .author)
        title = try (container?.decode(String.self, forKey: .title) ?? "Unknown Title")
        description = try container?.decode(String?.self, forKey: .description)
        url = try (container?.decode(String?.self, forKey: .url) ?? "")
        urlToImage = try container?.decode(String?.self, forKey: .urlToImage)
        publishedAt = try container?.decode(Date?.self, forKey: .publishedAt)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(source, forKey: .source)
        try container.encode(author, forKey: .author)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(url, forKey: .url)
        try container.encode(urlToImage, forKey: .urlToImage)
        try container.encode(publishedAt, forKey: .publishedAt)
    }
    
    
    // MARK: Persistence

    typealias ManagedObjectType = ArticleMO

    var managedObject: ArticleMO?
    
    required init(_ managedObject: ArticleMO) {
        let articleMO = managedObject
        
        id = articleMO.id ?? UUID()
        source = Source(articleMO.source!)
        author = articleMO.author
        title = articleMO.title ?? "Unknown Title"
        description = articleMO.articleDescription
        url = articleMO.url ?? ""
        urlToImage = articleMO.urlToImage
        publishedAt = articleMO.publishedAt
        
    }
    
    func persist(context: NSManagedObjectContext = PersistenceService.context, save: Bool = false) -> ArticleMO {
                
        let articleMO = ArticleMO.createArticleMO(context: context, _articleMO: managedObject, article: self)
        
        managedObject = articleMO
        
        if save && context.hasChanges {
            try? context.save()
        }
        
        return articleMO
    }
    
}

class Response: Codable {
    let totalResults: Int
    let articles: [Article]
}
