//
//  PerformanceTests.swift
//  UltimatePortfolioTests
//
//  Created by David Ash on 07/07/2024.
//

import XCTest
@testable import UltimatePortfolio

final class PerformanceTests: BaseTestCase {

    /// Example performance test - tests performance of querying for earned awards against
    /// a large set of sample data and large collection of awards.
    ///
    /// Consider creating dedicated perofmrance testing target in larger projects.
    func testAwardCalculationPerformance() {
        for _ in 1...100 {
            dataController.createSampleData()
        }

        let awards = Array(repeating: Award.allAwards, count: 25).joined()

        XCTAssertEqual(awards.count, 500, "this checks the awards count is constant. Change this if you add awards.")

        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }

}
