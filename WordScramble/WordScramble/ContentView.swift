//
//  ContentView.swift
//  WordScramble
//
//  Created by Arkadiusz Młynarczyk on 13/07/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var userScore = 0
    
    var body: some View {
        
        VStack{
            NavigationView{
                
                List{
                    Section{
                        TextField("Enter your word", text: $newWord)
                            .textInputAutocapitalization(.never)
                        
                    }header:{
                        Text("make words out of the word above")
                    }
                    Section{
                        ForEach(usedWords, id: \.self){word in
                            HStack{
                                Image(systemName: "\(word.count).circle")
                                Text(word)
                            }
                        }
                    }
                    
                    
                    
                }
                .toolbar {
                    Button("Restart", role: .cancel){
                        let seconds = 0.5
                        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                            startGame()
                        }
                        
                    }
                }
                
                .navigationTitle(rootWord)
                .onSubmit {
                    addNewWord()
                }
                .onAppear(perform: startGame)
                .alert(errorTitle, isPresented: $showingError){
                    Button("OK", role: .cancel){
                        newWord = ""
                    }
                    
                    
                }message:{
                    Text(errorMessage)
                }
                
                
                
                
            }
            Text("Score: \(userScore)")
                .bold()
                .font(.subheadline)
            
        }
        

        
        
    }
    
    func addNewWord(){
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else {return}
        
        guard isOriginal(word: answer) else{
            wordError(title: "Word used already", message: "Be more original")
//            newWord = ""
            return
        }
        
        guard isPossible(word: answer) else{
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
//            newWord = ""
            return
        }
        
        guard isReal(word: answer) else{
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
//            newWord = ""
            return
        }
        guard isShort(word: answer) else{
            wordError(title: "Too short Buddy 😏", message: "Be more creative")
//            newWord = ""
            return
        }
        userScore += answer.count
        usedWords.insert(answer, at: 0)
        newWord = ""
    }
    
    func startGame(){
        newWord = ""
        userScore = 0
        usedWords = []
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    func isShort(word: String) -> Bool{
        !(word.count < 3)
    }
    func isOriginal(word: String) -> Bool {
       !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool{
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter){
                tempWord.remove(at: pos)
            } else{
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
