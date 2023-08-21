//
//  ContentView.swift
//  Moonshot
//
//  Created by Arkadiusz Młynarczyk on 16/08/2023.
//

import SwiftUI



struct ContentView: View {
   
    @State private var isPresented: Bool = false
    
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var isList = false
    let columns = [
        GridItem(.adaptive(minimum: 150))]
    var body: some View {
        
        NavigationView { 
            if (!isList){
                ScrollView {
                    
                    LazyVGrid(columns: columns) {
                        ForEach(missions) {mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            }label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                    VStack{
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundStyle(  .white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground))
                            }
                        }
                    }
                    .padding([.horizontal, .bottom])
                }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme( .dark) //SUPER OPCJA
                
                .toolbar{
                    
                    
                    Toggle("List Mode", isOn:$isList)
                        .toggleStyle(.button)

                        .foregroundStyle(.white.opacity(0.5))
                        
                }
            
                
            }// end of scroll view
            
            
            
            else {
                
                List {
                    Section {
                        ForEach(missions) {mission in
                            NavigationLink {
                                MissionView(mission: mission, astronauts: astronauts)
                            }label: {
                                VStack {
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .padding()
                                        
                                    VStack{
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundStyle(  .white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundStyle(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                }
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .background(.darkBackground)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.lightBackground))
                            }
                        }
                        .listRowBackground(Color.lightBackground.opacity(0.25))
                        
                    }
                    
                    
                    
                }
                
                .navigationTitle("Moonshot")
                
                .background(.darkBackground)
                .scrollContentBackground(.hidden)
                .preferredColorScheme( .dark) //SUPER OPCJA
                
                .toolbar{
                    
                    Toggle("List Mode", isOn:$isList)
                        .toggleStyle(.button)
                        .foregroundStyle(.white.opacity(0.5))
                        .tint(.lightBackground.opacity(5))

                    
                    
                }
                
            }
                
            
            
                
        }//end of navigation view
        
    }
}

#Preview {
    ContentView()
}
