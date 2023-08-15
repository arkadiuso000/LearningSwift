//
//  ContentView.swift
//  iExpense
//
//  Created by Arkadiusz Młynarczyk on 10/08/2023.
//

import SwiftUI



struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            
            List {
                Section{
                    ForEach (expenses.items, id: \.id) { item in
                        if (item.type == "Personal"){
                        HStack{
                            
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                                    .foregroundStyle(
                                        item.amount >= 1000 ? .red : item.amount >= 500 ? .yellow : item.amount <= 10 ? .green : .primary
                                    )
                            } }
                    }
                    .onDelete(perform: removeItems)
                } header: {
                    Text("Personal expenses")
                }
                
                
                Section{
                    ForEach (expenses.items, id: \.id) { item in
                        if (item.type == "Business"){
                        HStack{
                            
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                                    .foregroundStyle(
                                        item.amount >= 1000 ? .red : item.amount >= 500 ? .yellow : item.amount <= 10 ? .green : .primary
                                    )
                            }
                            
                        }
                        
                    }
                    .onDelete(perform: removeItems)
                }header: {
                    Text("Business expenses")
                }
            }
            
            
            
            
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label:{
                    Image(systemName: "plus")
                }
                
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
        
        
        
    }
    
    func removeItems(at offsets: IndexSet) {
//        print(expenses[offsets].name)
//        print(offsets[0])
        for index in offsets {
            print(index)
        }
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
