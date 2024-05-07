//
//  ImageLoader.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 28/04/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoader: View {
    var url: URL
    
    var body: some View {
        ImagePackage(url: url)
    }
}

#Preview {
    ImageLoader(url: URL(string: "https://picsum.photos/400")!)
    
}


fileprivate struct ImagePackage: View {
    var url: URL = URL(string: "https://picsum.photos/400")!
    
    var body: some View {
        WebImage(url: url)
            .resizable()
            .scaledToFit()
            .frame(height: 300)
    }
}
