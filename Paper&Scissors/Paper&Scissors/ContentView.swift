//
//  ContentView.swift
//  Paper&Scissors
//
//  Created by Arkadiusz Młynarczyk on 08/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var aiChoose = Int.random(in: 0...2)
    @State private var playerChoose = 0
    @State private var numOfRound = 1
    @State private var points = 0
    @State private var result = "match"
    
    @State private var showingScore = false
    @State private var showingReset = false
    let iconArr = ["🧻", "✂️", "🪨"]
    var body: some View {
        ZStack{
            RadialGradient(colors: [.orange ,.black], center: .center, startRadius: 0, endRadius: 400)
                .ignoresSafeArea()
            
            
            VStack{
                Spacer()
                Text("Paper&Scissors")
                    
                
                    .font(.largeTitle.bold())
                    .foregroundColor(.gray)
                    Spacer()
                    Spacer()
                    Spacer()
                
                VStack(spacing: 15){
                    
                    Text("Choose your weapon")
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                        .font(.title2)
                        .frame(maxWidth: 300)
                            .padding(.vertical, 20)
                            .background(Color(UIColor.darkGray))
                            
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                        
                    Spacer()
                    
                    ForEach(0..<3){ number in
                        Button {
                            playerChoose = number
                            playerTap(number)
                        }label:{
                            
                            Text("\(iconArr[number])")
                                .font(.system(size:100))
                        }
                    }.shadow(radius: 15)
                   Spacer()
                }
                
                
                Spacer()
                Spacer()
                Text("Round #\(numOfRound)")
                    .foregroundColor(.gray)
                    .font(.title.bold().italic())
                    
                
            }.alert("\(result)", isPresented: $showingScore){
                Button("Continue", role: .cancel, action: newRound)
            }message: {
                if (result == "Match 👌"){
                    Text("Your an AI's guess is the same (\(iconArr[aiChoose]))")
                }
                else if (result == "Win ✅"){
                    Text("Congrats you won\nAI's guess: \(iconArr[aiChoose])")
                }
                else {
                    Text("Maybe better next time\nAI's guess: \(iconArr[aiChoose])")
                }
                
            }
            .alert("End of Game", isPresented: $showingReset){
                Button("Restart", role: .cancel, action: reset)
            }message: {
                if (points < 5){
                    Text("It wasn't your game,\n maybe better next time 😕\n Cya 🫡")
                }
                else {
                    Text("You have won \(points) times for 10 rounds\nCongrats! 🥳")
                }
            }
        }
        
        
       
        
        
    }
    func playerTap (_ pChoose: Int){
        if (aiChoose == pChoose){
            result = "Match 👌"
        }
        else if ((aiChoose == 0 && pChoose == 1) || (aiChoose == 1 && pChoose == 2) || (aiChoose == 2 && pChoose == 0) ){
            result = "Win ✅"
            points += 1
        }
        else {
            result = "Fail ❌"
        }
        numOfRound += 1
        showingScore = true
        if (numOfRound == 10){
            showingReset = true
        }
        
        
    }
    
    func reset(){
        points = 0
        numOfRound = 1
    }
    
    func newRound(){
        aiChoose = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
