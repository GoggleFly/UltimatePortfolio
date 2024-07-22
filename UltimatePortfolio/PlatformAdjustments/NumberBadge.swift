//
//  NumberBadge.swift
//  UltimatePortfolio
//
//  Created by David Ash on 22/07/2024.
//

import SwiftUI

extension View {
    func numberBadge(_ number: Int) -> some View {
        #if !os(watchOS)
        self.badge(number)
        #else
        self
        #endif
    }
}
