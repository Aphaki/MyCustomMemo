//
//  EmptyListView.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/10.
//

import SwiftUI

struct EmptyListView: View {
    @State var animate: Bool = false
    @State var showHowToUseView = false
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
            Image("Ryuk")
                .offset(y: 16)
            ScrollView {
                VStack(spacing: 10) {
                    Text("There are no names!")
                        .font(.custom("DEATH-NOTE-B", size: 60))
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                    
                    Text("Do you want to kill a people?\n Just write the name this note. \nThen nothing is happening.")
                        .font(.custom("DEATH-NOTE-B", size: 30))
                        .foregroundColor(.white)
                        .padding(.bottom, 20)
                    
                    NavigationLink(
                        destination: MemoEdit(),
                        label: {
                            Text("✒️Add the name")
                                .font(.custom("DEATH-NOTE-B", size: 30))
                                .foregroundColor(.white)
                                .font(.headline)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(animate ? .secondary : Color.red)
                                .cornerRadius(10)
                        })
                    .padding(.horizontal, animate ? 30 : 50)
                    .shadow(
                        color: animate ? .secondary.opacity(0.7) : Color.red.opacity(0.7),
                        radius: animate ? 30 : 10,
                        x: 0,
                        y: animate ? 50 : 30)
                    .scaleEffect(animate ? 1.1 : 1.0)
                    .offset(y: animate ? -7 : 0)
                    Button {
                        showHowToUseView = true
                    } label: {
                        Text("How to use it")
                            .font(.custom("DEATH-NOTE-B", size: 35))
                            .foregroundColor(.red)
                    }
                    .padding()
                    .sheet(isPresented: $showHowToUseView) {
                        HowToUseItView()
                    }

                }
                .frame(maxWidth: 400)
                .multilineTextAlignment(.center)
                .padding(40)
                .onAppear(perform: addAnimation)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    func addAnimation() {
        guard !animate else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(
                Animation
                    .easeInOut(duration: 2.0)
                    .repeatForever()
            ) {
                animate.toggle()
            }
        }
    }
    
}



struct EmptyListView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListView()
    }
}
