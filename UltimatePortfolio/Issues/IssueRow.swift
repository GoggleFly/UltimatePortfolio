//
//  IssueRow.swift
//  UltimatePortfolio
//
//  Created by David Ash on 13/06/2024.
//

import SwiftUI

struct IssueRow: View {
    @StateObject var viewModel: ViewModel

    init(issue: Issue) {
        let viewModel = ViewModel(issue: issue)
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationLink(value: viewModel.issue) {
            HStack {
                Image(systemName: "exclamationmark.circle")
                    .imageScale(.large)
                    .opacity(viewModel.iconOpacity)
                    .accessibilityIdentifier(viewModel.iconIdentifier)

                VStack(alignment: .leading) {
                    Text(viewModel.issueTitle)
                        .font(.headline)
                        .lineLimit(1)

                    Text(viewModel.issueTagsList)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(viewModel.creationDate)
                        .font(.subheadline)
                        .accessibilityLabel(viewModel.accessibilityCreationDate)

                    if viewModel.completed {
                        Text("CLOSED")
                            .font(.body.smallCaps())
                    }
                }
            }
        }
        .accessibilityHint(viewModel.accessibilityHint)
        .accessibilityIdentifier(viewModel.issueTitle)
    }
}

#Preview {
    IssueRow(issue: .example)
}
