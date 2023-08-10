//
//  ContentView.swift
//  iExpense
//
//  Created by Arkadiusz Młynarczyk on 10/08/2023.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstname = "(k)Opel"
    @Published var lastname = "Astra"
    
}



struct SecondView: View {
    let name: String
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("hello, \(name)")
        Button("Dismiss"){dismiss()}
    }
}

struct ThirdView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
    var body: some View {
        NavigationStack{
            VStack{
                List {
                    ForEach(numbers, id: \.self){
                        Text("Row \($0)")
                    }
                    .onDelete(perform: removeRows)
                    
                }
                
                Button ("Add Number"){
                    numbers.append(currentNumber)
                    currentNumber += 1
                }
            }
            .navigationTitle("onDelete()")
            .toolbar{
                EditButton()
            }
        }
        
    }
    
    func removeRows(at offsets: IndexSet){
        numbers.remove(atOffsets: offsets)
    }
}

struct FourthView: View {
    
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap") //wersja 2
    @AppStorage("Tap") private var tapCount = 0
    var body: some View {
        Button("Tap count: \(tapCount)"){
            tapCount += 1
//            UserDefaults.standard.set(tapCount, forKey: "Tap") //wersja 2
        }
    }
}



struct BetterUser: Codable {
    var firstname: String
    var lastname: String
    var age: Int
}

struct FivthView: View {
    @State private var user = BetterUser(firstname: "Taylor", lastname: "Swift", age: 29)
    @FocusState private var answerIsFocused: Bool
    var body: some View {
        VStack{
            Form{
                Text("Enter your name")
                    .font(.headline)
                    
                TextField("Name", text: $user.firstname)
                Text("Enter your lastname")
                    .font(.headline)
                TextField("Lastname", text: $user.lastname)
                Text("Enter your age")
                    .font(.headline)
                TextField("Age", value: $user.age, format: .number)
                    .keyboardType(.numberPad) //.numberPad to to samo ale bez kropki
                    .focused($answerIsFocused)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
            }
            
            Button("Save User",  role: .cancel){
                let encoder = JSONEncoder()
                
                if let data = try? encoder.encode(user){
                    UserDefaults.standard.set(data, forKey: "UserData")
                }
            }
        }
    }
}

struct ContentView: View {
    @StateObject var user = User()
    
    @State private var showingSheet = false
    
    @State private var showingSheet2 = false
    
    @State private var showingSheet3 = false
    
    @State private var showingSheet4 = false

    
    
    var body: some View {
        VStack {
            Text("Your name is \(user.firstname) \(user.lastname)")
                .bold()
            
            TextField("First name", text: $user.firstname)
            TextField("Last name", text: $user.lastname)
            
            Button ("Show sheet1"){
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: user.firstname)
            }
            
            Button ("Show sheet2"){
                showingSheet2.toggle()
            }
            .sheet(isPresented: $showingSheet2) {
                ThirdView()
            }
            
            Button ("Show sheet3"){
                showingSheet3.toggle()
            }
            .sheet(isPresented: $showingSheet3) {
                FourthView()
            }
            
            Button ("Show sheet4"){
                showingSheet4.toggle()
            }
            .sheet(isPresented: $showingSheet4) {
                FivthView()
            }
        }
        .padding()
    }
    
    
}

#Preview {
    ContentView()
}
