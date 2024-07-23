//
//  DataController-Testing.swift
//  UltimatePortfolio
//
//  Created by David Ash on 23/07/2024.
//

import SwiftUI

extension DataController {
    func checkForTestEnvironment() {
        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            self.deleteAll()
            #if os(iOS)
            UIView.setAnimationsEnabled(false)
            #endif
        }
        #endif
    }
}
