//
//  ContentView.swift
//  Animations
//
//  Created by Arkadiusz Młynarczyk on 17/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 0.0
    var body: some View {
        
                    Button("Tap Me") {
                        withAnimation(
                            .interpolatingSpring(stiffness: 5, damping: 1)){
                            animationAmount += 360
                        }
                    }
                    .padding(40)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .rotation3DEffect(.degrees(animationAmount), axis: (x: 1, y: 1, z: 0))
                    
        
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
