//
//  HomeView.swift
//  News
//
//  Created by Jacob Contreras on 1/1/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @State var articles = [Article]()
    
    var body: some View {
        
        NavigationView {
            
            GeometryReader { geo in
                
                List(self.articles) { article in
                   ArticleCell(article: article, geometry: geo)
                }
                
            }
            .navigationBarTitle(Text("News"))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    
    static let article = Article(publisher: "Times", title: "Amazing new 8k tv wows audience", imgPath: "https://cnet2.cbsistatic.com/img/ol-N1f9pnkQ9aFZpNZhZ2gsu__o=/1092x0/2019/01/10/680e72b1-a2bb-44ed-951c-5c5379b4f91b/002-samsung-oled-8k-98-inch-tv.jpg")
    
    static let articles = [article]
    
    static var previews: some View {
        HomeView(articles: articles)
    }
}
