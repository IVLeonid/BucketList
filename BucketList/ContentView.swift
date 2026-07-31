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
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(locations) { location in
                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                }
            }
                .mapStyle(MapStyle.hybrid)
                .onTapGesture { position in
                    if let coordinate = proxy.convert(position, from: .local) {
                        let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: coordinate.latitude, longitude: coordinate.longitude)
                        print("Tapped at \(coordinate)")
                    }
                }
        }
    }
}

#Preview {
    ContentView()
}
