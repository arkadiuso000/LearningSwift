//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Arkadiusz Młynarczyk on 01/07/2023.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    var body: some View {
        Image(image)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var numOfRound = 1
    @State private var actualTapped = 0
    @State private var showingReset = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "US", "UK"].shuffled()
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    
    
    
    
    var body: some View {
        ZStack{
            RadialGradient(stops:[
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location:0.3),
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location:0.3),
                
            ], center: .center, startRadius: 200, endRadius: 650)
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                    
                
                VStack(spacing:15){
                    Text("Tap the flag of")
                        .foregroundStyle(.secondary)
                        .font(.subheadline.weight(.heavy))
                        
                    Text("\(countries[correctAnswer])")
                        
                        .font(.largeTitle.weight(.semibold))
                    
                    ForEach(0..<3){ number in
                        
                        Button {
                            flagTapped(number)
                            actualTapped = number
                            
                        }label:{
                            
                            FlagImage(image: countries[number].lowercased())
                                
//                                .renderingMode(.original)
//                                .clipShape(Capsule())
//                                .shadow(radius: 5)
                        }
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
                
                Text("Round #\(numOfRound)")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                
            }
            .padding()
            
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", role: .cancel, action: askQuestion)
            

        }message: {
            if scoreTitle == "Wrong ❌"{
                Text("It's flag of \(countries[actualTapped])")
            }
        }
        
        .alert("End of game", isPresented: $showingReset){
            Button ("Restart", role: .cancel, action: reset)
        }message: {
            Text("Your score is \(score)/8\nLet's play again")
            
        }
        
        
    }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct ✅"
            score += 1
        }else{scoreTitle = "Wrong ❌"
            if (score > 0){
                score -= 1
            }
            
            
        }
        numOfRound += 1
        showingScore = true
        if (numOfRound == 8){
            showingReset = true
        }
    }
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    func reset(){
        numOfRound = 1
        score = 0
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
