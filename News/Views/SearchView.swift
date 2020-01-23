//
//  SearchView.swift
//  News
//
//  Created by Jacob Contreras on 1/22/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var query: String
    
    let lightGrayColor = Color(red: 229/255, green: 229/255, blue: 234/255)
    
    var body: some View {
        
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
            TextField("Search", text: $query)
                .padding(.leading, 5)
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 12).fill(lightGrayColor))
        .padding()
        
    }
    
}

struct SearchView: View {
    
    @State var searchQuery = ""
    @State var articles = [Article]()
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                SearchBar(query: $searchQuery)
                
                List {
                    
                    ForEach(articles) { article in
                        ArticleCell(article: article)
                    }
                    
                }
                
            }
            .navigationBarTitle("Search")
            
        }
        
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
