//
//  MemoStore.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import Foundation

class MemoStore: ObservableObject {
    @Published var memoList: [Memo] = [
      Memo(content: "memo1"),
      Memo(content: "memo2"),
      Memo(content: "memo3", isSecret: true, password: "1234")
    ]
    
    
    func insertMemo(content: String, isSecret: Bool, password: String) {
        memoList.insert(Memo(content: content, isSecret: isSecret, password: password), at: 0)
        
    }
    func updateMemo(memo: Memo?, content: String, isSecret: Bool, password: String) {
        guard let memo = memo else {
            return
        }
        memo.content = content
        memo.isSecret = isSecret
        memo.password = password
    }
    func deleteMemo(memo: Memo) {
        memoList.removeAll {
            $0.id == memo.id
        }
    }
    func deleteMemo(set: IndexSet) {
        for index in set {
            memoList.remove(at: index)
        }
    }
}
