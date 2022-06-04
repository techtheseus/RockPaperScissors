//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by whybhav on 04/06/22.
//

import SwiftUI

struct ContentView: View {
    
    @State private var currentTurn = Int.random(in: 0..<3)
    @State private var pickToPlay = Bool.random()
    @State private var score = 0
    @State private var round = 0
    @State private var gameComplete = false
    @State private var scoreTitle = ""
    
    var turns = ["👊", "🖐", "✌️"]
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.red, .orange, .yellow, .green, .blue, .purple], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Rock Paper Scissors")
                    .font(.largeTitle.bold())
                Spacer()
                VStack (spacing: 20) {
                    Text("Computer picked:")
                        .font(.title.bold())
                    Text(turns[currentTurn])
                        .font(.system(size: 75))
                        .shadow(radius: 5)
                    Text("Pick to \(pickToPlay ? "win" : "lose")")
                        .font(.title.bold())
                    HStack {
                        Group {
                            ForEach(0..<3) { number in
                                Button {
                                    tapped(number, pickToPlay)
                                    newTurn()
                                    pickToPlay.toggle()
                                } label: {
                                    Text(turns[number])
                                        .font(.system(size: 75))
                                        .shadow(radius: 5)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 20)
                
                Spacer()
                Spacer()
                
                Text("Round: \(round)/10")
                    .font(.title.bold())
                
                Spacer()
                
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $gameComplete) {
            Button("New Game", action: newGame)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func tapped (_ num: Int, _ value: Bool) {
            
        if (round < 9) {
            switch num {
                case 0:
                    if (currentTurn == 2 && value) || (currentTurn == 1 && !value){
                        score += 1
                        round += 1
                    } else {
                        score -= 1
                        round += 1
                    }
                case 1:
                    if (currentTurn == 0 && value) || (currentTurn == 2 && !value){
                        score += 1
                        round += 1
                    } else {
                        score -= 1
                        round += 1
                    }
                default:
                    if (currentTurn == 1 && value) || (currentTurn == 0 && !value) {
                        score += 1
                        round += 1
                    } else {
                        score -= 1
                        round += 1
                    }
            }
        } else {
            scoreTitle = "Game Completed 🥳"
            gameComplete = true
            score += 1
            round += 1
        }
    }
    
    func newTurn() {
        currentTurn = Int.random(in: 0..<3)
    }
    
    func newGame() {
            currentTurn = Int.random(in: 0..<3)
            score = 0
            round = 0
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
