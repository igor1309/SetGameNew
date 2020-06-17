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
    
    @Published var showHint: Bool = false {
        didSet {
            game.hint(turnOn: showHint)
        }
    }
    
    //  MARK: - Model access
    
    func cards() -> [Card] {
        game.cards()
    }
    
    var moreCardsAvailiable: Bool { game.moreCardsAvailiable }
    
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
        showHint = false
    }
    
    func resetGame() {
        game.resetGame()
        showHint = false
    }
}
