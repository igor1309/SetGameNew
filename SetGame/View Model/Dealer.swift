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
    
    //  MARK: - Model access
    
    func cards() -> [Card] {
        game.cards()
    }
    
    //  MARK: - Intent(s)
    
    func start() {
        game.start()
    }
    
    func selectCard(_ card: Card) {
        game.selectCard(card)
    }
    
    func continueGame() {
        game.continueGame()
    }
    
    func moreCards() {
        game.moreCards()
    }
    
    func resetGame() {
        game.resetGame()
    }
    
    func hint() {
        game.hint()
    }
}
