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
    @State private var decider = ["WIN", "LOSE"]
    @State private var score = 0
    @State private var randomChoice = Int.random(in: 0...2)
    @State private var questions = 0
    @State private var check = false
    @State private var checkReset = false
    @State private var needTo = Bool.random()
    
    var body: some View {
        VStack(spacing: 5) {
            
            HStack {
                Spacer()
                Text("Score: \(self.score)/10")
                    .fontWeight(.medium)
            }.padding(.trailing)
            
            Text("You have to \(needTo ? "WIN" : "LOSE")!")
                .font(.system(size: 45))
                .fontWeight(.semibold)
            
            Spacer()
            Spacer()
            
            VStack {
                Text("\(emojiChoices[randomChoice])")
                    .font(.custom("Times New Roman", size: 120))
                Text("\(choices[randomChoice])")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                Spacer()
            }
            
            VStack {
                
                HStack(spacing: 60) {
                    ForEach(0..<3) { move in
                        Button(action: {
                            self.buttonTapped("\(self.choices[move])")
                        }) { VStack {
                            Text("\(self.emojiChoices[move])")
                                .font(.custom("Times New Roman", size: 80))
                            Text("\(self.choices[move])")                         .font(.system(size: 25))
                                .fontWeight(.medium)
                            }
                        }
                    }
                }
                
                Spacer()
                Spacer()
            }
            
            Button(action: {
                self.checkResetButton()
            }) {
                Text("Reset")
                    .foregroundColor(.red)
                    .font(.system(size: 20))
            }
        }
        .alert(isPresented: $check) {
            Alert(title: Text("Game Over"), message: Text("Your score is \(score). Tap OK to restart!"), dismissButton: .default(Text("OK")) {
                self.endGame()
                })
        }
        .alert(isPresented: $checkReset) {
            Alert(title: Text("Are you sure?"), message: Text("If you tap yes, you will lose your current progress. Do you wish to continue?"), primaryButton: .destructive(Text("Yes")) {
                self.resetTapped()
            }, secondaryButton: .cancel((Text("No"))))
        }
    }
    
    func buttonTapped (_ userMove: String) {
        let currentMove = choices[randomChoice]
        questions += 1
        
        if currentMove == userMove {
            score -= 1
            reset()
        } else if needTo {
            if currentMove == "Rock" && userMove == "Paper" {
                score += 1
                reset()
            } else if currentMove == "Paper" && userMove == "Scissors" {
                score += 1
                reset()
            } else if currentMove == "Scissors" && userMove == "Rock" {
                score += 1
                reset()
            } else {
                score -= 1
                reset()
            }
        } else {
            if currentMove == "Rock" && userMove == "Paper" {
                score -= 1
                reset()
            } else if currentMove == "Paper" && userMove == "Scissors" {
                score -= 1
                reset()
            } else if currentMove == "Scissors" && userMove == "Rock" {
                score -= 1
                reset()
            } else {
                score += 1
                reset()
            }
        }
        
        if questions == 10 {
            check = true
        }
    }
    
    func reset() {
        needTo = Bool.random()
        randomChoice = Int.random(in: 0...2)
    }
    
    func endGame() {
        questions = 0
        score = 0
        reset()
    }
    
    func checkResetButton() {
        checkReset = true
    }
    
    func resetTapped() {
        score = 0
        needTo = Bool.random()
        randomChoice = Int.random(in: 0...2)
    }

}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
