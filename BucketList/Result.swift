//
//  Result.swift
//  BucketList
//
//  Created by Леонід Іванов on 04.08.2026.
//

import Foundation


struct Result: Codable {
    let query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
    var description: String {
        terms?["description"]?.first ?? "No further information"
    }
    
    static func <(lht: Page, rhs: Page) -> Bool {
        lht.title < rhs.title
    }
}

