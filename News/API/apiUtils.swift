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
    
    init(imageCache:  NSCache<NSString, UIImage>) {
        self.imageCache = imageCache
    }
    
    let imageCache: NSCache<NSString, UIImage>
    
    static let shared = NewsApi(imageCache: NSCache<NSString, UIImage>())
    
    func fetchHeadlineArticles(callback: @escaping ([Article]) -> Void) {
        
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(API_KEY)"
        
        guard let url = URL(string: urlString) else {
            callback([])
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    let articles = decodeArticles(data: data)
                    callback(articles)
                } else {
                    print("Failed to retrieve articles with error: ", error?.localizedDescription ?? "Unknown Error")
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

