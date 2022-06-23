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
                Color.black
                    .ignoresSafeArea()
                VStack {
                    secretToggle
                    if isSecret {
                        customSecureField
                    }
                    customTextEditor
                } // VStack
                .navigationTitle(memo != nil ? "Edit Memo" : "New Memo")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    // 툴바 - 저장 버튼
                    ToolbarItem(placement: .navigationBarTrailing) { saveButton }
                    // 툴바 - 끄기 버튼
                    ToolbarItem(placement: .navigationBarLeading) { xButton }
                }
                .padding(.top, 20)
            }
        }
        
    }
}
extension MemoEdit {
    private var secretToggle: some View {
        Toggle("Secret", isOn: $isSecret)
            .toggleStyle(.switch)
            .foregroundColor(.white)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.theme.themeSecodary)
                    .padding(.horizontal, 10)
            )

    }
    private var customSecureField: some View {
        SecureField("Password", text: $password)
            .padding()
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.theme.themeSecodary)
                    .padding(.horizontal, 10)
            )
            .onDisappear{
                password = ""
            }
    }
    private var customTextEditor: some View {
        TextEditor(text: $content)
            .padding(10)
            .cornerRadius(3.0)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color.theme.themeSecodary)
                    .padding(.horizontal, 10)
            )
            .foregroundColor(.white)
            .font(.custom("DEATH-NOTE-B", size: 40, relativeTo: .title3))
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
    }
    private var saveButton: some View {
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
    private var xButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.white)
                .font(.title2)
        }
    }
}

struct MemoEdit_Previews: PreviewProvider {
    static var previews: some View {
        MemoEdit()
            .environmentObject(MemoStore())
    }
}
