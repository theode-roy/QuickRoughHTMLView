//
//  QRHVExampleAppApp.swift
//  QRHVExampleApp
//
//  Created by Théo De Roy on 23/07/2025.
//

import SwiftUI
import QuickRoughHTMLView

@main
struct QRHVExampleAppApp: App {
    var body: some Scene {
        WindowGroup {
            QuickRoughHTMLViewContainer(htmlFilename: "test")
        }
    }
}
