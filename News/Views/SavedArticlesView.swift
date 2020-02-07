//
//  SavedArticlesView.swift
//  News
//
//  Created by Jacob Contreras on 2/6/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import SwiftUI

struct SavedArticlesView: View {
    
    @EnvironmentObject var articleContainer: ArticleContainer
    
    @State var selectedURLString: String?
    @State var showingWebView = false
    
    var body: some View {
        
        NavigationView {
            
            List {
                
                ForEach(articleContainer.articles) { article in
                    ArticleCell(article: article)
                        .onTapGesture {
                            self.selectedURLString = article.url
                            self.showingWebView = true
                    }
                    
                }
                
            }
            .navigationBarTitle("Saved Articles")
            .sheet(isPresented: $showingWebView, onDismiss: { self.selectedURLString = nil }) {
                WebView(urlString: self.selectedURLString!)
                    .edgesIgnoringSafeArea(.all)
            }
            
        }
    }
}

struct SavedArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedArticlesView()
    }
}
