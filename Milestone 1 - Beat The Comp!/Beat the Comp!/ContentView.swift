//
//  ContentView.swift
//  Beat the Comp!
//
//  Created by Krish Murjani on 09/11/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var choices = ["Rock", "Paper", "Scissors"]
    @State private var emojiChoices = ["✊", "🖐", "✌️"]
    @State private var currentChoice =  0
    @State private var decider = ["WIN", "LOSE"]
    @State private var score = 0
    @State private var randomDecider = Int.random(in: 0...1)
    @State private var randomChoice = Int.random(in: 0...2)
    @State private var questions = 0
    @State private var check = false
    
    var body: some View {
        VStack(spacing: 5) {
            
            HStack {
                Spacer()
                Text("Score: \(self.score)")
                    .fontWeight(.medium)
            }.padding(.trailing)
            
            Text("You have to \(decider[randomDecider])!")
                .font(.system(size: 45))
                .fontWeight(.semibold)
            
            Spacer()
            Spacer()
            
            VStack {
                Text("\(emojiChoices[randomChoice])")
                    .font(.custom("Times New Roman", size: 150))
                Text("\(choices[randomChoice])")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                Spacer()
            }
            
            VStack {
                
                HStack(spacing: 60) {
                    ForEach(0..<3) { currentChoice in
                        Button(action: {
                            self.buttonTapped()
                        }) { VStack {
                            Text("\(self.emojiChoices[currentChoice])")
                                .font(.custom("Times New Roman", size: 80))
                            Text("\(self.choices[currentChoice])")
                                .font(.system(size: 30))
                                .fontWeight(.medium)
                                .foregroundColor(Color.blue)
                            
                            }
                        }
                    }
                }
                
                Spacer()
                Spacer()
            }
        }
        .alert(isPresented: $check) {
            Alert(title: Text("Game Over"), message: Text("Tap continue to restart"), dismissButton: .default(Text("Continue")) {
                self.endGame()
                })
        }
    }
    
    func buttonTapped () {
        questions += 1
        if randomChoice == 0 {
            if randomDecider == 0 {
                if currentChoice == randomChoice+1 {
                    score += 1
                    self.reset()
                }
                else if currentChoice == randomChoice+2 {
                    score -= 1
                    self.reset()
                }
            }
            else {
                if currentChoice == randomChoice+1 {
                    score -= 1
                    self.reset()
                }
                else if currentChoice == randomChoice+2 {
                    score += 1
                    self.reset()
                }
            }
        }
        else if randomChoice == 1 {
            if randomDecider == 0 {
                if currentChoice == randomChoice+1 {
                    score += 1
                    self.reset()
                }
                else if currentChoice == randomChoice-1 {
                    score -= 1
                    self.reset()
                }
            }
            else {
                if currentChoice == randomChoice+1 {
                    score -= 1
                    self.reset()
                }
                else if currentChoice == randomChoice-1 {
                    score += 1
                    self.reset()
                }
            }
        }
        else if randomChoice == 2 {
            if randomDecider == 0 {
                if currentChoice == randomChoice-2 {
                    score += 1
                    self.reset()
                }
                else if currentChoice == randomChoice-1 {
                    score -= 1
                    self.reset()
                }
            }
            else {
                if currentChoice == randomChoice-2 {
                    score -= 1
                    self.reset()
                }
                else if currentChoice == randomChoice-1 {
                    score += 1
                    self.reset()
                }
            }
        }
        self.reset()
        
        if questions == 10 {
            check = true
        }
        
    }
    
    func reset() {
        randomDecider = Int.random(in: 0...1)
        randomChoice = Int.random(in: 0...2)
    }
    
    func endGame() {
        questions = 0
        score = 0
        reset()
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
