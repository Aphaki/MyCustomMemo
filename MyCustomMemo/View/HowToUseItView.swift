//
//  HowToUseItView.swift
//  MyCustomMemo
//
//  Created by Sy Lee on 2022/05/07.
//

import SwiftUI

struct HowToUseItView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ScrollView {
                noteRulesHeader
                noteRulesText
            }
            appleRyukButton
        }
    }
}
extension HowToUseItView {
    private var noteRulesText: some View {
        VStack(alignment: .leading) {
            HowToUseContent(content: "@ The human whose name is written in this note shall die.")
            HowToUseContent(content: "@ This note will not take effect unless the writer has the person's face in their mind when writing his/her name. Therefore, people sharing the same name will not be affected.")
            HowToUseContent(content: "@ If the cause of death is written within 40seconds of writing the person's name, it will happen.")
            HowToUseContent(content: "@ After writing the cause of death, deaths of the death should be written in the next 6minutes and 40 seconds.")
            HowToUseContent(content: "@ This note shall become the property of the human world, once it touches the ground of(arrives in) the human world.")
            HowToUseContent(content: "@ The owner of the note can recognize the image and voice of its original owner, i.e.a god of death")
            HowToUseContent(content: "@ The human who uses this note can neither go to Heaven nor Hell")
        }
    }
    private var noteRulesHeader: some View {
        VStack {
            Image("DeathNoteSymbol")
                .frame(width: 100, height: 100)
                .scaleEffect(0.6)
                .clipShape(Circle())
                .offset(y: 50)
            Text("DEATH     NOTE")
                .font(.custom("DEATH-NOTE-B", size: 60))
                .foregroundColor(.white)
            Text("How to use it")
                .font(.custom("DEATH-NOTE-B", size: 40))
                .foregroundColor(.white)
        }
    }
    private var appleRyukButton: some View {
        Button {
            dismiss()
        } label: {
            Image("Apple")
        }.clipShape(Circle())
            .scaleEffect(0.3)
            .offset(x: 120, y: 300)
    }
}

struct HowToUseItView_Previews: PreviewProvider {
    static var previews: some View {
        HowToUseItView()
    }
}

struct HowToUseContent: View {
    var content: String
    var body: some View {
        Text(content)
            .font(.custom("DEATH-NOTE-B", size: 30))
            .foregroundColor(.white)
            .padding(15)
            .minimumScaleFactor(1.0)
        
    }
}
