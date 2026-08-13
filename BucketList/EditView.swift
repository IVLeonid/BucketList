//
//  EditView.swift
//  BucketList
//
//  Created by Леонід Іванов on 03.08.2026.
//

import SwiftUI

struct EditView: View {
    @Environment(\.dismiss) var dismiss
    var onSave: (Location) -> Void
    @State private var viewModel: ViewModel
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Place name", text: $viewModel.name)
                    TextField("Description", text: $viewModel.description)
                }
                
                Section("Nearby...") {
                    switch viewModel.loadingState {
                    case .loaded:
                        ForEach(viewModel.pages, id: \.pageid) { page in
                            Text("\(page.title): \(page.description)")
                                .font(.headline)
                        }
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    onSave(viewModel.createNewLocation())
                    dismiss()
                }
            }
            .task {
                await viewModel.fetchNearbyPlaces()
            }
            
        }
    }
    
    
    
    init(location: Location, onSave: @escaping (Location) -> Void) {
        self._viewModel = State(initialValue: ViewModel(location: location))
        self.onSave = onSave
    }
}


#Preview {
    EditView(location: .example) { _ in }
}
