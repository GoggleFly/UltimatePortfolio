//
//  DevelopmentTests.swift
//  UltimatePortfolioTests
//
//  Created by David Ash on 06/07/2024.
//

import CoreData
import XCTest
@testable import UltimatePortfolio

final class DevelopmentTests: BaseTestCase {

    func testSampleDataCreationWorks() {
        dataController.createSampleData()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 5, "There should be 5 sample tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "There should be 50 sample issues.")
    }

    // deleteall
    func testDeleteAllWorks() {
        dataController.createSampleData()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 0, "There should be no sample tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 0, "There should be no sample issues.")
    }

    func testExampleTagHasNoIssues() {
        let tag = Tag.example

        XCTAssertEqual(tag.issues?.count, 0, "Example tag should have no issues.")
    }

    func testExampleIssueHasHighPriority() {
        let issue = Issue.example

        XCTAssertEqual(issue.priority, Int16(2), "Example issue should have high priority.")
    }
}
