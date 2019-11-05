//
//  ContentView.swift
//  Unit Conversion
//
//  Created by Krish Murjani on 14/10/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import SwiftUI
import UIKit

extension View {
    func dismissKeyboard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
    
}
struct ContentView: View {
    @State private var temp = ""
    @State private var tempChoiceInput = 1
    @State private var tempChoiceOutput = 2
    
    let tempChoices = ["Celsius", "Farenheit", "Kelvin"]
    
    func convertToBase() -> Double {
        guard let input = Double(temp) else { return 0 }
        
        if tempChoiceInput == 0 {
            return input + 273.15
        }
        else if tempChoiceInput == 1 {
            return (input + 459.67)*(5/9)
        }
        else {
            return input
        }
    }
    
    func convertToAnswer() -> Double {
        if tempChoiceOutput == 0 {
            return (convertToBase() - 273.15)
        }
        else if tempChoiceOutput == 1 {
            return ((convertToBase() - 273.15)*(9/5)) + 32
        }
        else {
            return convertToBase()
        }
    }
    
    func addUnit() -> String {
        let answer = convertToAnswer()
        let finalAnswer = String(format: "%.2f", answer)
        if tempChoiceOutput == 0 {
            return "\(finalAnswer)°C"
        }
        else if tempChoiceOutput == 1 {
            return "\(finalAnswer)°F"
        }
        else {
            return "\(finalAnswer)K"
        }
    }
    
    
    
    var body: some View {
        
        NavigationView {
            Form {
                TextField("Enter Temperature", text: $temp)
                    .keyboardType(.decimalPad)
                    .onTapGesture {
                        self.dismissKeyboard()
                }
                
                Section(header: Text("What value will you be converting?")) {
                    Picker("Temperature", selection: $tempChoiceInput) {
                        ForEach(0..<tempChoices.count) {
                            Text("\(self.tempChoices[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("What value do you require?")) {
                    Picker("", selection: $tempChoiceOutput) {
                        ForEach(0..<tempChoices.count) {
                            Text("\(self.tempChoices[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                    Text("\(addUnit())")
                        .bold()
                }
                
            }.navigationBarTitle("Hot & Cold")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
