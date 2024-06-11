//
//  UltimatePortfolioApp.swift
//  UltimatePortfolio
//
//  Created by David Ash on 10/06/2024.
//

import SwiftUI

@main
struct UltimatePortfolioApp: App {
    @StateObject var dataController = DataController()
    @State private var preferredColumn = NavigationSplitViewColumn.detail
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView(preferredCompactColumn: $preferredColumn) {
                SidebarView()
            } content: {
                ContentView()
            } detail: {
                DetailView()
            }
            .environment(\.managedObjectContext, dataController.container.viewContext)
            .environmentObject(dataController)
        }
    }
}
