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
                    Image(systemName: "person.3.sequence")
                }
            
            EpisodeView()
                .tabItem {
                    Image(systemName: "tv")
                        .onTapGesture {
                            dismiss()
                        }
                }
            
            LocationView()
                .tabItem {
                    Image(systemName: "globe")
                        .onTapGesture {
                            dismiss()
                        }
                }
        }
    }
}

#Preview {
    CustomTabView()
}



