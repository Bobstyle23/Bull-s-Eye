//
//  ContentView.swift
//  BullsEye
//
//  Created by MukhammadBobur Pakhriyev on 2020/07/06.
//  Copyright © 2020 MukhammadBobur Pakhriyev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var randomNumber = Int.random(in: 1...100)
    @State var score = 0
    @State var round = 1
    let midnightBlue = Color(red: 0.0 / 255.0, green: 51.0 / 255.0, blue: 102.0 / 255.0)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.white)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.yellow)
                .modifier(Shadow())
                .font(Font.custom("Arial Rounded MT Bold", size: 24))
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct LargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
        }
    }
    
    struct SmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(.black)
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
        }
    }
    
    
    
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("Put the bullseye as close as you can to: ").modifier(LabelStyle())
                Text("\(self.randomNumber)").modifier(ValueStyle())
                
                
            }
            Spacer()
            HStack{
                Text("1").modifier(LabelStyle())
                Slider(value: self.$sliderValue, in: 0...100).accentColor(.green)
                Text("100").modifier(LabelStyle())
            }
            
            Button(action: {
                self.alertIsVisible = true
                
            }) {
                Text("Hit Me!").modifier(LargeTextStyle())
            }
            .alert(isPresented: $alertIsVisible) {
                () -> Alert in
                let roundedValue = Int(self.sliderValue)
                return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(sliderValueRounded()) \n" +
                    "You scored \(self.earnedPoints()) in this round."), dismissButton: .default(Text("Awesome!")) {
                        self.score = self.score + self.earnedPoints()
                        self.randomNumber = Int.random(in: 1...100)
                        self.round += 1
                    })
            }
            .background(Image("Button")).modifier(Shadow())
            Spacer()
            HStack {
                Button(action: {
                    self.resetGame()
                }) {
                    HStack{
                        Image("StartOverIcon").accentColor(midnightBlue)
                        Text("Start Over").modifier(SmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round:").modifier(LabelStyle())
                Text("\(round)").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: InfoView()) {
                    HStack{
                        Image("InfoIcon").accentColor(midnightBlue)
                        Text("Info").modifier(SmallTextStyle())
                    }
                }
                .background(Image("Button")).modifier(Shadow())
            }
            .padding(.bottom, 20)
            
            
            
        }
        .background(Image("Background"), alignment: .center)
    .accentColor(midnightBlue)
    .navigationBarTitle("Bullseye")
    }
    
    func resetGame() {
        score = 0
        round = 1
        sliderValue = 50.0
        randomNumber = Int.random(in: 1...100)
    }
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    
    func amountOf() -> Int {
        abs(randomNumber - sliderValueRounded())
    }
    
    func earnedPoints() -> Int {
        let maximumScore = 100
        let difference = amountOf()
        let bonus: Int
        
        if difference == 0 {
            bonus = 100
        }
        else if difference == 1{
            bonus = 50
        }
        else {
            bonus = 0
        }
        return maximumScore - difference + bonus
        
    }
    func alertTitle() -> String {
        let difference = amountOf()
        let title: String
        
        if difference == 0 {
            title = "Perfect!"
        }
        else if difference < 5 {
            title = "You almost had it."
        }
        else if difference <= 10 {
            title = "Not bad."
        }
        else {
            title = "Are you even trying?"
        }
        return title
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
