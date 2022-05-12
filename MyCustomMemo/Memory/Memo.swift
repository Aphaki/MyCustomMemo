//
//  Memo.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import Foundation
import SwiftUI

class Memo: Identifiable, ObservableObject, Codable {
    let id: UUID
    @Published var content: String
    @Published var isSecret: Bool = false
    @Published var password: String = ""
    let insertDate: Date
    
    enum CodingKeys: CodingKey {
        case id
        case content
        case isSecret
        case password
        case insertDate
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        content = try container.decode(String.self, forKey: .content)
        isSecret = try container.decode(Bool.self, forKey: .isSecret)
        password = try container.decode(String.self, forKey: .password)
        insertDate = try container.decode(Date.self, forKey: .insertDate)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(content, forKey: .content)
        try container.encode(isSecret, forKey: .isSecret)
        try container.encode(password, forKey: .password)
        try container.encode(insertDate, forKey: .insertDate)
    }
    
    init(content: String, insertDate: Date = Date.now, isSecret: Bool = false, password: String = "", id: UUID = UUID()) {
        self.id = id
        self.content = content
        self.insertDate = insertDate
        self.isSecret = isSecret
        self.password = password
    }
}
