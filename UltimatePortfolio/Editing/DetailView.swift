//
//  DetailView.swift
//  UltimatePortfolio
//
//  Created by David Ash on 10/06/2024.
//

import SwiftUI

struct DetailView: View {
    @EnvironmentObject var dataController: DataController

    var body: some View {
        VStack {
            if let issue = dataController.selectedIssue {
                IssueView(issue: issue)
            } else {
                NoIssueView()
            }
        }
        .navigationTitle("Details")
        .inlineNavigationBar()
    }
}

#Preview {
    DetailView()
        .environmentObject(DataController(inMemory: true))
}
