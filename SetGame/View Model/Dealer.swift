//
//  Dealer.swift
//  SetGame
//
//  Created by Igor Malyarov on 05.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//

import SwiftUI

final class Dealer: ObservableObject {
    @Published var game: Game = Game()
    
    func selectCard(_ card: Card) {
        game.selectCard(card)
    }
    
    func reset() {
        game.reset()
    }
}
