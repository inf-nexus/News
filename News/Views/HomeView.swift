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
    @State var selectedURLString: String?
    @State var showingWebView = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                List {
                    
                    ForEach(self.articles) { article in
        
                        ArticleCell(article: article)
                            .onAppear(perform: {
                                if article.id == self.articles.last!.id {
                                    self.loadArticles()
                                }
                                
                            })
                            .onTapGesture {
                                self.selectedURLString = article.url
                                self.showingWebView = true
                        }
                    }
                    
                    HStack() {
                        Spacer()
                        Text("Powered by News API")
                            .bold()
                        Spacer()
                    }
                    
                }.sheet(isPresented: $showingWebView, onDismiss: { self.selectedURLString = nil }) {
                    WebView(urlString: self.selectedURLString!)
                        .edgesIgnoringSafeArea(.all)
                }
                
                
            }
            .navigationBarTitle(Text("News"))
        }
        .onAppear(perform: loadArticles)
    }
    
    func loadArticles() {
        NewsApi.shared.fetchHeadlineArticles { articles in
            self.articles.append(contentsOf: articles)
        }
    }
    
}

struct HomeView_Previews: PreviewProvider {
    
    static let articleJSON = """
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
    
    static let article = decodeArticleJSONString(jsonString: articleJSON)!
    
    static let articles = [article]
    
    static var previews: some View {
        HomeView(articles: articles)
    }
}
