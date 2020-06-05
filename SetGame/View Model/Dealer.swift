//
//  Dealer.swift
//  SetGame
//
//  Created by Igor Malyarov on 05.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

final class Dealer: ObservableObject {
    @Published private(set) var game: Game = Game()
    
    @Published var draw: Int = 0
    
    func cards() -> [Card] {
        Array(game.cards().prefix(draw))
    }
    
    func selectCard(_ card: Card) {
        game.selectCard(card)
    }
    
    func reset() {
        game.reset()
        draw = 12
    }
    
    func moreCards() {
        draw += 4
    }
}
