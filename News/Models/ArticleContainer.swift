//
//  ArticleContainer.swift
//  News
//
//  Created by Jacob Contreras on 2/6/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import Foundation
import CoreData

class ArticleContainer: ObservableObject {
    
    @Published var articles: [Article]
    
    init(context: NSManagedObjectContext = PersistenceService.context) {
        
        let savedArticleMOs = ArticleMO.fetchArticleMOs(context: context)
        let savedArticles = savedArticleMOs.map({ Article($0) })
        
        articles = savedArticles
    }
    
    func saveArticle(article: Article, context: NSManagedObjectContext = PersistenceService.context) {
        _ = article.persist(context: context, save: true)
        articles.append(article)
    }
}
