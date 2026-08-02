//
//  ContentView.swift
//  BucketList
//
//  Created by Леонід Іванов on 27.07.2026.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 48.46, longitude: 35.02),
            span: MKCoordinateSpan(latitudeDelta: 0.15, longitudeDelta: 0.15)
        )
    )
    
    @State private var locations = [Location] ()
    @State private var selectedPlace: Location?
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition, selection: $selectedPlace) {
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(.circle)
                    }
                    .tag(location)
                }
            }
            .mapStyle(MapStyle.hybrid)
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                    locations.append(newLocation)
                }
            }
            .sheet(item: $selectedPlace) { place in
                Text(place.name)
            }
        }
    }
}

#Preview {
    ContentView()
}
