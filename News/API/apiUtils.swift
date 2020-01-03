//
//  apiUtils.swift
//  News
//
//  Created by Jacob Contreras on 1/2/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import Foundation

func simpleURLRequest(urlString: String, callback: @escaping (Any?, Error?) -> Void) {
    
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        DispatchQueue.main.async {
            if let data = data {
                callback(data, nil)
            } else {
                callback(nil, error)
            }
        }
    }.resume()
    
}
