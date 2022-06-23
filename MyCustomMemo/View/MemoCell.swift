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
            HStack {
                Text(memo.isSecret ? "🔒 " + memo.content : memo.content)
                    .font(.custom("DEATH-NOTE-B", size: 30))
                    .foregroundColor(.white)
                    .background(.black)
                    .lineLimit(1)
                Spacer()
            }
            Text(memo.insertDate, style: .date)
                .font(.caption)
                .foregroundColor(.white)
                .background(.black)
                .listRowBackground(Color.black)
        }.background(.black)
        
    }
}

struct MemoCell_Previews: PreviewProvider {
    static var previews: some View {
        
        MemoCell(memo: Memo(content: "preview example", isSecret: false))
            
    }
}
