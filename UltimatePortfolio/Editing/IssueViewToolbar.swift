//
//  IssueViewToolbar.swift
//  UltimatePortfolio
//
//  Created by David Ash on 01/07/2024.
//

import CoreHaptics
import SwiftUI

struct IssueViewToolbar: View {
    @EnvironmentObject var dataController: DataController
    @ObservedObject var issue: Issue

    @State private var engine = try? CHHapticEngine()

    var body: some View {
        Menu {
            Button("Copy Issue Title", systemImage: "doc.on.doc", action: copyToClipboard)
            Button(action: toggleCompleted) {
                Label(openCloseButtonText, systemImage: "bubble.left.and.exclamationmark.bubble.right")
            }
//            .sensoryFeedback(trigger: issue.completed) { _, newValue in
//                if newValue {
//                    .success
//                } else {
//                    nil
//                }
//            }
        } label: {
            Label("Actions", systemImage: "ellipsis.circle")
        }
    }

    var openCloseButtonText: LocalizedStringKey {
        issue.completed ? "Reopen Issue" : "Close Issue"
    }

    func toggleCompleted() {
        issue.completed.toggle()
        dataController.save()

        if issue.completed {
            do {
                try engine?.start()

                let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
                let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)

                let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1)
                let end = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 0)

                let parameter = CHHapticParameterCurve(
                    parameterID: .hapticIntensityControl,
                    controlPoints: [start, end],
                    relativeTime: 0
                )

                let event1 = CHHapticEvent(
                    eventType: .hapticTransient,
                    parameters: [intensity, sharpness],
                    relativeTime: 0
                )

                let event2 = CHHapticEvent(
                    eventType: .hapticContinuous,
                    parameters: [intensity, sharpness],
                    relativeTime: 0.125,
                    duration: 1
                )

                let pattern = try CHHapticPattern(events: [event1, event2], parameterCurves: [parameter])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                // haptics didn't work; fail quietly
            }
        }
    }

    func copyToClipboard() {
        #if os(iOS)
        UIPasteboard.general.string = issue.title
        #else
        NSPasteboard.general.prepareForNewContents()
        NSPasteboard.general.setString(issue.issueTitle, forType: .string)
        #endif
    }
}

#Preview {
    IssueViewToolbar(issue: Issue.example)
        .environmentObject(DataController(inMemory: true))
}
