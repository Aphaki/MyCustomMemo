//
//  MemoEdit.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import SwiftUI

struct MemoEdit: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var store: MemoStore
    
    @State var memo: Memo? = nil
    
    @State var content: String = ""
    @State var password: String = ""
    @State var isSecret = false
    
    var body: some View {
            
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(.black)
                    .ignoresSafeArea()
                VStack {
                    Toggle("Secret", isOn: $isSecret)
                            .toggleStyle(.switch)
                            .foregroundColor(.white)
                            .padding(10)
                            .padding(.trailing, 220)
                            .padding(.leading, 10)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.secondary)
                                    .padding(.horizontal, 10)
                            )
                        if isSecret {
                            SecureField("Password", text: $password)
                                .padding()
                                .foregroundColor(.white)
                                .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.gray)
                                    .padding(.horizontal, 5)
                                )
                                .onDisappear{
                                    password = ""
                                }
                        }
                        TextEditor(text: $content)
                            .padding(10)
                            .cornerRadius(3.0)
                            .colorMultiply(.gray)
                            .font(.custom("DEATH-NOTE-B", size: 40, relativeTo: .title3))
                            
                                                        
                    }.navigationTitle(memo != nil ? "Edit Memo" : "New Memo")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItemGroup(placement: .navigationBarTrailing) {
                                    Button {
                                        if let memo = memo {
                                            store.updateMemo(memo: memo, content: content, isSecret: isSecret, password: password)
                                        } else {
                                            store.insertMemo(content: content, isSecret: isSecret, password: password)
                                        }
                                        dismiss()
                                    } label: {
                                        Image(systemName: "square.and.arrow.down")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                }
                            }
                            ToolbarItemGroup(placement: .navigationBarLeading) {
                                    Button {
                                        dismiss()
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.white)
                                            .font(.title2)
                                }
                            }
                    } // toolbar
                        .padding(.top, 20)
            }
        }
        
    }
}

struct MemoEdit_Previews: PreviewProvider {
    static var previews: some View {
        MemoEdit()
            .environmentObject(MemoStore())
    }
}
