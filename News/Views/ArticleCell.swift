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
    let geometry: GeometryProxy
    
    var cellHeight: CGFloat {
        return geometry.size.height / 5
    }
    
    var imageDimension: CGFloat {
        return (geometry.size.height / 5) * 0.9
    }
    
    var body: some View {
        
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 0) {
                Text(article.publisher)
                    .font(.title)
                    .foregroundColor(.gray)
                Text(article.title)
                        .font(.headline)
            }
                
            Spacer()
                
            LoadableImage(imageURLString: article.imgPath)
                .frame(width: imageDimension, height: imageDimension)
        }
        .frame(height: cellHeight)

    }
}

struct ArticleCell_Previews: PreviewProvider {
    
    static let sampleArticle = Article(publisher: "Times", title: "Amazing new 8k tv wows audience", imgPath: "https://cnet2.cbsistatic.com/img/ol-N1f9pnkQ9aFZpNZhZ2gsu__o=/1092x0/2019/01/10/680e72b1-a2bb-44ed-951c-5c5379b4f91b/002-samsung-oled-8k-98-inch-tv.jpg")
    
    static var previews: some View {
        
        GeometryReader { geo in
            ArticleCell(article: sampleArticle, geometry: geo)
        }
    }
}
