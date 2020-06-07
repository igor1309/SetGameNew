//
//  Game.swift
//  SetGame
//
//  Created by Igor Malyarov on 05.06.2020.
//  Copyright © 2020 Igor Malyarov. All rights reserved.
//
//  Stanford CS193p
//  https://cs193p.sites.stanford.edu
//  Assignment III: Set
//

import SwiftUI

struct Game {
    private(set) var deck: [Card]//Set<Card>
    
    private init(deck: Set<Card>) {
        self.deck = Array(deck)//deck
    }
    
    init() {
        self.init(deck: Game.createDeck())
    }
    
    static func createDeck() -> Set<Card> {
        let cards = Card.NumberOfShapes.allCases.flatMap { numberOfShapes in
            Card.CardShape.allCases.flatMap { shape in
                Card.CardColor.allCases.flatMap { color in
                    Card.CardShading.allCases.map { shading in
                        Card(numberOfShapes: numberOfShapes,
                             shape: shape,
                             color: color,
                             shading: shading)
                    }
                }
            }
        }
        return Set(cards)
    }
    
    private(set) var draw = 0
    
    private(set) var match: Bool?
    private(set) var result: String = ""
    private(set) var score: Int = 0
    
    private var selectedCards: [Card] { deck.filter { $0.isSelected } }
    
    //  MARK: - Model access
    
    func cards() -> [Card] {//SSet<Card> {
        Array(deck.prefix(draw))
    }
    
    //  MARK: - Hint
    
    mutating func hint() {
     
        func markHinted(cards: Card...) {
            for card in cards {
                guard let index = deck.firstIndex(of: card) else { continue }
                deck[index].isHinted = true
            }
        }
        
        let table = cards()
        
        search: for i in 0..<table.count - 1 {
            for j in i+1..<table.count - 1 {
                for k in j+1..<table.count - 1 {
                    let potentialSet = [table[i], table[j], table[k]]
                    let (match, _) = matchResult(cards: potentialSet)
                    if let match = match, match {
                        print("\(match) - \(i):\(j):\(k)")
                        markHinted(cards: table[i], table[j], table[k])
                        break search
                    }
                }
            }
        }
    }
    
    //  MARK: - Intent(s)
    
    mutating func start() {
        draw = 12
    }
    
    mutating func moreCards() {
        draw += 3
    }

    mutating func continueGame() {
        if match != nil {
            if match! {
                deleteSelectedCards()
                draw = 12
            } else {
                resetSelectedCards()
            }
            (match, result) = (nil, "")
        }
    }
    
    mutating func selectCard(_ card: Card) {
        
        if match == nil {
            toggleSelection(of: card)
        } else {
            continueGame()
        }
        
        guard selectedCards.count == 3 else { return }
        
        //  three cards selected
        (match, result) = matchResult(cards: selectedCards)
        if match! {
            score += 1
        }
        for card in selectedCards { markCard(card, match: match!) }
    }
    
    mutating func resetSelectedCards() {
        for card in selectedCards {
            guard let index = deck.firstIndex(of: card) else { continue }
            deck[index].isSelected = false
            deck[index].isMatch = nil
        }
    }
    
    mutating func toggleSelection(of card: Card) {
        guard let index = deck.firstIndex(of: card) else { return }
        deck[index].isSelected.toggle()
    }
    
    mutating func deleteSelectedCards() {
        for card in selectedCards {
            deck.removeAll(where: { $0.id == card.id })
        }
    }
    
    mutating func markCard(_ card: Card, match: Bool?) {
        guard let index = deck.firstIndex(of: card) else { return }
        
        deck[index].isMatch = match
    }
    
    func matchResult(cards: [Card]) -> (Bool?, String) {
        guard cards.count == 3 else { return (nil, "") }
        
        //  Сет состоит из трёх карт, которые удовлетворяют всем условиям:
        //  все карты имеют то же количество символов или же 3 различных значения;
        //  все карты имеют тот же символ или же 3 различных символа;
        //  все карты имеют ту же текстуру или же 3 различных варианта текстуры;
        //  все карты имеют тот же цвет или же 3 различных цвета.
        
        let condition1 = cards.map { $0.numberOfShapes }.allSameOrDifferent()
        let condition2 = cards.map { $0.shape }.allSameOrDifferent()
        let condition3 = cards.map { $0.color }.allSameOrDifferent()
        let condition4 = cards.map { $0.shading }.allSameOrDifferent()
        
        let match = condition1 && condition2 && condition3 && condition4
        
        let result1 = condition1 ? "" : "Number of shapes don't match."
        let result2 = condition2 ? "" : "Shapes don't match."
        let result3 = condition3 ? "" : "Colors don't match."
        let result4 = condition4 ? "" : "Shading don't match."
        
        let result = [result1, result2, result3, result4]
            .filter { !$0.isEmpty }
            .joined(separator: "\n")
        
        return (match, result.isEmpty ? "It's a match!!" : result)
    }
    
    mutating func resetGame() {
        deck = Array(Game.createDeck())
        draw = 12
        (match, result) = (nil, "")
        score = 0
    }
}
