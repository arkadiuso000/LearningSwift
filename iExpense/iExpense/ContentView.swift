//
//  ContentView.swift
//  iExpense
//
//  Created by Arkadiusz Młynarczyk on 10/08/2023.
//

import SwiftUI

class User: ObservableObject {
    @Published var firstname = "Bilbo"
    @Published var lastname = "Baggins"
    
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

struct ContentView: View {
    @StateObject var user = User()
    
    @State private var showingSheet = false
    
    @State private var showingSheet2 = false
    
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
        }
        .padding()
    }
    
    
}

#Preview {
    ContentView()
}
