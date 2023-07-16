//
//  ContentView.swift
//  Convert
//
//  Created by Arkadiusz Młynarczyk on 30/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 1.0
    @FocusState private var amountIsFocused: Bool
    @State private var convertOption = "length"
    
//        @State private var currentFrom: String
//        @State private var currentTo: String
//        @State private var currentArr = ["none"]
    
    @State private var tempFrom = "Celsius"
    @State private var tempTo = "Fahrenheit"
    
    @State private var lengthFrom = "kilometers"
    @State private var lengthTo = "meters"
    
    @State private var timeFrom = "minutes"
    @State private var timeTo = "seconds"
    
    @State private var volumeFrom = "liters"
    @State private var volumeTo = "milliliters"
    
    
    let convertOptions = ["temp", "length", "time", "volume"]
    
    let temperatureFromToArr = ["Celsius", "Fahrenheit", "Kelvin"]
    
    let lengthFromToArr = ["meters", "kilometers", "feet", "yards", "miles"]
    
    let timeFromToArr = ["seconds", "minutes", "hours", "days"]
    
    let volumeFromToArr = ["milliliters", "liters", "cups", "pints", "gallons"]
    
    
    var output: Double {
        switch convertOption {
        case "length":
            var tempMeter = 0.0
            
            switch lengthFrom{
            case "kilometers":
                tempMeter = amount * 1000.0
            case "meters":
                tempMeter = amount
            case "feet":
                tempMeter = amount * 0.3048
            case "yards":
                tempMeter = amount * 0.9144
            case "miles":
                tempMeter = amount  * 1609.344
            default:
                tempMeter = 0.0
            }
            
            switch lengthTo{
            case "kilometers":
                return tempMeter / 1000.0
            case "meters":
                return tempMeter
            case "feet":
                return tempMeter / 0.3048
            case "yards":
                return tempMeter / 0.9144
            case "miles":
                return tempMeter  / 1609.344
            default:
                return tempMeter
            }
            
        case "temp":
            var tempCel = 0.0
            
            switch tempFrom{
            case "Celsius":
                tempCel = amount
            case "Fahrenheit":
                tempCel = (amount - 32) / 1.8
            case "Kelvin":
                tempCel = amount - 273.15
            
            default:
                tempCel = 0.0
            }
            
            switch tempTo{
            case "Celsius":
                return tempCel
            case "Fahrenheit":
                return tempCel * 1.8 + 32
            case "Kelvin":
                return tempCel + 273.15
        
            default:
                return tempCel
            }
        case "time":
            var tempMinutes = 0.0
            
            switch timeFrom{
            case "seconds":
                tempMinutes = amount / 60.0
            case "minutes":
                tempMinutes = amount
            case "hours":
                tempMinutes = amount * 60.0
            case "days":
                tempMinutes = amount * 1440
            
            default:
                tempMinutes = 0.0
                
                
            }
            
            switch timeTo{
            case "seconds":
                return tempMinutes * 60.0
            case "minutes":
                return tempMinutes
            case "hours":
                return tempMinutes / 60.0
            case "days":
                return tempMinutes / 1440
            
            default:
                return tempMinutes
            }
            
        case "volume":
            var tempLiters = 0.0
            
            switch volumeFrom{
            case "milliliters":
                tempLiters = amount / 1000.0
            case "liters":
                tempLiters = amount
            case "cups":
                tempLiters = amount *  0.2365
            case "pints":
                tempLiters = amount * 0.4731
            case "gallons":
                tempLiters = amount  *  3.7854
            default:
                tempLiters = 0.0
            }
            
            switch volumeTo{
            case "milliliters":
                return tempLiters * 1000.0
            case "liters":
                return tempLiters
            case "cups":
                return tempLiters /  0.2365
            case "pints":
                return tempLiters / 0.4731
            case "gallons":
                return tempLiters  /  3.7854
            default:
                return tempLiters
            }
        default:
            return 0.0
            
        
        }
    
        
    }
    
    var body: some View {
        NavigationView{
            
            Form{
                //section 1 - type of convert
                Section{
                    Picker ("Conversion type", selection: $convertOption){
                        ForEach(convertOptions, id: \.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented)
                    
                }
                //section 2 - convert from + input
                Section{
                    switch convertOption {
                    case "length" :
                        
                        Picker ("Convert from", selection: $lengthFrom){
                            ForEach(lengthFromToArr, id: \.self){
                                Text("\($0)")
                            }
                        }
                        
                    case "temp":
                        Picker ("Convert from", selection: $tempFrom){
                            ForEach(temperatureFromToArr, id: \.self){
                                Text("\($0)")
                            }
                        }
                       
                        
                    case "time":
                        Picker ("Convert from", selection: $timeFrom){
                            ForEach(timeFromToArr, id: \.self){
                                Text("\($0)")
                            }
                        }
                        
                        
                    case "volume":
                        Picker ("Convert from", selection: $volumeFrom){
                            ForEach(volumeFromToArr, id: \.self){
                                Text("\($0)")
                            }
                        }
                        
                    default:
                        Text("")
                        
                    }
                    TextField ("Amount", value: $amount, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                }
                
                //section 3 convert to
                Section{
                    switch convertOption {
                    case "length" :
                        Picker ("Convert to", selection: $lengthTo){
                            ForEach(lengthFromToArr, id: \.self){
                                Text("\($0)")
                            }
                        }
                    case "temp":
                       
                        Picker ("Convert to", selection: $tempTo){
                            ForEach(temperatureFromToArr, id: \.self){
                                Text("\($0)")
                            }
                        }
                        
                    case "time":
                       
                        Picker ("Convert to", selection: $timeTo){
                            ForEach(timeFromToArr, id: \.self){
                                Text("\($0)")
                            }
                        }
                        
                    case "volume":
                        
                        Picker ("Convert to", selection: $volumeTo){
                            ForEach(volumeFromToArr, id: \.self){
                                Text("\($0)")
                            }
                        }
                    default:
                        Text("")
                        
                    }
                }
          
                
                //section 4 - output
                Section{
                    Text("\(output.formatted())")
                        
                } header: {
                    Text("Your output")
                }
                
                
            }
            .navigationTitle("Convert")
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
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
}
