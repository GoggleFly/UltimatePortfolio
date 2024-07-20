//
//  ContentView.swift
//  UltimatePortfolio
//
//  Created by David Ash on 10/06/2024.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.requestReview) var requestReview
    @StateObject var viewModel: ViewModel

    init(dataController: DataController) {
        let viewModel = ViewModel(dataController: dataController)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    func askForReview() {
        if viewModel.shouldRequestReview {
            requestReview()
        }
    }

    func openURL(_ url: URL) {
        if url.absoluteString.contains("newIssue") {
            viewModel.dataController.newIssue()
        }
    }

    var body: some View {
        List(selection: $viewModel.selectedIssue) {
            ForEach(viewModel.dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: viewModel.delete)
        }
        .navigationTitle("Issues")
        .searchable(
            text: $viewModel.filterText,
            tokens: $viewModel.filterTokens,
            prompt: "Filter issues, or type # to add tags") { tag in
                Text(tag.tagName)
            }
            .searchSuggestions {
                ForEach(viewModel.suggestedFilterTokens) { tag in
                    Button(tag.tagName) {
                        viewModel.filterTokens.append(tag)
                        viewModel.filterText = ""
                    }
                }
            }
            .toolbar(content: ContentViewToolbar.init)
            .onAppear(perform: askForReview)
            .onOpenURL(perform: openURL)
    }
}

#Preview {
    ContentView(dataController: DataController.preview)
}
