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
    var requestHelper: RequestHelper
    
    static let shared = NewsApi()
    
    init() {
        self.imageCache = NSCache<NSString, UIImage>()
        self.requestHelper = RequestHelper(pageSize: 10, page: 1, loadedResults: 0, totalResults: 0, status: .uninitialized)
    }
    
    func fetchHeadlineArticles(callback: @escaping ([Article]) -> Void) {
        
        if (!requestHelper.shouldMakeRequest) { return }
        
        requestHelper.status = .loading

        let urlString = "https://newsapi.org/v2/top-headlines?country=us&pageSize=\(requestHelper.pageSize)&page=\(requestHelper.page)&apiKey=\(API_KEY)"
        
        guard let url = URL(string: urlString) else {
            requestHelper.status = .failed
            callback([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let response = decodeResponse(data: data)
                    let totalResults = response?.totalResults ?? 0
                    let articles = response?.articles ?? []
                    
                    self.requestHelper.status = .success
                    self.requestHelper.loadedResults += articles.count
                    self.requestHelper.totalResults = totalResults
                    self.requestHelper.page += 1
                    
                    callback(articles)
                } else {
                    print("Failed to retrieve articles with error: ", error?.localizedDescription ?? "Unknown Error")
                    self.requestHelper.status = .failed
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
                    let uiImage = UIImage(data: data)!
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

