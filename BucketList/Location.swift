//
//  Location.swift
//  BucketList
//
//  Created by Леонід Іванов on 31.07.2026.
//

import Foundation

struct Location: Codable, Equatable, Identifiable {
    let id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double
}
