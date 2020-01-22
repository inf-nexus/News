//
//  WebView.swift
//  News
//
//  Created by Jacob Contreras on 1/21/20.
//  Copyright © 2020 Jacob Contreras. All rights reserved.
//

import SwiftUI
import UIKit
import WebKit

struct WebView: UIViewRepresentable {
    
    let urlString: String
    
    class Coordinator: NSObject, WKUIDelegate {
        
        var parent: WebView
        
        init(_ parent: WebView) {
            self.parent = parent
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.uiDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

//struct WebView_Previews: PreviewProvider {
//    static var previews: some View {
//        WebView()
//    }
//}
