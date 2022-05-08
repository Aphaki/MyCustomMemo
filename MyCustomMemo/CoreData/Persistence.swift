//
//  Persistence.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()


    let container: NSPersistentContainer
    
    // 메모 추가
    func addMemo(memoContent: String, password: String, isSecret: Bool) {
        let newMemo = MemoEntity(context: container.viewContext)
        newMemo.content = memoContent
        newMemo.password = password
        newMemo.isSecret = isSecret
        saveData()
    }
    
    // 세이브
    func saveData() {
        do {
           try container.viewContext.save()
        } catch let error {
            print("Error saving. \(error)")
        }
        
    }
    // 메모 삭제
    func deleteMemo(entity: MemoEntity) {
        container.viewContext.delete(entity)
        saveData()
    }
    
    
    // 코어데이터 가져오기
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "MemoEntity")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("\(storeDescription)")
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
