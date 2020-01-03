//
//  HomeView.swift
//  News
//
//  Created by Jacob Contreras on 1/1/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        LoadableImage(imageURLString: "https://cnet2.cbsistatic.com/img/ol-N1f9pnkQ9aFZpNZhZ2gsu__o=/1092x0/2019/01/10/680e72b1-a2bb-44ed-951c-5c5379b4f91b/002-samsung-oled-8k-98-inch-tv.jpg")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
