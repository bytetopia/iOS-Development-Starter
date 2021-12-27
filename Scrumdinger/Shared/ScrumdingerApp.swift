//
//  ScrumdingerApp.swift
//  Shared
//
//  Created by anthony on 2021/12/25.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @StateObject private var store = ScrumStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $store.scrums) {
                    // use Task {} to call async functions
                    Task {
                        do {
                            try await ScrumStore.save(scrums: store.scrums)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
//                    === The old way to call save
//                    ScrumStore.save(scrums: store.scrums) { result in
//                        if case .failure(let error) = result {
//                            fatalError(error.localizedDescription)
//                        }
//                    }
                }
            }
            .task {
                // use .task view modifier to call the closure when view appears
                do {
                    store.scrums = try await ScrumStore.load()
                } catch {
                    errorWrapper = ErrorWrapper(error: error, guidance: "Scrumdinger will load sample data and continue.")
                }
            }
            .sheet(item: $errorWrapper, onDismiss: {
                store.scrums = DailyScrum.sampleData
            }) { wrapper in
                ErrorView(errorWrapper: wrapper)
            }
//            The old way to call load
//            .onAppear {
//                ScrumStore.load { result in
//                    switch result {
//                        case .failure(let error):
//                            fatalError(error.localizedDescription)
//                        case .success(let scrums):
//                            store.scrums = scrums
//                        }
//                }
//            }
        }
    }
}
