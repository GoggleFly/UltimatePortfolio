//
//  ContentView.swift
//  UltimatePortfolio
//
//  Created by David Ash on 10/06/2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataController: DataController
    
    var body: some View {
        List(selection: $dataController.selectedIssue) {
            ForEach(dataController.issuesForSelectedFilter()) { issue in
                IssueRow(issue: issue)
            }
            .onDelete(perform: delete)
        }
        .navigationTitle("Issues")
        .searchable(
            text: $dataController.filterText,
            tokens: $dataController.filterTokens,
            prompt: "Filter issues, or type # to add tags") { tag in
                Text(tag.tagName)
            }
            .searchSuggestions {
                ForEach(dataController.suggestedFilterTokens) { tag in
                    Button(tag.tagName) {
                        dataController.filterTokens.append(tag)
                        dataController.filterText = ""
                    }
                }
            }
            .toolbar {
                ContentViewToolbar()
            }
    }
    
    func delete(_ offsets: IndexSet) {
        let issues = dataController.issuesForSelectedFilter()
        
        for offset in offsets {
            let item = issues[offset]
            dataController.delete(item)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(DataController.preview)
}
