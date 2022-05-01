//
//  MainList.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import SwiftUI

struct MainList: View {
    @EnvironmentObject var store: MemoStore
    @State private var showEditView = false
    var body: some View {
        
        NavigationView {
            List(store.memoList) { memo in
                MemoCell(memo: memo)
            }
            .listStyle(.plain)
            .navigationTitle("Memo List 📕")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showEditView = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.title2)
                            .padding()
                    }
                }
            }.sheet(isPresented: $showEditView) {
                MemoEdit()
            }
        }
    }
}

struct MainList_Previews: PreviewProvider {
    static var previews: some View {
        MainList()
            .environmentObject(MemoStore())
    }
}


