//
//  Memo.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import Foundation
import SwiftUI

class Memo: Identifiable, ObservableObject {
    let id: UUID
    @Published var content: String
    @Published var isSecret: Bool = false
    @Published var password: String = ""
    let insertDate: Date
    
    init(content: String, insertDate: Date = Date.now, isSecret: Bool = false, password: String = "", id: UUID = UUID()) {
        self.id = id
        self.content = content
        self.insertDate = insertDate
        self.isSecret = isSecret
        self.password = password
    }
}
