//
//  LocationView.swift
//  RickAndMorty
//
//  Created by Muktar Hussein on 06/05/2024.
//

import SwiftUI

struct LocationView: View {
    @StateObject private var vm = LocationVM()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.locations) { location in
                    NavigationLink {
                        LocationDetail(
                            locationName: location.name,
                            locationType: location.type,
                            locationDimension: location.dimension,
                            residents: location.residents,
                            url: location.url,
                            created: location.created
                        )
                    } label: {
                        LazyVStack(alignment: .leading) {
                            HStack {
                                Text(location.name)
                            }
                            Text(location.dimension)
                        }
                    }

                }
            }
            .listStyle(.plain)
            .navigationTitle("Locations")
        }
    }
}

#Preview {
    LocationView()
}
