//
//  CustomTabView.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 20/11/2023.
//

import SwiftUI


struct CustomTabView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Characters", systemImage: "person.3.fill")
                }
            
            EpisodeView()
                .tabItem {
                    Label("Episodes", systemImage: "tv")
                       
                }
            
            LocationView()
                .tabItem {
                    Label("Locations", systemImage: "globe")
                }
        }
    }
}

#Preview {
    CustomTabView()
}



