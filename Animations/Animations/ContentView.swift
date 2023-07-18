//
//  ContentView.swift
//  Animations
//
//  Created by Arkadiusz Młynarczyk on 17/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var enabled = false
    var body: some View {
        
                    Button("Tap Me") {
                        enabled.toggle()
                        }
                    .frame(width: 200, height: 200)
                    .background(enabled ? .blue : .red)
                    .animation(.default, value: enabled)
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
                    .animation(.interpolatingSpring(stiffness: 5, damping: 10), value: enabled)
                    
                    
                    
        
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
