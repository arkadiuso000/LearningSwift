//
//  ContentView.swift
//  Animations
//
//  Created by Arkadiusz Młynarczyk on 17/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var animationAmount = 1.0
    var body: some View {
        
        VStack {
                    Stepper("Scale amount", value: $animationAmount.animation(
                        .easeInOut(duration: 1)
                        .repeatCount(3, autoreverses: true)),
                            in: 1...10)
//swiftui "fills" the space between 1 and 2 with animation, the animationAmount increase linear 1 2 3 etc.
                    Spacer()

                    Button("Tap Me") {
                        animationAmount += 1
                    }
                    .padding(40)
                    .background(.red)
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .scaleEffect(animationAmount)
//                    .animation(.linear(duration: 1), value: animationAmount)
                }
        
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
