//
//  Article.swift
//  News
//
//  Created by Jacob Contreras on 1/1/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import Foundation

struct Article: Identifiable {
    let id = UUID()
    let publisher: String
    let title: String
    let imgPath: String
}
