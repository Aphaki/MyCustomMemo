//
//  MemoStore.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import Foundation
import CoreData

class MemoStore: ObservableObject {
    @Published var memoList: [Memo] = []
    var memoListData: [MemoEntity] = []
    
    let dataManager = PersistenceController.shared
    
    init() {
        fetchData()
        memoList = listdataToList(memoEntitys: memoListData)
    }
    
    func listdataToList(memoEntitys: [MemoEntity]) -> [Memo] {
        var newMemoList = [Memo]()
        if !memoEntitys.isEmpty {
            for memoEntity in memoEntitys {
                let newMemo = Memo(content: memoEntity.content!, insertDate: memoEntity.insertDate!, isSecret: memoEntity.isSecret, password: memoEntity.password!, id: memoEntity.id!)
                newMemoList.insert(newMemo, at: 0)
            }
            return newMemoList
        } else { return [] }
        
    }
    
    
    func fetchData() {
        let request = NSFetchRequest<MemoEntity>(entityName: "MemoEntity")
        do {
       memoListData = try dataManager.container.viewContext.fetch(request)
        } catch let error {
            print("fectching data error : \(error)")
        }
    }
    
    
    func memoToEntity(memo: Memo) -> MemoEntity {
        let memoData = MemoEntity(context: dataManager.container.viewContext)
        memoData.content = memo.content
        memoData.insertDate = memo.insertDate
        memoData.password = memo.password
        memoData.isSecret = memo.isSecret
        memoData.id = memo.id
        return memoData
    }
    
    
    
    func insertMemo(content: String, isSecret: Bool, password: String) {
        let newMemo = Memo(content: content, isSecret: isSecret, password: password)
        memoList.insert(newMemo, at: 0)
        
        let newMemoData = memoToEntity(memo: newMemo)
        memoListData.insert(newMemoData, at: 0)
        dataManager.saveData()
        print("saved data list: \(memoListData)")
    }
    
    
    func updateMemo(memo: Memo?, content: String, isSecret: Bool, password: String) {
        guard let memo = memo else {
            return
        }
        let memoData = memoToEntity(memo: memo)
        memo.content = content
        memo.isSecret = isSecret
        memo.password = password
        
        memoData.content = content
        memoData.isSecret = isSecret
        memoData.password = password
        dataManager.saveData()
        print("saved data list : \(memoListData)")
    }
    func deleteMemo(set: IndexSet) {
        guard let index = set.first else { return }
        memoList.remove(at: index)
        
        let data = memoListData[index]
        dataManager.deleteMemo(entity: data)
        memoListData.remove(at: index)
        
        print("saved data list : \(memoListData)")
    }
    func moveMemo(from: IndexSet, to: Int) {
        memoList.move(fromOffsets: from, toOffset: to)
        memoListData.move(fromOffsets: from, toOffset: to)
        
        print("saved data list : \(memoListData)")
    }
}
