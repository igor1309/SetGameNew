//
//  ContentView.swift
//  SetGame
//
//  Created by Igor Malyarov on 05.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    @ObservedObject var dealer = Dealer()
    
    @State private var engine: CHHapticEngine?
    
    @State private var showAlert = false
    @State private var showSheet = false
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button("New game") {
                        self.resetGame()
                    }
                    
                    Spacer()
                    
                    Button("?") {
                        self.showSheet = true
                    }
                    .padding(.trailing)
                    
                    Button("More") {
                        self.dealer.moreCards()
                    }
                }
                .padding(.horizontal)
                
                Text("Score: \(dealer.game.score)")
                    .foregroundColor(Color.orange)
                    .font(.headline)
                    .onTapGesture {
                        self.dealer.hint()
                }
            }
            
            Grid(dealer.cards()) { card in
                self.cardView(card)
            }
            .padding(.horizontal, 6)
            .onAppear {
                self.dealer.start()
            }
        }
        .background(Color.background.edgesIgnoringSafeArea(.all))
        .onAppear {
            self.prepareHaptics()
        }
        .onReceive(
            dealer.$game
                .map { $0.match }
        ) {
            self.showAlert = $0 != nil
            if $0 != nil {
                self.haptic(feedback: $0! ? .success : .error)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(dealer.game.match ?? false ? "Yay!" : "Oops…"),
                message: Text(dealer.game.result),
                dismissButton: .cancel(Text("OK")) {
                    //                    self.showAlert = false
                    self.dealer.continueGame()
                }
            )
        }
        .sheet(isPresented: $showSheet) {
            RulesView()
        }
    }
    
    private func resetGame() {
        self.dealer.resetGame()
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
                    ? Color.selectedCardBackground
                    : Color.cardBackground
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
                .border(card.isHinted
                    ? Color(UIColor.systemTeal)//.opacity(0.75)
                    : .clear)
                .padding(card.isHinted ? 3 : 0)
//                .shadow(
//                    color: card.isHinted
//                        ? Color(UIColor.systemTeal).opacity(0.75)
//                        : .clear, radius: 3, x: 0, y: 0
//            )
        }
        
        let transition = AnyTransition
            .move(edge: Edge.allCases.randomElement() ?? .top)
        //            .animation(.easeIn(duration: 5))
        
        return VStack {
            ForEach(0..<numberOfShapes) { _ in
                cardElement()
            }
        }
        .cardify(
            cornerRadius: cornerRadius,
            background: background(),
            transition: transition,
            animation: .easeInOut(duration: 0.6)
        )
            .onTapGesture {
                self.haptic(style: .light)
                withAnimation(.easeInOut) {
                    self.dealer.selectCard(card)
                }
        }
        .padding(6)
    }
    
    private let cornerRadius: CGFloat = 10
    
    //  MARK: - Haptics
    
    private func prepareHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            self.engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    
    private func haptic(
        feedback: UINotificationFeedbackGenerator.FeedbackType
    ) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(feedback)
    }
    
    private func haptic(
        style: UIImpactFeedbackGenerator.FeedbackStyle
    ) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewColorSchemes(.light)
    }
}
