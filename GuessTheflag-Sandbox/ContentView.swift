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
    
    
    //La parte del reto:
    @State private var score = 0
    
    var body: some View {
       
        ZStack {
            /*Color(red: 0 / 255,
                  green: 128 / 255,
                  blue: 128 / 255
                ).edgesIgnoringSafeArea(.all)*/
            
            LinearGradient(
            gradient: Gradient(colors: [Color(red: 0 / 255,
                                              green: 128 / 255,
                                              blue: 128 / 255),
                                        .black]),
            startPoint: .top,
            endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
        
            VStack(spacing: 30){
                VStack {
                    Text("Tap the flag of")
                        .font(.title)
                        .foregroundColor(.white)
                    
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                ForEach(0 ..< 3){ number in
                    Button(action: {
                        self.flagTapped(number)
                        print("You are tapped in the button: \(self.countries[number])")
                        }){
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule()
                                .stroke(Color.black     , lineWidth: 2))
                            .shadow(color: .gray, radius: 10)
                    }
                }
                
                Text("Your score is: \(score) points")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(2)
                    .font(.title)
                    
                Spacer()
            }
            
        }.alert(isPresented: $showingScore) {
            Alert(title: Text(scoreTitle),
                  message: Text("Your score is ???: \(score)"),
                    dismissButton: .default(Text("Continue")) {
                         
                      self.askQuestion()
              })
        }
    }
    
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct"
            score += 1
            print("flagTapped - Correct")
        }else{
            scoreTitle = "Wrong the flag is not correct: \(countries[correctAnswer])"
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
