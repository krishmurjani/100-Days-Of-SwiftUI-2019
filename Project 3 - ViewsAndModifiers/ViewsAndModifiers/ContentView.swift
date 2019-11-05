//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Krish Murjani on 27/10/19.
//  Copyright © 2019 Krish Murjani. All rights reserved.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
        
    }
}so

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}
struct ContentView: View {
    var body: some View {
        Text("Hello World")
            .bold()
            .titleStyle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}
