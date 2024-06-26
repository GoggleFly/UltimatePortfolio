//
//  IssueRow.swift
//  UltimatePortfolio
//
//  Created by David Ash on 13/06/2024.
//

import SwiftUI

struct IssueRow: View {
    @ObservedObject var issue: Issue

    var body: some View {
        NavigationLink(value: issue) {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .imageScale(.large)
                    .opacity(issue.priority == 2 ? 1 : 0)

                VStack(alignment: .leading) {
                    Text(issue.issueTitle)
                        .font(.headline)
                        .lineLimit(1)

                    Text(issue.issueTagsList)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(issue.issueFormattedCreationDate)
                        .font(.subheadline)
                        .accessibilityLabel(issue.issueCreationDate.formatted(date: .abbreviated, time: .omitted))

                    if issue.completed {
                        Text("CLOSED")
                            .font(.body.smallCaps())
                    }
                }
            }
        }
        .accessibilityHint(issue.priority == 2 ? "High priority" : "")
    }
}

#Preview {
    IssueRow(issue: .example)
}
