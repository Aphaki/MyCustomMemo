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
    
    init() {
        UITextView.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "DEATH-NOTE-B", size: 30) as Any ,
                     .foregroundColor : UIColor(Color.red)]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "DEATH-NOTE-B", size: 30) as Any ,
                     .foregroundColor : UIColor(Color.red)]
    }

    var body: some Scene {
        WindowGroup {
            MainList()
                .environmentObject(store)
        }
    }
}
