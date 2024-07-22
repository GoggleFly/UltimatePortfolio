//
//  InlineNavigationBar.swift
//  UltimatePortfolio
//
//  Created by David Ash on 22/07/2024.
//

import SwiftUI

extension View {
    func inlineNavigationBar() -> some View {
        #if os(iOS)
        self.navigationBarTitleDisplayMode(.inline)
        #else
        self
        #endif
    }
}
