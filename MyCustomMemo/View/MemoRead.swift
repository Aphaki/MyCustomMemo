//
//  MemoRead.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/02.
//

import SwiftUI

struct MemoRead: View {
    @ObservedObject var memo: Memo
    
    @State var showEditView = false
    @State var showLockView = false
    @State var showErrorAlert = false
    
    @State var unLockPassword = ""
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
            VStack {
                if memo.isSecret {
                    HStack {
                        Text("🔒 Secret Memo")
                            .font(.custom("DEATH-NOTE-B", size: 40))
                            .foregroundColor(.white)
                            .padding()
                        Spacer()
                    }
                }
                HStack {
                    Text(memo.content)
                        .font(.custom("DEATH-NOTE-B", size: 40))
                        .foregroundColor(.white)
                        .padding()
                    Spacer()
                }
                Spacer()
            } // VStack
            .navigationTitle("Write the name")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                      showEditView = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }.sheet(isPresented: $showEditView) {
                        MemoEdit(memo: memo, content: memo.content, password: memo.password, isSecret: memo.isSecret)
                    }
                }
            } // toolbar
            
            if showLockView {
                Rectangle()
                    .foregroundColor(.black)
                    .edgesIgnoringSafeArea(.bottom)
                VStack {
                    Text("🔒")
                        .font(.system(size: 200))
                        .padding()
                    SecureField("Password", text: $unLockPassword)
                        .font(.custom("DEATH-NOTE-B", size: 40))
                        .padding(10)
                        .background()
                        .frame(width: 137)
                        .cornerRadius(10)
                    Button {
                        if memo.password == unLockPassword {
                            showLockView = false
                        } else {
                            showErrorAlert = true
                        }
                        
                    } label: {
                        Text("UNLOCK")
                            .padding()
                            .background(.pink)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }.padding(.top, 10)
                        .alert("비밀번호가 틀렸습니다", isPresented: $showErrorAlert) {
                            Button {
                                print("Wrong password")
                            } label: {
                                Text("OK")
                            }

                        }
                }
            }
        } // ZStack
        .onAppear{
            if memo.isSecret {
                showLockView = true
            } else {
                showLockView = false
            }
        }
    }
}

struct MemoRead_Previews: PreviewProvider {
    static var previews: some View {
        
        let memo = Memo(content: "Preview memo content", isSecret: false, password: "")
        NavigationView {
            MemoRead(memo: memo)
        }
    }
}
