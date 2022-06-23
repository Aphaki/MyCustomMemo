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
    @State private var showHowToUseView = false
    @State private var isLoading = true
    
    var body: some View {
        ZStack {
            NavigationView {
                // 메모 리스트가 비어있을때 띄워주는 EmptyListView
                if store.memoList.isEmpty {
                    EmptyListView()
                } else {
                    // 메모 리스트 (데스노트 글귀 + How to use it 버튼 + 메모 리스트)
                    ZStack {
                        Color.black
                            .ignoresSafeArea()
                        VStack {
                            // 데스 노트 글귀
                            Text("Death Note")
                                .font(.custom("DEATH-NOTE-B", size: 60, relativeTo: .largeTitle))
                                .foregroundColor(.white)
                            // How to use it 버튼
                            howToUseItButton
                            
                            // 메모 리스트
                            memoList
                                .listStyle(.plain)
                                .navigationBarTitleDisplayMode(.inline)
                                .toolbar {
                                    // 에디트 버튼
                                    ToolbarItem(placement: .navigationBarLeading) {
                                        EditButton()
                                            .font(.custom("DEATH-NOTE-B", size: 40))
                                            .foregroundColor(.white)
                                    }
                                    // 메모 추가 버튼
                                    ToolbarItem(placement: .navigationBarTrailing) {
                                        Button {
                                            showEditView = true
                                        } label: {
                                            Image(systemName: "square.and.pencil")
                                                .font(.title2)
                                                .foregroundColor(.white)
                                                .padding()
                                        }
                                    }
                                }.sheet(isPresented: $showEditView) {
                                    MemoEdit()
                                }
                                .sheet(isPresented: $showHowToUseView) {
                                    HowToUseItView()
                                }
                        }
                    }// ZStack
                    
                } // Memo List View
            } //NavigationView
            // 로딩뷰 제어
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isLoading = false
                }
            }
            if isLoading {
                loadingView
            }
        } // ZStack
        
    }
}
extension MainList {
    private var howToUseItButton: some View {
        Button {
            showHowToUseView = true
        } label: {
            Text("How to use it")
                .foregroundColor(.red)
                .font(.custom("DEATH-NOTE-B", size: 40, relativeTo: .title2))
        }
    }
    private var memoList: some View {
        List {
            ForEach(store.memoList) { memo in
                NavigationLink {
                    MemoRead(memo: memo)
                } label: {
                    MemoCell(memo: memo)
                }
            }
            .onMove { indexSet, int in
                store.moveMemo(from: indexSet, to: int)
            }
            .onDelete { indexSet in
                store.deleteMemo(set: indexSet)
            }
            .listRowBackground(Color.black)
            .listRowSeparatorTint(.white)
        }
    }
    private var loadingView: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Text("DEATH  NOTE")
                    .font(.custom("DEATH-NOTE-B", size: 60))
                    .padding(.top, 150)
                    .foregroundColor(.white)
                Spacer()
                ProgressView()
                    .scaleEffect(1.5)
                    .foregroundColor(.white)
                    .padding(.bottom, 300)
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


