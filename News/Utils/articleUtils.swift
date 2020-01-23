//
//  articleUtils.swift
//  News
//
//  Created by Jacob Contreras on 1/20/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import Foundation

func decodeArticleJSONString(jsonString: String) -> Article? {
        
    let jsonData = jsonString.data(using: .utf8)!
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    
    guard let article = try? decoder.decode(Article.self, from: jsonData) else { return nil }
    
    return article
}

func decodeResponse(data: Data) -> Response? {
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    
    var response: Response?
    
    do {
        response = try decoder.decode(Response.self, from: data)
    } catch {
        print("Failed to decode response: ", error.localizedDescription)
    }
    
    return response
}
