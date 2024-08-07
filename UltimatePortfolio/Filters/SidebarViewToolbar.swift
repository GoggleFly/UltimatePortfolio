//
//  SidebarViewToolbar.swift
//  UltimatePortfolio
//
//  Created by David Ash on 01/07/2024.
//

import SwiftUI

struct SidebarViewToolbar: ToolbarContent {
    @EnvironmentObject var dataController: DataController
    @Binding var showingAwards: Bool
    @State private var showingStore = false

    var body: some ToolbarContent {
        ToolbarItem(placement: .automaticOrTrailing) {
            Button(action: tryNewTag) {
                Label("Add tag", systemImage: "plus")
            }
            .sheet(isPresented: $showingStore, content: StoreView.init)
            .help("Add tag")
        }

        ToolbarItem(placement: .automaticOrLeading) {
            Button {
                showingAwards.toggle()
            } label: {
                Label("Show awards", systemImage: "rosette")
            }
            .help("Show awards")
        }

        #if DEBUG && !os(watchOS)
        ToolbarItem(placement: .automatic) {
            Button {
                dataController.deleteAll()
                dataController.createSampleData()
            } label: {
                Label("ADD SAMPLES", systemImage: "flame")
            }
        }
        #endif
    }

    func tryNewTag() {
        if dataController.newTag() == false {
            showingStore = true
        }
    }
}
