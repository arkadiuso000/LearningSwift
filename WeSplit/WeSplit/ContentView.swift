//
//  ContentView.swift
//  WeSplit
//
//  Created by Arkadiusz Młynarczyk on 27/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [ 10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage) / 100.0
        
        let amountPerPerson = (checkAmount + (checkAmount * tipSelection)) / peopleCount
        return amountPerPerson
    }
    
    var body: some View {
        NavigationView{
            Form{
                
                //section 1
                Section{
                    TextField("Amount", value: $checkAmount,  format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                        .keyboardType(.decimalPad) //.numberPad to to samo ale bez kropki
                        .focused($amountIsFocused)
                        .onAppear {
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    Picker("Number of people", selection: $numberOfPeople ){
                        
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                        
                    }.pickerStyle(.navigationLink)
                   
                }
                
                
                //section 2
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header:{
                    Text("How much tip do you want to leave?")
                }
                
                //section 2.5
                Section {
                    Text((totalPerPerson * Double(numberOfPeople+2)), format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                } header:{
                    Text("Total bill + tip")
                }
                
                //section 3
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "PLN"))
                        .foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header:{
                    Text("Amount per person")
                        
                }
                
                
           
            }//end of form
            //podwojny done byl poniewaz button byl w form
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()

                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
