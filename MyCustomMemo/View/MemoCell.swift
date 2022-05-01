//
//  MemoCell.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import SwiftUI

struct MemoCell: View {
    
    @ObservedObject var memo: Memo
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(memo.isSecret ? "🔒 비밀메모" : memo.content)
                .font(.headline)
                .lineLimit(1)
            Text(memo.insertDate, style: .date)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        
        MemoCell(memo: Memo(content: "preview example", isSecret: false))
            
    }
}
