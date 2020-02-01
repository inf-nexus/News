//
//  SearchView.swift
//  News
//
//  Created by Jacob Contreras on 1/22/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import SwiftUI
import Combine

class QueryWrapper: ObservableObject {
    
    var fetchArticles: ((String, Bool) -> Void)?

    private var cancellable: AnyCancellable?
    @Published var searchQuery = ""
    
    init() {
            
        cancellable = $searchQuery.removeDuplicates().debounce(for: .milliseconds(400), scheduler: DispatchQueue.main).sink { searchVal in
            self.fetchArticles?(searchVal, false)
        }
    }
    
}

struct SearchBar: View {
    
    @ObservedObject var queryWrapper: QueryWrapper
    
    let lightGrayColor = Color(red: 229/255, green: 229/255, blue: 234/255)
    
    var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
            TextField("Search", text: $queryWrapper.searchQuery)
                .padding(.leading, 5)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 12).fill(lightGrayColor))
        .padding()
        
    }

}

struct SearchView: View {
    
    @ObservedObject var queryWrapper = QueryWrapper()
    
    @State var articles = [Article]()
    @State var selectedURLString: String?
    @State var showingWebView = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                SearchBar(queryWrapper: queryWrapper)
                
                List {
                    
                    ForEach(articles) { article in
                        ArticleCell(article: article)
                        .onAppear(perform: {
                                if article.id == self.articles.last!.id {
                                    self.fetchArticles(query: self.queryWrapper.searchQuery, shouldAppend: true)
                                }
                                
                            })
                            .onTapGesture {
                                self.selectedURLString = article.url
                                self.showingWebView = true
                        }
                    }
                    
                }
                
            }
            .navigationBarTitle("Search")
            .onAppear(perform: { self.queryWrapper.fetchArticles = self.fetchArticles })
            .sheet(isPresented: $showingWebView, onDismiss: { self.selectedURLString = nil }) {
                WebView(urlString: self.selectedURLString!)
                    .edgesIgnoringSafeArea(.all)
            }
            
        }
        
    }
    
    func fetchArticles(query: String, shouldAppend: Bool) {
        
        NewsApi.shared.fetchQueriedArticles(query: query) { articles in
            if shouldAppend {
                self.articles.append(contentsOf: articles)
            } else {
                 self.articles = articles
            }
           
        }
        
    }
    
    
    

}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
