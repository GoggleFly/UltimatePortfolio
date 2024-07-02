//
//  IssueViewToolbar.swift
//  UltimatePortfolio
//
//  Created by David Ash on 01/07/2024.
//

import SwiftUI

struct IssueViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue

    var body: some View {
        Menu {
            Button {
                UIPasteboard.general.string = issue.title
            } label: {
                Label("Copy Issue Title", systemImage: "doc.on.doc")
            }

            Button {
                issue.completed.toggle()
                dataController.save()
            } label: {
                Label(openCloseButtonText, systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }
        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }

    var openCloseButtonText: LocalizedStringKey {
        issue.completed ? "Reopen Issue" : "Close Issue"
    }
}

#Preview {
    IssueViewToolbar(issue: Issue.example)
        .environmentObject(DataController(inMemory: true))
}
