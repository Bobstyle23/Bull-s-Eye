//
//  InfoView.swift
//  BullsEye
//
//  Created by MukhammadBobur Pakhriyev on 2020/07/10.
//  Copyright © 2020 MukhammadBobur Pakhriyev. All rights reserved.
//

import SwiftUI

let beige = Color(red: 255.0 / 255.0, green: 214.0 / 255.0, blue: 179.0 / 255.0)
struct HeadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 30))
            .padding(.bottom, 20)
            .padding(.top, 20)
    }
}

struct TextStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .foregroundColor(.black)
            .font(Font.custom("Arial Rounded MT Bold", size: 16))
            .padding(.leading, 60)
            .padding(.trailing, 60)
            .padding(.bottom, 20)
    }
}


struct InfoView: View {
    var body: some View {
        Group {
        VStack {
            Text("🎯 BullsEye 🎯").modifier(HeadingStyle())
            Text("This is a Bullseye, the game where you can win points and earn fame by dragging a slider.").modifier(TextStyle())
            Text("Your goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.").modifier(TextStyle())
            Text("Enjoy!").modifier(TextStyle()).lineLimit(nil)
        }
        .navigationBarTitle("About BullsEye")
        .background(beige)
        }
    .background(Image("Background"))
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView().previewLayout(.fixed(width: 896, height: 414))
    }
}
