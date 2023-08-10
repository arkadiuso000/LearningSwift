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

struct ContentView: View {
    @StateObject var user = User()
    var body: some View {
        VStack {
            Text("Your name is \(user.firstname) \(user.lastname)")
                .bold()
            
            TextField("First name", text: $user.firstname)
            TextField("Last name", text: $user.lastname)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
