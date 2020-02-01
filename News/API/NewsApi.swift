//
//  apiUtils.swift
//  News
//
//  Created by Jacob Contreras on 1/2/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit

let API_KEY = ""

class NewsApi {
    
    let imageCache: NSCache<NSString, UIImage>
    var headlineRequestHelper: RequestHelper
    var queryRequestHelper: QueryRequestHelper
    
    static let shared = NewsApi()
    
    init() {
        self.imageCache = NSCache<NSString, UIImage>()
        self.headlineRequestHelper = RequestHelper(pageSize: 10, page: 1, loadedResults: 0, totalResults: 0, status: .uninitialized)
        self.queryRequestHelper = QueryRequestHelper(pageSize: 10, page: 1, loadedResults: 0, totalResults: 0, status: .uninitialized)
    }
    
    private func cleanQuery(_ query: String) -> String {
        return query.replacingOccurrences(of: " ", with: "+")
    }
    
    func fetchQueriedArticles(query: String, callback: @escaping ([Article]) -> Void) {
        
        let cleanedQuery = cleanQuery(query)
                        
        if (!queryRequestHelper.shouldMakeRequest(nextQuery: cleanedQuery)) { return }
                
        queryRequestHelper.loadingUpdate(nextQuery: cleanedQuery)
        
        let urlString = "https://newsapi.org/v2/everything?language=en&q=\(cleanedQuery)&pageSize=\(queryRequestHelper.pageSize)&page=\(queryRequestHelper.page)&apiKey=\(API_KEY)"
                
        guard let url = URL(string: urlString) else {
                  queryRequestHelper.failureUpdate()
                  callback([])
                  return
              }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
                        
            DispatchQueue.main.async {
                
                if let data = data {
                    let response = decodeResponse(data: data)
                    let totalResults = response?.totalResults ?? 0
                    let articles = response?.articles ?? []
                    
                    self.queryRequestHelper.successUpdate(articleCount: articles.count, totalResults: totalResults)
                    
                    callback(articles)
                    
                } else {
                    print("Failed to retrieve articles with error: ", error?.localizedDescription ?? "Unknown Error")
                    self.headlineRequestHelper.failureUpdate()
                    callback([])
                }
            }
            
        }.resume()
        
    }
    
    func fetchHeadlineArticles(callback: @escaping ([Article]) -> Void) {
        
        if (!headlineRequestHelper.shouldMakeRequest()) { return }
        
        headlineRequestHelper.loadingUpdate()

        let urlString = "https://newsapi.org/v2/top-headlines?country=us&pageSize=\(headlineRequestHelper.pageSize)&page=\(headlineRequestHelper.page)&apiKey=\(API_KEY)"
                
        guard let url = URL(string: urlString) else {
            headlineRequestHelper.failureUpdate()
            callback([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let response = decodeResponse(data: data)
                    let totalResults = response?.totalResults ?? 0
                    let articles = response?.articles ?? []
                    
                    self.headlineRequestHelper.successUpdate(articleCount: articles.count, totalResults: totalResults)
                    
                    callback(articles)
                } else {
                    print("Failed to retrieve articles with error: ", error?.localizedDescription ?? "Unknown Error")
                    self.headlineRequestHelper.failureUpdate()
                    callback([])
                }
            }
        }.resume()
    }
    
    func fetchImage(urlString: String, callback: @escaping (Image) -> Void) {
        
        if let cachedUIImage = imageCache.object(forKey: NSString(string: urlString)) {
            callback(Image(uiImage: cachedUIImage))
            return
        }
        
        let fallbackImage = Image(systemName: "photo")
        
        guard let url = URL(string: urlString) else {
            callback(fallbackImage)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            DispatchQueue.main.async {
                if let data = data {
                    let uiImage = UIImage(data: data) ?? UIImage()
                    self.imageCache.setObject(uiImage, forKey: NSString(string: urlString))
                    callback(Image(uiImage: uiImage))
                } else {
                    print("Failed to retrieve image data with error: ", error?.localizedDescription ?? "Unknown error")
                    callback(fallbackImage)
                }
            }
            
        }.resume()
    }
    
}

