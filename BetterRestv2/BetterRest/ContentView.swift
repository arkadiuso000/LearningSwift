//
//  ContentView.swift
//  BetterRest
//
//  Created by Arkadiusz Młynarczyk on 09/07/2023.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeTime
    @State private var coffeeAmount = 4
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    var body: some View {
        
        NavigationView{
            Form{
                Section{
                    VStack(spacing: 10){
                        Text("When do you want to wake up?")
                            .font(.headline)
                        
                        DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute  )
                            .labelsHidden()
                    }.frame(maxWidth: .infinity, alignment: .center)
                }
                Section{
                    VStack(alignment: .center, spacing: 10){
                        Text("Desired amount of sleep")
                            .font(.headline)
                        
                        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                    }
                }
                
                Section{
                    VStack(alignment: .center, spacing: 10){
                        Text("Daily coffee intake")
                            .font(.headline)
                        
                        Picker("Tip percentage", selection: $coffeeAmount) {
                            ForEach(1..<20, id: \.self){
                                Text($0, format: .number)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }.onAppear{
                    calculateBedtime()
                }
                
                Section{
                    
                    VStack{
                        Text(alertTitle)
                            .font(.headline)
                        Text("\(alertMessage)")
                            .frame(maxWidth: .infinity, alignment: .center)
                            
                            
                    }
                }
            }
            .navigationTitle("BetterRest")
           
        }
    }
    
    func calculateBedtime() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            do {
                let config = MLModelConfiguration()
                let model = try SleepCalculator(configuration: config)
                
                let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
                let hour = ( components.hour ?? 0) * 60 * 60
                let minute = (components.minute ?? 0) * 60
                
                let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
                
                let sleepTime = wakeUp - prediction.actualSleep
                
                alertTitle = "Your ideal bedtime is..."
                alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            } catch {
                alertTitle = "Error"
                alertMessage = "Sorry, there was a problem calculating your bedtime."
            }
            
            calculateBedtime()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
