//
//  ContentView.swift
//  WeSplit
//
//  Created by Krish Murjani on 13/10/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import SwiftUI

extension View {
    func dismissKeyboard() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = ""
    @State private var tipPercentage = 5
    
    let tipPercentages = [5, 10, 15, 20, 25, 0]
    
    func checkTip() -> Bool {
        if self.tipPercentage == 5 {
            return true
        }
        else {
            return false
        }
    }
    
    func billAmount () -> Double {
        return Double(checkAmount) ?? 0
    }
    
    func tipAmount() -> Double {
        let tip = Double(tipPercentages[tipPercentage])/100
        return billAmount()*tip
    }
    
    func calculateTotal() -> Double {
        return billAmount()+tipAmount()
    }
    
    func perPerson() -> Double {
        guard let peopleCount = Double(numberOfPeople) else { return 0 }
        
        return calculateTotal()/peopleCount
    }
    
//    var grandTotal: Double {
//        let tipSelection = Double(tipPercentages[tipPercentage])
//        let orderAmount = Double(checkAmount) ?? 0
//
//        let tipValue = orderAmount/100 * tipSelection
//
//        return orderAmount + tipValue
//    }
//    var totalPerPerson: Double {
//
//        guard let peopleCount = Double(numberOfPeople) else { return 0 }
//        let tipSelection = Double(tipPercentages[tipPercentage])
//        let orderAmount = Double(checkAmount) ?? 0
//
//        let tipValue = orderAmount/100 * tipSelection
//        let grandTotal = orderAmount + tipValue
//        let amountPerPerson = grandTotal/peopleCount
//
//        return amountPerPerson
//    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2..<100) {
//                            Text("\($0) people")
//                        }
//                    }
                    .onTapGesture {
                            self.dismissKeyboard()
                    }
                    TextField("Number of People", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                    .onTapGesture {
                            self.dismissKeyboard()
                    }
                }
                Section(header: Text("How much tip would you like to leave?")) {
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(0..<tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Each person owes:")) {
                    Text("$\(perPerson(), specifier: "%.2f")")
                }
                Section(header: Text("Grand Total")) {
                    Text("$\(billAmount(), specifier: "%.2f") + $\(tipAmount(), specifier: "%.2f")")
                        .fontWeight(.light)
                    
                    Text("$\(calculateTotal(), specifier: "%.2f")")
                        .fontWeight(.bold)
                        .foregroundColor(checkTip() ? .red : .)
                    
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
