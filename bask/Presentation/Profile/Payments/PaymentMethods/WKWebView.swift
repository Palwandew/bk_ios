//
//  WKWebView.swift
//  bask
//
//  Created by TEHSEEN ABBAS on 25/09/2022.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable{
    var url: URL
     
    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        
        return webView
    }
     
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
}

struct WKWebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "www.google.com")!)
    }
}
