//
//  MemoStore.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import Foundation

class MemoStore: ObservableObject {
    @Published var memoList: [Memo] = [] {
        didSet {
            saveMemo()
        }
    }
    
    init() {
        fetchMemo()
    }
    let memoListKey = "memo_list"
    
    func insertMemo(content: String, isSecret: Bool, password: String) {
        let newMemo = Memo(content: content, isSecret: isSecret, password: password)
        memoList.insert(newMemo, at: 0)
    }
    
    
    func updateMemo(memo: Memo?, content: String, isSecret: Bool, password: String) {
        guard let memo = memo else {
            return
        }
        
        memo.content = content
        memo.isSecret = isSecret
        memo.password = password
        
    }
    func deleteMemo(set: IndexSet) {
        guard let index = set.first else { return }
        memoList.remove(at: index)
    }
    func moveMemo(from: IndexSet, to: Int) {
        memoList.move(fromOffsets: from, toOffset: to)

    }
    
    //MARK: - UserDefaults Method
    func saveMemo() {
        if let encodedData = try? JSONEncoder().encode(memoList) {
            UserDefaults.standard.set(encodedData, forKey: memoListKey)
        } else {
            print("Encode Error occured")
        }
    }
    func fetchMemo() {
        guard
            let data = UserDefaults.standard.data(forKey: memoListKey),
            let savedMemos = try? JSONDecoder().decode([Memo].self, from: data) else {
            print("Decode Error occured")
            return }
        self.memoList = savedMemos
    }
}
