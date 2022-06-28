//
//  GifImage.swift
//  Chuck Norris jokes
//
//  Created by Radwan Alfakseh on 25/06/2022.
//

import SwiftUI
import WebKit

struct GifImage: UIViewRepresentable {
    
    private let name: String
    init(_ name: String){
        self.name = name
    }

    func makeUIView(context: Context) -> WKWebView{
        let webview = WKWebView()
        let url = Bundle.main.url(forResource: name, withExtension: "gif")!
        let data = try! Data(contentsOf: url)
        webview.load(data, mimeType: "image/gif",
                     characterEncodingName: "UTF-8",
                     baseURL: url)
        return webview
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.reload()
    }
}

struct GifImage_Previews: PreviewProvider {
    static var previews: some View {
        GifImage("download")
    }
}
