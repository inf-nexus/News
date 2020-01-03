//
//  LoadableImage.swift
//  News
//
//  Created by Jacob Contreras on 1/2/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import SwiftUI

struct LoadableImage: View {
    
    let imageURLString: String
    @State var data = Data()
    
    var body: some View {
        if data.isEmpty {
            return AnyView(Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .onAppear(perform: loadImage))
        }
        return AnyView(Image(uiImage: UIImage(data: data)!)
            .resizable()
            .scaledToFit())
    }
    
    func loadImage() {
        
        simpleURLRequest(urlString: imageURLString) { data, error in
            if data != nil {
                guard let data = data as? Data else { return }
                self.data = data
                
            } else {
                print("Error fetching image: ", error?.localizedDescription ?? "Unknown error")
            }
        }
        
        guard let url = URL(string: imageURLString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                self.data = data
            }
            
        }.resume()
    }
}

struct LoadableImage_Previews: PreviewProvider {
    
    static let imageURLString = "https://cnet2.cbsistatic.com/img/ol-N1f9pnkQ9aFZpNZhZ2gsu__o=/1092x0/2019/01/10/680e72b1-a2bb-44ed-951c-5c5379b4f91b/002-samsung-oled-8k-98-inch-tv.jpg"
    
    static var previews: some View {
        LoadableImage(imageURLString: imageURLString)
    }
}
