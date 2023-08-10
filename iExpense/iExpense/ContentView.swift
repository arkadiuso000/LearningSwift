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

struct ContentView: View {
    @StateObject var user = User()
    
    @State private var showingSheet = false
    var body: some View {
        VStack {
            Text("Your name is \(user.firstname) \(user.lastname)")
                .bold()
            
            TextField("First name", text: $user.firstname)
            TextField("Last name", text: $user.lastname)
            
            Button ("Show sheet"){
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet) {
                SecondView(name: user.firstname)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
