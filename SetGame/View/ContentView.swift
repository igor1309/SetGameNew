//
//  ContentView.swift
//  SetGame
//
//  Created by Igor Malyarov on 05.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var dealer = Dealer()
    
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            ZStack {
                Text("\(dealer.draw) (\(dealer.game.cards().count))")
                    .foregroundColor(Color(UIColor.tertiaryLabel))
                    .font(.footnote)
                
                HStack {
                    Button("New game") {
                        self.resetGame()
                    }
                    
                    Spacer()
                    
                    Button("More") {
                        self.dealer.moreCards()
                    }
                }
                .padding(.horizontal)
            }
            
            Grid(dealer.cards()) { card in
                self.cardView(card)
            }
            .padding(.horizontal, 6)
            .onAppear {
                self.dealer.draw = 12
            }
        }
        .onReceive(dealer.$game) { game in
            self.showAlert = game.match != nil
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(dealer.game.match ?? false ? "Yay!" : "Oops…"),
                message: Text(dealer.game.result),
                dismissButton: .cancel(Text("OK")) {
                    self.resetGame()
                }
            )
        }
    }
    
    private func resetGame() {
        self.dealer.reset()
    }
    
    private func cardView(_ card: Card) -> some View {
        let numberOfShapes = card.numberOfShapes.rawValue
        
        func cardElement() -> some View {
            if card.shading == .open {
                return AnyView(
                    card.shape.shape
                        .stroke(card.color.color)
                )
            } else {
                return AnyView(
                    card.shape.shape
                        .foregroundColor(card.color.color)
                        .mask(card.shading.shading)
                )
            }
        }
        
        func background() -> some View {
            
            let color: Color = card.isMatch == nil
                ? card.isSelected
                    ? Color(UIColor.secondarySystemBackground)
                    : Color(UIColor.tertiarySystemFill)
                : card.isMatch! ? Color.green.opacity(0.2) : Color.red.opacity(0.2)
            
            let strokeColor: Color =
                card.isMatch == nil
                    ? card.isSelected ? Color.orange : .clear
                    : card.isMatch! ? Color.green : .red
            
            let lineWidth: CGFloat = card.isMatch == nil
                ? card.isSelected ? 3 : 0
                : card.isMatch! ? 8 : 6
            
            return color
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(strokeColor, lineWidth: lineWidth)
            )
        }
        
        let transition = AnyTransition.move(edge: Edge.allCases.randomElement() ?? .top)
        
        return VStack {
            ForEach(0..<numberOfShapes) { _ in
                cardElement()
            }
        }
        .cardify(
            cornerRadius: cornerRadius,
            background: background(),
            transition: transition,
            animation: .easeInOut(duration: 1)
        )
            .onTapGesture {
                withAnimation(.easeInOut) {
                    self.dealer.selectCard(card)
                }
        }
        .padding(6)
    }
    
    let cornerRadius: CGFloat = 10
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewColorSchemes(.light)
    }
}
