//
//  MyCustomMemoApp.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import SwiftUI

@main
struct MyCustomMemoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
