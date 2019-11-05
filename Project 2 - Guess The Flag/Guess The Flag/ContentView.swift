//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Krish Murjani on 18/10/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import SwiftUI

    let first = LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom)
    let second = LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow]), startPoint: .top, endPoint: .bottom)
    let third = LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
    let fourth = LinearGradient(gradient: Gradient(colors: [.white, .gray, .black]), startPoint: .bottom, endPoint: .top)

    var gradients = [first, second, third, fourth]

    var randomBG = Int.random(in: 0...3)

struct FlagImage: View {
    var name: String
    
    var body: some View {
        Image(name)
        .renderingMode(.original)
        .clipShape(Capsule())
        .overlay(Capsule().stroke(Color.black, lineWidth: 3))
        .shadow(color: .black, radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "United Kingdom", "United States"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    var background = Int.random(in: 0...3)
    var body: some View {
       
        ZStack {
            gradients[randomBG].edgesIgnoringSafeArea(.all)
            VStack(spacing: 60) {
//                HStack {
//                    Button("Reset") {
//                        self.askQuestion()
//                        self.score = 0
                    
                   // Spacer()
                    VStack {
                        Text(" ")
                        Text("Tap the flag of")
                            .fontWeight(.semibold)
                           // .frame(width: 150, height: 15)
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                        Text(countries[correctAnswer])
                            .font(.largeTitle)
                            .fontWeight(.black)
                            .foregroundColor(Color.white)
                           // .frame(width: 250, height: 38)
                    }
//                    Spacer()
                //.padding(.init(top: 0, leading: 15, bottom: 0, trailing: 50))
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        FlagImage(name: self.countries[number])
                    }
                }
                ZStack {
                    Capsule()
                        .fill(Color.white)
                        .frame(width: 200, height: 100)
                        .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                        .shadow(color: .black, radius: 1)
                    Text("Score: \(score)")
                        .font(.title)
                        .fontWeight(.semibold)
                    
                }
                Spacer()
                Button("  Reset  ") {
                    gradients.shuffle()
                    self.askQuestion()
                    self.score = 0
                }
                .foregroundColor(.white)
                .background(Color.red)
                .clipShape(RoundedRectangle.init(cornerRadius: 100))
            }
        }
        .alert(isPresented: $showScore) {
            Alert(title: Text(scoreTitle), message: Text("\(scoreMessage) Your score is \(score)."), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
                })
        }
    }
    
    func flagTapped(_ number: Int) {
        if number==correctAnswer {
            score += 1
            scoreTitle = "Correct!"
            scoreMessage = ""
        }
        else {
            scoreTitle = "Wrong!"
            scoreMessage = "The correct answer is Flag No. \(correctAnswer + 1). You chose \(countries[number])."
        }
        showScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
