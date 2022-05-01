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
    
    @State var content: String = ""
    @State var password = ""
    @State var isSecret = false
    var body: some View {
        
        NavigationView {
            
            VStack {
                Toggle("비밀 메모", isOn: $isSecret)
                    .toggleStyle(.switch)
                    .padding(10)
                    .padding(.trailing, 180)
                    .padding(.leading, 10)
                if isSecret {
                    SecureField("Password", text: $password)
                        .padding()
                        .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 5)
                        )
                }
                TextEditor(text: $content)
                    .padding()
                    .navigationTitle("New Memo")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                                Button {
                                    store.insertMemo(content: content, isSecret: isSecret, password: password)
                                    dismiss()
                                } label: {
                                    Image(systemName: "square.and.arrow.down")
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarLeading) {
                            Button {
                                dismiss()
                            } label: {
                                Image(systemName: "x.circle.fill")
                            }
                        }
                        
                }
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
