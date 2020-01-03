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
        
        GeometryReader { geo in
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 0) {
                        Text(self.article.publisher)
                            .font(.title)
                            .foregroundColor(.gray)
                        Text(self.article.title)
                            .font(.headline)
                }
                .padding()
                
            Spacer()
                
                LoadableImage(imageURLString: self.article.imgPath)
                    .frame(height: geo.size.height - 20)
            }
            
        }
        .frame(height: 130)
        
    }
}

struct ArticleCell_Previews: PreviewProvider {
    
    static let sampleArticle = Article(publisher: "Times", title: "Amazing new 8k tv wows audience", imgPath: "https://cnet2.cbsistatic.com/img/ol-N1f9pnkQ9aFZpNZhZ2gsu__o=/1092x0/2019/01/10/680e72b1-a2bb-44ed-951c-5c5379b4f91b/002-samsung-oled-8k-98-inch-tv.jpg")
    
    static var previews: some View {
        ArticleCell(article: sampleArticle)
    }
}
