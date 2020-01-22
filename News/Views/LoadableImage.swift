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
    var width: CGFloat = 100
    var height: CGFloat = 100
    
    @State var loadedImage: Image?
    
    var body: some View {
        
        if loadedImage == nil {
            return AnyView(Image(systemName: "photo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: width, height: height)
                .clipped()
                .cornerRadius(5)
                .onAppear(perform: loadImage))
        } else {
            return AnyView(
                loadedImage!
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(5)
            )
        }
        
    }
    
    func loadImage() {
        
        NewsApi.shared.fetchImage(urlString: imageURLString) { loadedImage in
            self.loadedImage = loadedImage
        }
    
    }
}

struct LoadableImage_Previews: PreviewProvider {
    
    static let imageURLString = "https://cnet2.cbsistatic.com/img/ol-N1f9pnkQ9aFZpNZhZ2gsu__o=/1092x0/2019/01/10/680e72b1-a2bb-44ed-951c-5c5379b4f91b/002-samsung-oled-8k-98-inch-tv.jpg"
    
    static var previews: some View {
        LoadableImage(imageURLString: imageURLString)
    }
}
