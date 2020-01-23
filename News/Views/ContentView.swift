//
//  ContentView.swift
//  News
//
//  Created by Jacob Contreras on 1/1/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            
            HomeView().tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            
            SearchView().tabItem {
                Image(systemName: "magnifyingglass")
                Text("Search")
            }
            
            
        }
        
        
       
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
