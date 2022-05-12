//
//  MyCustomMemoApp.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import SwiftUI

@main
struct MyCustomMemoApp: App {
    @StateObject var store = MemoStore()

    var body: some Scene {
        WindowGroup {
            MainList()
                .environmentObject(store)
        }
    }
}
