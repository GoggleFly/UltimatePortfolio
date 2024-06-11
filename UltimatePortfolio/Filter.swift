//
//  Filter.swift
//  UltimatePortfolio
//
//  Created by David Ash on 10/06/2024.
//

import Foundation

struct Filter: Identifiable, Hashable {
    var id: UUID
    var name: String
    var icon: String
    var minimumModificationDate = Date.distantPast
    var tag: Tag?
    
    static var all = Filter(
        id: UUID(),
        name: "All issues",
        icon: "tray"
    )
    static var recent = Filter(
        id: UUID(),
        name: "Recent issues",
        icon: "clock",
        minimumModificationDate: .now.addingTimeInterval(86400 * -7)
    )
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Filter, rhs: Filter) -> Bool {
        lhs.id == rhs.id
    }
}
