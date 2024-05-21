//
//  WebView.swift
//  CapStoneDesign
//
//  Created by Wodnd on 5/20/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

#Preview {
    WebView(url: URL(string: "https://github.com/woolnd/CapStoneDesign-iOS/blob/main/%EC%9D%B4%EC%9A%A9%EC%95%BD%EA%B4%80.md")!)
}
