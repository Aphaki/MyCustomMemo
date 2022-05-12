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
                if store.memoList.isEmpty {
                    EmptyListView()
                } else {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.black)
                            .ignoresSafeArea()
                        VStack {
                            Text("Death Note")
                                .font(.custom("DEATH-NOTE-B", size: 60, relativeTo: .largeTitle))
                                .foregroundColor(.white)
                            Button {
                                showHowToUseView = true
                            } label: {
                                Text("How to use it")
                                    .foregroundColor(.red)
                                    .font(.custom("DEATH-NOTE-B", size: 40, relativeTo: .title2))
                            }
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
                            .listStyle(.plain)
                            .navigationTitle(Text(""))
                            .navigationBarTitleDisplayMode(.inline)
                            
                            .toolbar {
                                ToolbarItemGroup(placement: .navigationBarLeading) {
                                    EditButton()
                                        .font(.custom("DEATH-NOTE-B", size: 40))
                                        .foregroundColor(.white)
                                }
                                ToolbarItemGroup(placement: .navigationBarTrailing) {
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
                    
                }
            } //NavigationView
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    self.isLoading = false
                }
            } //onAppear
            if isLoading {
                Rectangle()
                    .foregroundColor(.black)
                    .ignoresSafeArea()
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
        } // ZStack
        
    }
}

struct MainList_Previews: PreviewProvider {
    static var previews: some View {
        MainList()
            .environmentObject(MemoStore())
    }
}


