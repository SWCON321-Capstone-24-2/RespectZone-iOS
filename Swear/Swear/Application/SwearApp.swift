//
//  SwearApp.swift
//  Swear
//
//  Created by 민 on 10/24/24.
//

import SwiftUI

@main
struct SwearApp: App {
    @StateObject private var store = ConservationStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            ListView()
                .task {
                    do {
                        try await store.load()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                    }
                }
                .sheet(item: $errorWrapper) { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
        }
    }
}
