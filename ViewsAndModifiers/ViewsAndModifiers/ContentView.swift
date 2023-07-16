//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Arkadiusz Młynarczyk on 06/07/2023.
//

import SwiftUI

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
           // .foregroundColor(.white)
            .background(.blue)
            .clipShape(Capsule())
    }
}


struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundColor(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
    
    func capsuledText( text: String) -> some View{
        CapsuleText(text: text)
    }
}



struct ContentView: View {
    
    var body: some View {
        
            
        VStack {
            
            CapsuleText(text: "Gryffindor")
                .foregroundColor(.white)
            Text("Hufflepuff")
            Text("")
//                .capsuledText()
                .capsuledText(text: "Hufflepuff")
            Text("Ravenclaw")
                .font(.largeTitle)
            CapsuleText(text: "Slytherin")
                .blur(radius: 3)
                .foregroundColor(.red)
        }
        .font(.title)
        .watermarked(with: "_arkadiuso")
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
