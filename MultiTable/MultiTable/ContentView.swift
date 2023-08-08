//
//  ContentView.swift
//  MultiTable
//
//  Created by Arkadiusz Młynarczyk on 28/07/2023.
//

import SwiftUI



struct ContentView: View {
    @State private var firtsArgument = 2
    @State private var secondArgument = 10
    @State private var questionNum = 5
    
    @State private var questions: [[Int]] = []
    @State private var answers: [Int] = []
 
    
    func generateQuestions (arg1: Int, arg2: Int, range: Int){
        questions = []
        answers = []
        var a = 0
        var b = 0
        for _ in 0..<range {
            a = Int.random(in: arg1...arg2)
            b = Int.random(in: arg1...arg2)
            questions.append([a,b])
            answers.append(a*b)
        }
    }
    
    var body: some View {
        ZStack{
            VStack{
                NavigationView{
                    Form{
                        Section{
                            
                            VStack(spacing: 10){
                                Text("Select 1st argument")
                                    .font(.headline)
                                Stepper("\(firtsArgument.formatted())", value: $firtsArgument, in: 2...20, step: 1)
                            }
                        }
                        Section{
                            VStack(spacing: 10){
                                Text("Select 2nd argument")
                                    .font(.headline)
                                Stepper("\(secondArgument.formatted())", value: $secondArgument, in: 2...20, step: 1)
                            }
                            
                        }
                        
                        Section{
                            VStack(spacing: 10){
                                Text("Select number of questions")
                                    .font(.headline)
                                Stepper("\(questionNum.formatted())", value: $questionNum, in: 5...20, step: 5)
                            }
                        }
                        
                        
                    }//end of form
                    
                    .toolbar{
                        NavigationLink(destination: SecondView(firtsArgument: $firtsArgument, secondArgument: $secondArgument, questionNum: $questionNum, questions: $questions, answers: $answers).onAppear() {
                            self.generateQuestions(arg1: firtsArgument, arg2: secondArgument, range: questionNum)
                        }) {
                            Text("Let's practise!")
                        }
                    }
                    
  
                    
                    .navigationTitle("MultiTable")
                    
                   
                    
                } //end of navigationView
                
               
                
            }//end of higher Vstack
            
        }//end of zstack
        
        
    }
    
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct SecondView: View {
    @Binding var firtsArgument: Int
    @Binding var secondArgument: Int
    @Binding var questionNum: Int
    
    @Binding var questions: [[Int]]
    @Binding var answers: [Int]
    
    @State private var userAnsw = Array(repeating: 0, count: 20)
//    @State private var userAnsw = Array(repeating: 0, count: 20)
    @State private var counter = 0
    
    @State private var points = 0
    
    @FocusState private var answerIsFocused: Bool
    @State private var showingScore = false

    func checkAnsw () -> Int{
        var points = 0
        for index in 0..<questionNum {
            if (userAnsw[index] == answers[index]){
                points += 1
            }
        }
        return points
    }
    
    var body: some View {
        NavigationView{
            Form{
                
                    
                ForEach(0..<questions.count, id: \.self){index in
                    
                        Section{
                            HStack{
                                Text("\(questions[index][0]) x \(questions[index][1]) = ")
                                    .bold()
                                TextField("Enter your answer", value: $userAnsw[index], format: .number)
                                    
                                    .keyboardType(.numberPad) //.numberPad to to samo ale bez kropki
                                    .focused($answerIsFocused)
                                    .onAppear {
                                        UITextField.appearance().clearButtonMode = .whileEditing
                                    }
                                    .foregroundStyle(.cyan)
                                    .bold()
                               
                            }
                       
                        }header:{
                            Text("Question \(index + 1)")
                        }
                }
                
            }
            .navigationTitle("Try your self!")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()

                    Button("Done"){
                        answerIsFocused = false
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("Check"){
                        points = checkAnsw()
                        showingScore = true
                    }
                }
            }
        }
        .alert("Your score is \(points) / \(questionNum)", isPresented: $showingScore){
            Button("Ok", role: .cancel){
                
            }
        }
    }
}

