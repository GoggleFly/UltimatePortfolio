//
//  DataController-Awards.swift
//  UltimatePortfolio
//
//  Created by David Ash on 21/07/2024.
//

import Foundation

extension DataController {
    func hasEarned(award: Award) -> Bool {
        switch award.criterion {
        case "issues":
            // true if certain number of issues added
            let fetchRequest = Issue.fetchRequest()
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value

        case "closed":
            // true if certain number of issues closed
            let fetchRequest = Issue.fetchRequest()
            fetchRequest.predicate = NSPredicate(format: "completed = true")
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value

        case "tags":
            // true if certain number of tags created
            let fetchRequest = Tag.fetchRequest()
            let awardCount = count(for: fetchRequest)
            return awardCount >= award.value

        case "unlock":
            return fullVersionUnlocked

        default:
            // unknown award criterion; should never be allowed
            // fatalError("Unknown award criterion: \(award.criterion)")
            return false
        }
    }
}
