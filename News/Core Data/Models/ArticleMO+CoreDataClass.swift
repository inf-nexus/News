//
//  ArticleMO+CoreDataClass.swift
//  News
//
//  Created by Jacob Contreras on 2/6/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ArticleMO)
public class ArticleMO: NSManagedObject {
    
    static func createArticleMO(context: NSManagedObjectContext, _articleMO: ArticleMO?, article: Article) -> ArticleMO {
        
        let articleMO = _articleMO ?? ArticleMO(context: context)
        articleMO.id = article.id
        articleMO.author = article.author
        articleMO.title = article.title
        articleMO.articleDescription = article.description
        articleMO.url = article.url
        articleMO.urlToImage = article.urlToImage
        articleMO.publishedAt = article.publishedAt
        articleMO.source = SourceMO.createSourceMO(context: context, _sourceMO: articleMO.source, source: article.source ?? Source(name: "Unknown Source"))
        
        return articleMO
    }
    
    static func fetchArticleMOs(context: NSManagedObjectContext) -> [ArticleMO] {
        let request: NSFetchRequest<ArticleMO> = ArticleMO.fetchRequest()
        
        let articleMOs = try? context.fetch(request)
        
        return articleMOs ?? []
    }

}
