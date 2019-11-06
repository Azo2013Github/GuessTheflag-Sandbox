//
//  ContentView.swift
//  GuessTheflag-Sandbox
//
//  Created by Mati on 05/11/2019.
//  Copyright © 2019 Mati. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia","France", "Germany",
        "Ireland", "Italy", "Nigeria","Poland", "Russia","Spain","UK","US"]
        .shuffled()
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
       
        ZStack {
            Color(red: 0 / 255,
                  green: 128 / 255,
                  blue: 128 / 255
                ).edgesIgnoringSafeArea(.all)
            
            //Color.purple.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30){
                VStack {
                    Text("Tap me")
                    Text(countries[correctAnswer])
                }
                ForEach(0 ..< 3){ number in
                    Button(action: {
                        self.flagTapped(number)
                        print("You are tapped in the button: \(self.countries[number])")
                    }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                    }
                }
                Spacer()
            }
            
        }.alert(isPresented: $showingScore) {
              Alert(title: Text(scoreTitle),
                    message: Text("Your score is ???"),
                    dismissButton: .default(Text("Continue")) {
                      self.askQuestion()
              })
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            print("flagTapped - Correct")
        }else{
            scoreTitle = "Wrong"
            print("flagTapped -Wrong")
        }
    showingScore = true
    }
    
    func askQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
