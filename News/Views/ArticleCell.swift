//
//  ArticleCell.swift
//  News
//
//  Created by Jacob Contreras on 1/1/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import SwiftUI

struct ArticleCell: View {
    
    let article: Article
    
    var body: some View {
        
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Text(article.source.name)
                    .font(.title)
                    .foregroundColor(.gray)
                Text(article.title)
                        .font(.headline)
            }
                
            Spacer()
            
            VStack {
                Spacer()
                LoadableImage(imageURLString: article.wrappedUrlToImage, width: 100, height: 100)
                Spacer()
            }
                
           
        }

    }
}

struct ArticleCell_Previews: PreviewProvider {
    
    static let articleJSON = """
    {
        {
        "source": {
        "id": "bbc-news",
        "name": "BBC News"
        },
        "author": "BBC News",
        "title": "China confirms 139 cases of new virus in two days",
        "description": "New cases of the respiratory illness are confirmed in the cities of Wuhan, Beijing and Shenzhen.",
        "url": "http://www.bbc.co.uk/news/world-asia-china-51171035",
        "urlToImage": "https://ichef.bbci.co.uk/news/1024/branded_news/EDE0/production/_110569806_9ac4763d-4c70-4d9e-aeb9-8b1358e0914c.jpg",
        "publishedAt": "2020-01-20T01:50:42Z",
        "content": "Image copyrightEPAImage caption\r\n The majority of cases have been detected in the city of Wuhan\r\nChinese authorities have reported 139 new cases of a mysterious virus in two days, marking the first time that the infection has been confirmed in the country out… [+2815 chars]"
        }
    """
    
    static let sampleArticle = decodeArticleJSONString(jsonString: articleJSON)!

    
    static var previews: some View {
        
        ArticleCell(article: sampleArticle)
    }
}
